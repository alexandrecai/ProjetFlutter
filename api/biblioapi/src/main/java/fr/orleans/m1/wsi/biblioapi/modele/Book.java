package fr.orleans.m1.wsi.biblioapi.modele;

import jakarta.persistence.*;

import java.io.Serializable;
import java.util.List;

@Entity
@Table(name = "livre")
public class Book implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int ID;
    @Column(name = "nom")
    private String name;
    @Column(name = "description")
    private String description;
    @ManyToOne
    @JoinColumn(name = "categorie")
    private Categorie categorie;
    @Column(name = "maisonEdition")
    private int maisonEdition;
    @ManyToOne
    @JoinColumn(name = "auteur")
    private Author author;
    @Column(name = "cote")
    private String cote;
    @Column(name = "ISBN")
    private String ISBN;
    @Column(name = "statut")
    private boolean isAvailable;
    @Column(name = "annee")
    private int releaseYear;

    public Book(int ID, String name, String description, Categorie categorie, int maisonEdition, Author author, String cote, String ISBN, boolean isAvailable, int releaseYear) {
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
    }

    public Book() {

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

    public int getMaisonEdition() {
        return maisonEdition;
    }

    public void setMaisonEdition(int maisonEdition) {
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

}
