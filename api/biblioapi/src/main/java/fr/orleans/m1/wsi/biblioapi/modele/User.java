package fr.orleans.m1.wsi.biblioapi.modele;

import java.util.List;

public class User {
    private int ID;
    private String nom;
    private String prenom;
    private String mail;
    private String password;
    private boolean isAdmin;
    private List<Book> wishlist;
    private List<Book> livresEmpruntes;

    public User(int ID, String nom, String prenom, String mail, String password, boolean isAdmin, List<Book> wishlist, List<Book> livresEmpruntes) {
        this.ID = ID;
        this.nom = nom;
        this.prenom = prenom;
        this.mail = mail;
        this.password = password;
        this.isAdmin = isAdmin;
        this.wishlist = wishlist;
        this.livresEmpruntes = livresEmpruntes;
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isAdmin() {
        return isAdmin;
    }

    public void setAdmin(boolean admin) {
        isAdmin = admin;
    }

    public List<Book> getWishlist() {
        return wishlist;
    }

    public void setWishlist(List<Book> wishlist) {
        this.wishlist = wishlist;
    }

    public List<Book> getLivresEmpruntes() {
        return livresEmpruntes;
    }

    public void setLivresEmpruntes(List<Book> livresEmpruntes) {
        this.livresEmpruntes = livresEmpruntes;
    }
}
