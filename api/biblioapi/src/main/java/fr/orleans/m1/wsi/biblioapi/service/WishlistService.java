package fr.orleans.m1.wsi.biblioapi.service;

import fr.orleans.m1.wsi.biblioapi.modele.Wishlist;
import fr.orleans.m1.wsi.biblioapi.repository.WishlistRepository;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Transactional
public class WishlistService {

    private final WishlistRepository wishlistRepository;

    public WishlistService(WishlistRepository wishlistRepository) {
        this.wishlistRepository = wishlistRepository;
    }

    public List<Wishlist> getAllWishlists() {
        return wishlistRepository.findAll();
    }

    public Wishlist getWishlistById(Wishlist.WishlistId wishlistId) {
        return wishlistRepository.findById(wishlistId).orElse(null);
    }

    public Wishlist saveWishlist(Wishlist wishlist) {
        return wishlistRepository.save(wishlist);
    }

    public Wishlist updateWishlist(Wishlist wishlist) {
        return wishlistRepository.save(wishlist);
    }

    public void deleteWishlistById(Wishlist.WishlistId wishlistId) {
        wishlistRepository.deleteById(wishlistId);
    }

    public List<Wishlist> getWishlistsByUtilisateurId(Long id) {
        return wishlistRepository.findByUtilisateur_Id(id);
    }

    public List<Wishlist> getWishlistsByLivreId(Long id) {
        return wishlistRepository.findByLivre_Id(id);
    }

}

