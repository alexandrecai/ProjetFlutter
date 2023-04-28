package fr.orleans.m1.wsi.biblioapi.modele;

import jakarta.persistence.*;

import java.io.Serializable;
import java.util.Objects;

@Entity
@Table(name = "wishlist")
public class Wishlist {

    @EmbeddedId
    private WishlistId id;

    @ManyToOne
    @MapsId("utilisateurId")
    @JoinColumn(name = "utilisateur_id")
    private Utilisateur utilisateur;

    @ManyToOne
    @MapsId("livreId")
    @JoinColumn(name = "livre_id")
    private Livre livre;

    public Wishlist() {}

    public Wishlist(Utilisateur utilisateur, Livre livre) {
        this.utilisateur = utilisateur;
        this.livre = livre;
        this.id = new WishlistId(utilisateur.getId(), livre.getId());
    }

    // Getters and setters

    public WishlistId getId() {
        return id;
    }

    public void setId(WishlistId id) {
        this.id = id;
    }

    public Utilisateur getUtilisateur() {
        return utilisateur;
    }

    public void setUtilisateur(Utilisateur utilisateur) {
        this.utilisateur = utilisateur;
    }

    public Livre getLivre() {
        return livre;
    }

    public void setLivre(Livre livre) {
        this.livre = livre;
    }

    // Embedded id class

    @Embeddable
    public static class WishlistId implements Serializable {

        private static final long serialVersionUID = 1L;

        private Long utilisateurId;
        private Long livreId;

        public WishlistId() {}

        public WishlistId(Long utilisateurId, Long livreId) {
            this.utilisateurId = utilisateurId;
            this.livreId = livreId;
        }

        // Getters and setters

        public Long getUtilisateurId() {
            return utilisateurId;
        }

        public void setUtilisateurId(Long utilisateurId) {
            this.utilisateurId = utilisateurId;
        }

        public Long getLivreId() {
            return livreId;
        }

        public void setLivreId(Long livreId) {
            this.livreId = livreId;
        }

        // Hashcode and equals

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            WishlistId that = (WishlistId) o;
            return Objects.equals(utilisateurId, that.utilisateurId) && Objects.equals(livreId, that.livreId);
        }

        @Override
        public int hashCode() {
            return Objects.hash(utilisateurId, livreId);
        }
    }
}

