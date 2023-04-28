package fr.orleans.m1.wsi.biblioapi.modele;

import jakarta.persistence.*;

import java.io.Serializable;
import java.util.List;

@Entity
@Table(name = "maisonedition")
public class MaisonEdition implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    int ID;
    @Column(name = "nom")
    String name;

    @OneToMany
    @JoinColumn(name = "auteurs")
    List<Author> authorList;
    @OneToMany
    @JoinColumn(name = "livres")
    List<Book> bookList;

    public MaisonEdition(int ID, String name, List<Author> authorList, List<Book> bookList) {
        this.ID = ID;
        this.name = name;
        this.authorList = authorList;
        this.bookList = bookList;
    }

    public MaisonEdition() {

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

    public List<Author> getAuthorList() {
        return authorList;
    }

    public void setAuthorList(List<Author> authorList) {
        this.authorList = authorList;
    }

    public List<Book> getBookList() {
        return bookList;
    }

    public void setBookList(List<Book> bookList) {
        this.bookList = bookList;
    }
}
