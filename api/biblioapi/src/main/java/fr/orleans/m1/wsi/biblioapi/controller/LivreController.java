package fr.orleans.m1.wsi.biblioapi.controller;

import fr.orleans.m1.wsi.biblioapi.modele.Livre;
import fr.orleans.m1.wsi.biblioapi.service.LivreService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/livres")
public class LivreController {

    private final LivreService livreService;

    public LivreController(LivreService livreService) {
        this.livreService = livreService;
    }

    @GetMapping("/")
    public ResponseEntity<List<Livre>> getAllLivres() {
        List<Livre> livres = livreService.getAllLivres();
        if (livres.isEmpty()) {
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.ok(livres);
    }


    @GetMapping("/{id}")
    public ResponseEntity<Livre> getLivreById(@PathVariable Long id) {
        Livre livre = livreService.getLivreById(id);
        if (livre != null) {
            return ResponseEntity.ok(livre);
        }
        return ResponseEntity.notFound().build();
    }

    @GetMapping("/auteur/{id}")
    public List<Livre> getLivresByAuteurId(@PathVariable Long id) {
        return livreService.getLivresByAuteurId(id);
    }

    @GetMapping("/categorie/{id}")
    public List<Livre> getLivresByCategorieId(@PathVariable Long id) {
        return livreService.getLivresByCategorieId(id);
    }

    @GetMapping("/nom/{nom}")
    public ResponseEntity<List<Livre>> getLivresByNom(@PathVariable String nom) {
        List<Livre> livres = livreService.getLivresByNom(nom);
        if (!livres.isEmpty()) {
            return ResponseEntity.ok(livres);
        } else {
            return ResponseEntity.noContent().build();
        }
    }


    @PostMapping("/")
    public ResponseEntity<Livre> createLivre(@RequestBody Livre livre) {
        Livre savedLivre = livreService.saveLivre(livre);
        return ResponseEntity.created(URI.create("/livres/" + savedLivre.getId())).body(savedLivre);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Livre> updateLivre(@PathVariable Long id, @RequestBody Livre livre) {
        Livre existingLivre = livreService.getLivreById(id);
        if (existingLivre != null) {
            existingLivre.setNom(livre.getNom());
            existingLivre.setDescription(livre.getDescription());
            existingLivre.setCategorie(livre.getCategorie());
            existingLivre.setMaisonEdition(livre.getMaisonEdition());
            existingLivre.setAuteur(livre.getAuteur());
            existingLivre.setCote(livre.getCote());
            existingLivre.setISBN(livre.getISBN());
            existingLivre.setAnneeParution(livre.getAnneeParution());
            existingLivre.setStatut(livre.getStatut());
            existingLivre.setEmpruntePar(livre.getEmpruntePar());

            livreService.updateLivre(existingLivre);

            return ResponseEntity.ok(existingLivre);
        }
        return ResponseEntity.notFound().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteLivre(@PathVariable Long id) {
        livreService.deleteLivreById(id);
        return ResponseEntity.noContent().build();
    }

}

