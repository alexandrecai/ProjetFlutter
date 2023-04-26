package fr.orleans.m1.wsi.biblioapi.modele;

import java.util.List;

public class Book {

    private int ID;
    private String name;
    private String description;
    private Categorie categorie;
    private MaisonEdition maisonEdition;
    private Author author;
    private String cote;
    private String ISBN;
    private boolean isAvailable;
    private int releaseYear;
    private List<User> inWishlist;

    public Book(int ID, String name, String description, Categorie categorie, MaisonEdition maisonEdition, Author author, String cote, String ISBN, boolean isAvailable, int releaseYear, List<User> inWishlist) {
        this.ID = ID;
        this.name = name;
        this.description = description;
        this.categorie = categorie;
        this.maisonEdition = maisonEdition;
        this.author = author;
        this.cote = cote;
        this.ISBN = ISBN;
        this.isAvailable = isAvailable;
        this.releaseYear = releaseYear;
        this.inWishlist = inWishlist;
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public Author getAuthor() {
        return author;
    }

    public void setAuthor(Author author) {
        this.author = author;
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

    public boolean isAvailable() {
        return isAvailable;
    }

    public void setAvailable(boolean available) {
        isAvailable = available;
    }

    public int getReleaseYear() {
        return releaseYear;
    }

    public void setReleaseYear(int releaseYear) {
        this.releaseYear = releaseYear;
    }

    public List<User> getInWishlist() {
        return inWishlist;
    }

    public void setInWishlist(List<User> inWishlist) {
        this.inWishlist = inWishlist;
    }
}
