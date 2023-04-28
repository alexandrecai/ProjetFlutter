package fr.orleans.m1.wsi.biblioapi.controller;

import fr.orleans.m1.wsi.biblioapi.modele.Utilisateur;
import fr.orleans.m1.wsi.biblioapi.service.UtilisateurService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/utilisateurs")
public class UtilisateurController {

    private final UtilisateurService utilisateurService;

    public UtilisateurController(UtilisateurService utilisateurService) {
        this.utilisateurService = utilisateurService;
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
    public ResponseEntity<Utilisateur> createUtilisateur(@RequestBody Utilisateur utilisateur) {
        Utilisateur createdUtilisateur = utilisateurService.createUtilisateur(utilisateur);
        if (createdUtilisateur == null) {
            return ResponseEntity.badRequest().build();
        }
        return ResponseEntity.created(URI.create("/utilisateurs/" + createdUtilisateur.getId())).body(createdUtilisateur);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Utilisateur> updateUtilisateur(@PathVariable Long id, @RequestBody Utilisateur utilisateur) {
        Utilisateur updatedUtilisateur = utilisateurService.getUtilisateurById(id);
        if (updatedUtilisateur != null) {
            updatedUtilisateur.setNom(utilisateur.getNom());
            updatedUtilisateur.setPrenom(utilisateur.getPrenom());
            updatedUtilisateur.setMail(utilisateur.getMail());
            updatedUtilisateur.setMotDePasse(utilisateur.getMotDePasse());
            updatedUtilisateur.setAdmin(utilisateur.getAdmin());
            updatedUtilisateur.setLivresEmpruntes(utilisateur.getLivresEmpruntes());
            updatedUtilisateur.setWishlists(utilisateur.getWishlists());

            utilisateurService.updateUtilisateur(updatedUtilisateur);

            return ResponseEntity.ok(updatedUtilisateur);
        }

        return ResponseEntity.notFound().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteUtilisateur(@PathVariable Long id) {
        utilisateurService.deleteUtilisateurById(id);
        return ResponseEntity.noContent().build();
    }
}
