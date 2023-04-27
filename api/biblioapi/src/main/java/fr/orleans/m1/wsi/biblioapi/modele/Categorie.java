package fr.orleans.m1.wsi.biblioapi.modele;

public class Categorie {

    private String libelle;
    private int ID;

    public Categorie(String libelle, int ID) {
        this.libelle = libelle;
        this.ID = ID;
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
