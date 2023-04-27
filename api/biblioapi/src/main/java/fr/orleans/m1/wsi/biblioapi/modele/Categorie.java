package fr.orleans.m1.wsi.biblioapi.modele;

import jakarta.persistence.*;

import java.io.Serializable;

@Entity
@Table(name = "categorie")
public class Categorie implements Serializable {
    @Column(name = "nom")
    private String nom;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int ID;

    public Categorie(String nom, int ID) {
        this.nom = nom;
        this.ID = ID;
    }

    public Categorie() {

    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }
}
