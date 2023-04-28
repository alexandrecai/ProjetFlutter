package fr.orleans.m1.wsi.biblioapi.controller;

import fr.orleans.m1.wsi.biblioapi.modele.Wishlist;
import fr.orleans.m1.wsi.biblioapi.service.WishlistService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/wishlists")
public class WishlistController {

    private final WishlistService wishlistService;

    public WishlistController(WishlistService wishlistService) {
        this.wishlistService = wishlistService;
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
    public ResponseEntity<Wishlist> createWishlist(@RequestBody Wishlist wishlist) {
        Wishlist createdWishlist = wishlistService.saveWishlist(wishlist);
        return ResponseEntity.created(URI.create("/wishlists/" + createdWishlist.getId())).body(createdWishlist);
    }

    @PutMapping("/{utilisateurId}/{livreId}")
    public ResponseEntity<Wishlist> updateWishlist(@PathVariable Long utilisateurId, @PathVariable Long livreId, @RequestBody Wishlist wishlist) {
        Wishlist.WishlistId wishlistId = new Wishlist.WishlistId(utilisateurId, livreId);
        Wishlist existingWishlist = wishlistService.getWishlistById(wishlistId);
        if (existingWishlist != null){
            existingWishlist.setLivre(wishlist.getLivre());
            existingWishlist.setUtilisateur(wishlist.getUtilisateur());

            wishlistService.updateWishlist(wishlist);

            return ResponseEntity.ok(existingWishlist);
        }
        return ResponseEntity.notFound().build();
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

