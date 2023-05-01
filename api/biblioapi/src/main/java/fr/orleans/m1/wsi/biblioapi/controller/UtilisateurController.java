package fr.orleans.m1.wsi.biblioapi.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import fr.orleans.m1.wsi.biblioapi.modele.Utilisateur;
import fr.orleans.m1.wsi.biblioapi.modele.Wishlist;
import fr.orleans.m1.wsi.biblioapi.service.UtilisateurService;
import fr.orleans.m1.wsi.biblioapi.service.WishlistService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.Collections;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/utilisateurs")
public class UtilisateurController {

    private final UtilisateurService utilisateurService;
    private final WishlistService wishlistService;

    public UtilisateurController(UtilisateurService utilisateurService, WishlistService wishlistService) {
        this.utilisateurService = utilisateurService;
        this.wishlistService = wishlistService;
    }

    @GetMapping("/{id}")
    public ResponseEntity<Utilisateur> getUtilisateurById(@PathVariable Long id) {
        Utilisateur utilisateur = utilisateurService.getUtilisateurById(id);
        if (utilisateur == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok().body(utilisateur);
    }

    @GetMapping("/")
    public ResponseEntity<List<Utilisateur>> getAllUtilisateurs() {
        List<Utilisateur> utilisateurs = utilisateurService.getAllUtilisateurs();
        if (utilisateurs.isEmpty()) {
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.ok().body(utilisateurs);
    }

    @PostMapping("/")
    public ResponseEntity<Utilisateur> createUtilisateur(@RequestBody JsonNode utilisateurNode) {
        ObjectMapper objectMapper = new ObjectMapper();
        Map utilisateurMap = objectMapper.convertValue(utilisateurNode, Map.class);

        String submittedMail = (String) utilisateurMap.get("mail");
        if(utilisateurService.getUtilisateurByMail(submittedMail) != null){
            return ResponseEntity.status(HttpStatus.CONFLICT).build();
        }

        Utilisateur utilisateur = new Utilisateur();
        utilisateur.setNom((String) utilisateurMap.get("nom"));
        utilisateur.setPrenom((String) utilisateurMap.get("prenom"));
        utilisateur.setMail((String) utilisateurMap.get("mail"));
        utilisateur.setMotDePasse((String) utilisateurMap.get("mot_de_passe"));
        utilisateur.setAdmin((Boolean) utilisateurMap.get("is_admin"));
        utilisateur.setLivresEmpruntes(Collections.emptyList());
        utilisateur.setWishlists(Collections.emptyList());

        Utilisateur createdUtilisateur = utilisateurService.createUtilisateur(utilisateur);
        if (createdUtilisateur == null) {
            return ResponseEntity.badRequest().build();
        }
        return ResponseEntity.created(URI.create("/utilisateurs/" + createdUtilisateur.getId())).body(createdUtilisateur);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Utilisateur> updateUtilisateur(@PathVariable Long id, @RequestBody JsonNode jsonNode) {
        Utilisateur updatedUtilisateur = utilisateurService.getUtilisateurById(id);
        if (updatedUtilisateur == null) {
            return ResponseEntity.notFound().build();
        }

        // Convertir JsonNode en Map
        ObjectMapper objectMapper = new ObjectMapper();
        Map<String, Object> userData = objectMapper.convertValue(jsonNode, new TypeReference<Map<String,Object>>() {});

        // Mettre à jour les propriétés de l'utilisateur
        if (userData.containsKey("nom")) {
            updatedUtilisateur.setNom((String) userData.get("nom"));
        }
        if (userData.containsKey("prenom")) {
            updatedUtilisateur.setPrenom((String) userData.get("prenom"));
        }
        if (userData.containsKey("mail")) {
            updatedUtilisateur.setMail((String) userData.get("mail"));
        }
        if (userData.containsKey("mot_de_passe")) {
            updatedUtilisateur.setMotDePasse((String) userData.get("mot_de_passe"));
        }
        if (userData.containsKey("is_admin")) {
            updatedUtilisateur.setAdmin((Boolean) userData.get("is_admin"));
        }

        Utilisateur _updatedUtilisateur = utilisateurService.updateUtilisateur(updatedUtilisateur);
        if (_updatedUtilisateur == null) {
            return ResponseEntity.badRequest().build();
        }
        return ResponseEntity.ok(_updatedUtilisateur);

    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteUtilisateur(@PathVariable Long id) {
        // On supprime les wishlists associées à l'utilisateur avant de le supprimer
        List<Wishlist> wishlists = wishlistService.getWishlistsByUtilisateurId(id);
        for(Wishlist w : wishlists){
            wishlistService.deleteWishlistById(w.getId());
        }
        utilisateurService.deleteUtilisateurById(id);
        return ResponseEntity.noContent().build();
    }
}
