package fr.orleans.m1.wsi.biblioapi.repository;

import fr.orleans.m1.wsi.biblioapi.modele.Wishlist;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface WishlistRepository extends JpaRepository<Wishlist, Wishlist.WishlistId> {
    List<Wishlist> findByUtilisateur_Id(Long utilisateurId);
    List<Wishlist> findByLivre_Id(Long livreId);
}