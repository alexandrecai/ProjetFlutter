package fr.orleans.m1.wsi.biblioapi.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import fr.orleans.m1.wsi.biblioapi.modele.Livre;
import fr.orleans.m1.wsi.biblioapi.modele.MaisonEdition;
import fr.orleans.m1.wsi.biblioapi.service.LivreService;
import fr.orleans.m1.wsi.biblioapi.service.MaisonEditionService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/maisoneditions")
public class MaisonEditionController {

    private final MaisonEditionService maisonEditionService;
    private final LivreService livreService;

    public MaisonEditionController(MaisonEditionService maisonEditionService, LivreService livreService) {
        this.maisonEditionService = maisonEditionService;
        this.livreService = livreService;
    }

    @GetMapping("/{id}")
    public ResponseEntity<MaisonEdition> getMaisonEditionById(@PathVariable Long id) {
        MaisonEdition maisonEdition = maisonEditionService.getMaisonEditionById(id);
        if (maisonEdition != null) {
            return ResponseEntity.ok(maisonEdition);
        }
        return ResponseEntity.notFound().build();
    }

    @GetMapping("/")
    public ResponseEntity<List<MaisonEdition>> getAllMaisonEditions() {
        List<MaisonEdition> maisonEditions = maisonEditionService.getAllMaisonEditions();
        if (maisonEditions.isEmpty()){
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.ok(maisonEditions);
    }

    @PostMapping("/")
    public ResponseEntity<MaisonEdition> createMaisonEdition(@RequestBody JsonNode jsonNode) {
        ObjectMapper objectMapper = new ObjectMapper();
        Map maisonEditionMap = objectMapper.convertValue(jsonNode, Map.class);

        MaisonEdition maisonEdition = new MaisonEdition((String) maisonEditionMap.get("nom"));

        MaisonEdition savedMaisonEdition = maisonEditionService.createMaisonEdition(maisonEdition);
        return ResponseEntity.created(URI.create("/maisoneditions/" + savedMaisonEdition.getId())).body(savedMaisonEdition);
    }

    @PutMapping("/{id}")
    public ResponseEntity<MaisonEdition> updateMaisonEdition(@PathVariable Long id, @RequestBody JsonNode jsonNode) {
        MaisonEdition existingMaisonEdition = maisonEditionService.getMaisonEditionById(id);
        if (existingMaisonEdition == null) {
            return ResponseEntity.notFound().build();
        }

        ObjectMapper objectMapper = new ObjectMapper();
        Map maisonEditionMap = objectMapper.convertValue(jsonNode, Map.class);

        if (maisonEditionMap.containsKey("nom")) {
            existingMaisonEdition.setNom((String) maisonEditionMap.get("nom"));
        }


        MaisonEdition maisonEdition = maisonEditionService.updateMaisonEdition(existingMaisonEdition);

        if (maisonEdition == null){
            return ResponseEntity.badRequest().build();
        }
        return ResponseEntity.ok(maisonEdition);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteMaisonEdition(@PathVariable Long id) {
        List<Livre> livres = livreService.getLivresByMaisonEditionId(id);
        if (livres.isEmpty()){
            maisonEditionService.deleteMaisonEditionById(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.status(HttpStatus.CONFLICT).build();
    }

}

