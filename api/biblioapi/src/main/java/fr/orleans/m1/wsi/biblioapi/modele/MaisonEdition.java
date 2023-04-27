package fr.orleans.m1.wsi.biblioapi.modele;

import java.util.List;

public class MaisonEdition {

    int ID;
    String name;
    List<Author> authorList;
    List<Book> bookList;

    public MaisonEdition(int ID, String name, List<Author> authorList, List<Book> bookList) {
        this.ID = ID;
        this.name = name;
        this.authorList = authorList;
        this.bookList = bookList;
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
