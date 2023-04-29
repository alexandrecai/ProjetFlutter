package fr.orleans.m1.wsi.biblioapi.controller;

import fr.orleans.m1.wsi.biblioapi.modele.Livre;
import fr.orleans.m1.wsi.biblioapi.modele.MaisonEdition;
import fr.orleans.m1.wsi.biblioapi.service.LivreService;
import fr.orleans.m1.wsi.biblioapi.service.MaisonEditionService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

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
    public ResponseEntity<MaisonEdition> addMaisonEdition(@RequestBody MaisonEdition maisonEdition) {
        MaisonEdition savedMaisonEdition = maisonEditionService.createMaisonEdition(maisonEdition);
        return ResponseEntity.created(URI.create("/maisoneditions/" + savedMaisonEdition.getId())).body(savedMaisonEdition);
    }

    @PutMapping("/{id}")
    public ResponseEntity<MaisonEdition> updateMaisonEdition(@PathVariable Long id, @RequestBody MaisonEdition maisonEdition) {
        MaisonEdition existingMaisonEdition = maisonEditionService.getMaisonEditionById(id);
        if (existingMaisonEdition != null) {
            existingMaisonEdition.setNom(maisonEdition.getNom());
            existingMaisonEdition.setLivres(maisonEdition.getLivres());

            maisonEditionService.updateMaisonEdition(existingMaisonEdition);

            return ResponseEntity.ok(existingMaisonEdition);
        }
        return ResponseEntity.notFound().build();
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

