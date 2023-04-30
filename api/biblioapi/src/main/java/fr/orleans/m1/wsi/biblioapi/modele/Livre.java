package fr.orleans.m1.wsi.biblioapi.modele;

import com.fasterxml.jackson.annotation.*;
import jakarta.persistence.*;

@Entity
@Table(name = "livre")
public class Livre {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nom;

    private String description;

    @ManyToOne
    @JoinColumn(name = "categorie_id", referencedColumnName = "id")
    private Categorie categorie;

    @ManyToOne
    @JoinColumn(name = "maisonedition_id", referencedColumnName = "id", nullable = false)
    @JsonManagedReference
    private MaisonEdition maisonEdition;

    @ManyToOne
    @JoinColumn(name = "auteur_id", referencedColumnName = "id", nullable = false)
    private Auteur auteur;

    private String cote;

    private String ISBN;

    @Column(name = "annee_parution")
    private Integer anneeParution;

    @Enumerated(EnumType.STRING)
    private LivreStatut statut;

    @ManyToOne
    @JoinColumn(name = "emprunte_par", referencedColumnName = "id")
    @JsonBackReference
    private Utilisateur empruntePar;

    // Constructors

    public Livre() {}

    public Livre(Long id, String nom, String description, Categorie categorie, MaisonEdition maisonEdition, Auteur auteur, String cote, String ISBN, Integer anneeParution, LivreStatut statut, Utilisateur empruntePar) {
        this.id = id;
        this.nom = nom;
        this.description = description;
        this.categorie = categorie;
        this.maisonEdition = maisonEdition;
        this.auteur = auteur;
        this.cote = cote;
        this.ISBN = ISBN;
        this.anneeParution = anneeParution;
        this.statut = statut;
        this.empruntePar = empruntePar;
    }

    // Getters and setters


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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Categorie getCategorie() {
        return categorie;
    }

    public void setCategorie(Categorie categorie) {
        this.categorie = categorie;
    }

    public MaisonEdition getMaisonEdition() {
        return maisonEdition;
    }

    public void setMaisonEdition(MaisonEdition maisonEdition) {
        this.maisonEdition = maisonEdition;
    }

    public Auteur getAuteur() {
        return auteur;
    }

    public void setAuteur(Auteur auteur) {
        this.auteur = auteur;
    }

    public String getCote() {
        return cote;
    }

    public void setCote(String cote) {
        this.cote = cote;
    }

    public String getISBN() {
        return ISBN;
    }

    public void setISBN(String ISBN) {
        this.ISBN = ISBN;
    }

    public Integer getAnneeParution() {
        return anneeParution;
    }

    public void setAnneeParution(Integer anneeParution) {
        this.anneeParution = anneeParution;
    }

    public LivreStatut getStatut() {
        return statut;
    }

    public void setStatut(LivreStatut statut) {
        this.statut = statut;
    }

    public Utilisateur getEmpruntePar() {
        return empruntePar;
    }

    public void setEmpruntePar(Utilisateur empruntePar) {
        this.empruntePar = empruntePar;
    }
}
