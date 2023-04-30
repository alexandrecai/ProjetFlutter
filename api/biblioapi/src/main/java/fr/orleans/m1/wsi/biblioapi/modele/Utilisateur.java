package fr.orleans.m1.wsi.biblioapi.modele;

import com.fasterxml.jackson.annotation.*;
import jakarta.persistence.*;

import java.util.List;

@Entity
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
public class Utilisateur {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nom;
    private String prenom;
    private String mail;
    private String mot_de_passe;
    private Boolean is_admin;

    @OneToMany(mappedBy = "empruntePar")
    @JsonManagedReference
    private List<Livre> livresEmpruntes;

    @OneToMany(mappedBy = "utilisateur")
    private List<Wishlist> wishlists;

    public Utilisateur() {}

    public Utilisateur(String nom, String prenom, String mail, String mot_de_passe, Boolean is_admin) {
        this.nom = nom;
        this.prenom = prenom;
        this.mail = mail;
        this.mot_de_passe = mot_de_passe;
        this.is_admin = is_admin;
    }

    // getters and setters


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getMotDePasse() {
        return mot_de_passe;
    }

    public void setMotDePasse(String motDePasse) {
        this.mot_de_passe = motDePasse;
    }

    public Boolean getAdmin() {
        return is_admin;
    }

    public void setAdmin(Boolean admin) {
        is_admin = admin;
    }

    public List<Livre> getLivresEmpruntes() {
        return livresEmpruntes;
    }

    public void setLivresEmpruntes(List<Livre> livresEmpruntes) {
        this.livresEmpruntes = livresEmpruntes;
    }

    public List<Wishlist> getWishlists() {
        return wishlists;
    }

    public void setWishlists(List<Wishlist> wishlists) {
        this.wishlists = wishlists;
    }
}
