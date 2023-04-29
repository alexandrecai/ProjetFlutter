package fr.orleans.m1.wsi.biblioapi.controller;

import fr.orleans.m1.wsi.biblioapi.modele.Categorie;
import fr.orleans.m1.wsi.biblioapi.modele.Livre;
import fr.orleans.m1.wsi.biblioapi.service.CategorieService;
import fr.orleans.m1.wsi.biblioapi.service.LivreService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/categories")
public class CategorieController {

    private final CategorieService categorieService;
    private final LivreService livreService;

    public CategorieController(CategorieService categorieService, LivreService livreService) {
        this.categorieService = categorieService;
        this.livreService = livreService;
    }

    @GetMapping("/")
    public ResponseEntity<List<Categorie>> getAllCategories() {
        List<Categorie> categories = categorieService.getAllCategories();
        if (categories.isEmpty()) {
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.ok(categories);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Categorie> getCategorieById(@PathVariable Long id) {
        Categorie categorie = categorieService.getCategorieById(id);
        if (categorie != null) {
            return ResponseEntity.ok(categorie);
        }
        return ResponseEntity.notFound().build();
    }

    @PostMapping("/")
    public ResponseEntity<Categorie> createCategorie(@RequestBody Categorie categorie) {
        Categorie savedCategorie = categorieService.createCategorie(categorie);
        return ResponseEntity.created(URI.create("/categories/" + savedCategorie.getId())).body(savedCategorie);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Categorie> updateCategorie(@PathVariable Long id, @RequestBody Categorie categorie) {
        Categorie existingCategorie = categorieService.getCategorieById(id);
        if (existingCategorie != null) {
            existingCategorie.setNom(categorie.getNom());

            categorieService.updateCategorie(existingCategorie);

            return ResponseEntity.ok(existingCategorie);
        }
        return ResponseEntity.notFound().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteCategorie(@PathVariable Long id) {
        // On modifie la catégorie des livres associés à cette catégorie
        List<Livre> livres = livreService.getLivresByCategorieId(id);
        for(Livre l : livres){
            l.setCategorie(null);
            livreService.updateLivre(l);
        }
        categorieService.deleteCategorieById(id);
        return ResponseEntity.noContent().build();
    }
}
