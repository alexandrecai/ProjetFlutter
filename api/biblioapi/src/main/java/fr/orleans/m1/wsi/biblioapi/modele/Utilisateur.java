package fr.orleans.m1.wsi.biblioapi.modele;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
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
    private String motDePasse;
    private Boolean isAdmin;

    @OneToMany(mappedBy = "empruntePar")
    @JsonManagedReference
    private List<Livre> livresEmpruntes;

    @OneToMany(mappedBy = "utilisateur")
    private List<Wishlist> wishlists;

    public Utilisateur() {}

    public Utilisateur(String nom, String prenom, String mail, String motDePasse, Boolean isAdmin) {
        this.nom = nom;
        this.prenom = prenom;
        this.mail = mail;
        this.motDePasse = motDePasse;
        this.isAdmin = isAdmin;
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
        return motDePasse;
    }

    public void setMotDePasse(String motDePasse) {
        this.motDePasse = motDePasse;
    }

    public Boolean getAdmin() {
        return isAdmin;
    }

    public void setAdmin(Boolean admin) {
        isAdmin = admin;
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
