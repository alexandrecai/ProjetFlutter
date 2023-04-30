package fr.orleans.m1.wsi.biblioapi.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import fr.orleans.m1.wsi.biblioapi.modele.Livre;
import fr.orleans.m1.wsi.biblioapi.modele.LivreStatut;
import fr.orleans.m1.wsi.biblioapi.modele.Wishlist;
import fr.orleans.m1.wsi.biblioapi.repository.AuteurRepository;
import fr.orleans.m1.wsi.biblioapi.service.*;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/livres")
public class LivreController {

    private final LivreService livreService;
    private final WishlistService wishlistService;
    private final CategorieService categorieService;
    private final MaisonEditionService maisonEditionService;
    private final AuteurService auteurService;
    private final UtilisateurService utilisateurService;

    public LivreController(LivreService livreService, WishlistService wishlistService, CategorieService categorieService, MaisonEditionService maisonEditionService, AuteurService auteurService, UtilisateurService utilisateurService) {
        this.livreService = livreService;
        this.wishlistService = wishlistService;
        this.categorieService = categorieService;
        this.maisonEditionService = maisonEditionService;
        this.auteurService = auteurService;
        this.utilisateurService = utilisateurService;
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

    @GetMapping("/emprunte-par/{utilisateurId}")
    public ResponseEntity<List<Livre>> getLivresEmpruntesByUtilisateurId(@PathVariable Long utilisateurId) {
        List<Livre> livresEmpruntes = livreService.getLivresEmpruntesByUtilisateurId(utilisateurId);
        if (livresEmpruntes.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(livresEmpruntes);
    }


    @PostMapping("/")
    public ResponseEntity<Livre> createLivre(@RequestBody JsonNode livreNode) {
        ObjectMapper objectMapper = new ObjectMapper();
        Map livreMap = objectMapper.convertValue(livreNode, Map.class);

        Livre livre = new Livre();
        livre.setNom((String) livreMap.get("nom"));
        livre.setDescription((String) livreMap.get("description"));
        livre.setCategorie(categorieService.getCategorieById(((Number) livreMap.get("categorie")).longValue()));
        livre.setMaisonEdition(maisonEditionService.getMaisonEditionById(((Number) livreMap.get("maison_edition")).longValue()));
        livre.setAuteur(auteurService.getAuteurById(((Number) livreMap.get("auteur")).longValue()));
        livre.setCote((String) livreMap.get("cote"));
        livre.setISBN((String) livreMap.get("ISBN"));
        livre.setStatut((boolean) livreMap.get("statut") ? LivreStatut.LIBRE : LivreStatut.EMPRUNTE);
        livre.setAnneeParution((Integer) livreMap.get("annee"));
        livre.setEmpruntePar(null);

        Livre savedLivre = livreService.saveLivre(livre);
        if (savedLivre == null) {
            return ResponseEntity.badRequest().build();
        }
        return ResponseEntity.created(URI.create("/livres/" + savedLivre.getId())).body(savedLivre);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Livre> updateLivre(@PathVariable Long id, @RequestBody JsonNode jsonNode) {
        Livre existingLivre = livreService.getLivreById(id);
        if (existingLivre == null) {
            return ResponseEntity.notFound().build();
        }

        // Convertir JsonNode en Map
        ObjectMapper objectMapper = new ObjectMapper();
        Map<String, Object> bookData = objectMapper.convertValue(jsonNode, new TypeReference<Map<String,Object>>() {});

        if (bookData.containsKey("nom")) {
            existingLivre.setNom((String) bookData.get("nom"));
        }
        if (bookData.containsKey("description")) {
            existingLivre.setDescription((String) bookData.get("description"));
        }
        if (bookData.containsKey("categorie")) {
            existingLivre.setCategorie(categorieService.getCategorieById(((Number) bookData.get("categorie")).longValue()));

        }
        if (bookData.containsKey("maison_edition")) {
            existingLivre.setMaisonEdition(maisonEditionService.getMaisonEditionById(((Number) bookData.get("maison_edition")).longValue()));
        }
        if (bookData.containsKey("auteur")) {
            existingLivre.setAuteur(auteurService.getAuteurById(((Number) bookData.get("auteur")).longValue()));
        }
        if (bookData.containsKey("cote")) {
            existingLivre.setCote((String) bookData.get("cote"));
        }
        if (bookData.containsKey("ISBN")) {
            existingLivre.setISBN((String) bookData.get("ISBN"));
        }
        if (bookData.containsKey("statut")) {
            existingLivre.setStatut((boolean) bookData.get("statut") ? LivreStatut.LIBRE : LivreStatut.EMPRUNTE);
        }
        if (bookData.containsKey("annee")) {
            existingLivre.setAnneeParution((Integer) bookData.get("annee"));
        }
        if (bookData.containsKey("emprunte_par")) {
            existingLivre.setEmpruntePar(utilisateurService.getUtilisateurById(((Number) bookData.get("emprunte_par")).longValue()));
        }

        Livre updatedLivre = livreService.updateLivre(existingLivre);
        if (updatedLivre == null) {
            return ResponseEntity.badRequest().build();
        }
        return ResponseEntity.ok(existingLivre);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteLivre(@PathVariable Long id) {
        // On supprime les wishlists associées au livre avant de le supprimer
        List<Wishlist> wishlists = wishlistService.getWishlistsByLivreId(id);
        for(Wishlist w : wishlists){
            wishlistService.deleteWishlistById(w.getId());
        }
        livreService.deleteLivreById(id);
        return ResponseEntity.noContent().build();
    }

}

