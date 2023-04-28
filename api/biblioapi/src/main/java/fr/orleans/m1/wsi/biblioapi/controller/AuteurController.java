package fr.orleans.m1.wsi.biblioapi.controller;

import fr.orleans.m1.wsi.biblioapi.modele.Auteur;
import fr.orleans.m1.wsi.biblioapi.service.AuteurService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/auteurs")
public class AuteurController {

    private final AuteurService auteurService;

    public AuteurController(AuteurService auteurService) {
        this.auteurService = auteurService;
    }

    @GetMapping("/")
    public List<Auteur> getAllAuteurs() {
        return auteurService.getAllAuteurs();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Auteur> getAuteurById(@PathVariable Long id) {
        Auteur auteur = auteurService.getAuteurById(id);
        if (auteur != null) {
            return ResponseEntity.ok(auteur);
        }
        return ResponseEntity.notFound().build();
    }

    @PostMapping("/")
    public ResponseEntity<Auteur> createAuteur(@RequestBody Auteur auteur) {
        Auteur savedAuteur = auteurService.saveAuteur(auteur);
        return ResponseEntity.created(URI.create("/auteurs/" + savedAuteur.getId())).body(savedAuteur);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Auteur> updateAuteur(@PathVariable Long id, @RequestBody Auteur auteur) {
        Auteur existingAuteur = auteurService.getAuteurById(id);
        if (existingAuteur != null) {
            existingAuteur.setNom(auteur.getNom());
            existingAuteur.setPrenom(auteur.getPrenom());

            auteurService.updateAuteur(existingAuteur);

            return ResponseEntity.ok(existingAuteur);
        }
        return ResponseEntity.notFound().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteAuteur(@PathVariable Long id) {
        auteurService.deleteAuteurById(id);
        return ResponseEntity.noContent().build();
    }
}
