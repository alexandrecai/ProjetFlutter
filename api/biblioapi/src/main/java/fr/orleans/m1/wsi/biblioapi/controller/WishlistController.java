package fr.orleans.m1.wsi.biblioapi.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import fr.orleans.m1.wsi.biblioapi.modele.Livre;
import fr.orleans.m1.wsi.biblioapi.modele.Wishlist;
import fr.orleans.m1.wsi.biblioapi.service.LivreService;
import fr.orleans.m1.wsi.biblioapi.service.UtilisateurService;
import fr.orleans.m1.wsi.biblioapi.service.WishlistService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/wishlists")
public class WishlistController {

    private final WishlistService wishlistService;
    private final UtilisateurService utilisateurService;
    private final LivreService livreService;

    public WishlistController(WishlistService wishlistService, UtilisateurService utilisateurService, LivreService livreService) {
        this.wishlistService = wishlistService;
        this.utilisateurService = utilisateurService;
        this.livreService = livreService;
    }

    @GetMapping("/")
    public ResponseEntity<List<Wishlist>> getAllWishlists() {
        List<Wishlist> wishlists = wishlistService.getAllWishlists();
        if (wishlists.isEmpty()){
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.ok(wishlists);
    }

    @GetMapping("/{utilisateurId}/{livreId}")
    public ResponseEntity<Wishlist> getWishlist(@PathVariable Long utilisateurId, @PathVariable Long livreId) {
        Wishlist.WishlistId wishlistId = new Wishlist.WishlistId(utilisateurId, livreId);
        Wishlist wishlist = wishlistService.getWishlistById(wishlistId);
        if (wishlist != null) {
            return ResponseEntity.ok(wishlist);
        }
        return ResponseEntity.notFound().build();
    }

    @PostMapping("/")
    public ResponseEntity<Wishlist> createWishlist(@RequestBody JsonNode jsonNode) {
        ObjectMapper objectMapper = new ObjectMapper();
        Map wishlistMap = objectMapper.convertValue(jsonNode, Map.class);

        Wishlist wishlist = new Wishlist();
        wishlist.setUtilisateur(utilisateurService.getUtilisateurById(((Number) wishlistMap.get("utilisateur_id")).longValue()));
        wishlist.setLivre(livreService.getLivreById(((Number) wishlistMap.get("livre_id")).longValue()));
        wishlist.setId(new Wishlist.WishlistId(((Number) wishlistMap.get("utilisateur_id")).longValue(),((Number) wishlistMap.get("livre_id")).longValue()));

        Wishlist createdWishlist = wishlistService.saveWishlist(wishlist);
        if (createdWishlist == null) {
            return ResponseEntity.badRequest().build();
        }
        return ResponseEntity.created(URI.create("/wishlists/" + createdWishlist.getId())).body(createdWishlist);
    }

    @PutMapping("/{utilisateurId}/{livreId}")
    public ResponseEntity<Wishlist> updateWishlist(@PathVariable Long utilisateurId, @PathVariable Long livreId, @RequestBody JsonNode jsonNode) {
        Wishlist.WishlistId wishlistId = new Wishlist.WishlistId(utilisateurId, livreId);
        Wishlist existingWishlist = wishlistService.getWishlistById(wishlistId);
        if (existingWishlist == null) {
            return ResponseEntity.notFound().build();
        }

        ObjectMapper objectMapper = new ObjectMapper();
        Map wishlistMap = objectMapper.convertValue(jsonNode, Map.class);

        if (wishlistMap.containsKey("utilisateur_id") && wishlistMap.containsKey("livre_id")) {
            wishlistService.deleteWishlistById(wishlistId);

            Wishlist wishlist = new Wishlist();
            wishlist.setUtilisateur(utilisateurService.getUtilisateurById(((Number) wishlistMap.get("utilisateur_id")).longValue()));
            wishlist.setLivre(livreService.getLivreById(((Number) wishlistMap.get("livre_id")).longValue()));
            wishlist.setId(new Wishlist.WishlistId(((Number) wishlistMap.get("utilisateur_id")).longValue(),((Number) wishlistMap.get("livre_id")).longValue()));

            Wishlist _wishlist = wishlistService.saveWishlist(wishlist);

            return ResponseEntity.ok(_wishlist);
        }

        return ResponseEntity.badRequest().build();
    }


    @DeleteMapping("/{utilisateurId}/{livreId}")
    public ResponseEntity<Void> deleteWishlist(@PathVariable Long utilisateurId, @PathVariable Long livreId) {
        Wishlist.WishlistId wishlistId = new Wishlist.WishlistId(utilisateurId, livreId);
        wishlistService.deleteWishlistById(wishlistId);
        return ResponseEntity.noContent().build();

    }

    @GetMapping("/utilisateur/{id}")
    public List<Wishlist> getWishlistsByUtilisateurId(@PathVariable Long id) {
        return wishlistService.getWishlistsByUtilisateurId(id);
    }
    @GetMapping("/livre/{id}")
    public List<Wishlist> getWishlistsByLivreId(@PathVariable Long id) {
        return wishlistService.getWishlistsByLivreId(id);
    }
}

