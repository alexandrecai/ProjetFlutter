package fr.orleans.m1.wsi.biblioapi.modele;


import jakarta.persistence.*;

@Entity
@Table(name = "auteur")
public class Author {

    private String nom;
    private String prenom;
    private int id;

    public Author() {
    }

    public Author(int ID, String nom, String prenom) {
        this.id = ID;
        this.nom = nom;
        this.prenom = prenom;
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

    public void setId(int id) {
        this.id = id;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public int getId() {
        return id;
    }
}
