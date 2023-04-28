package fr.orleans.m1.wsi.biblioapi.modele;

import jakarta.persistence.*;

import java.io.Serializable;

@Entity
@Table(name = "categorie")
public class Categorie implements Serializable {
    @Column(name = "nom")
    private String libelle;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int ID;

    public Categorie(String libelle, int ID) {
        this.libelle = libelle;
        this.ID = ID;
    }

    public Categorie() {

    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }
}
