package fr.orleans.m1.wsi.biblioapi.modele;

import jakarta.persistence.*;

import java.io.Serializable;
import java.util.List;
@Entity
@Table(name = "utilisateur")
public class User implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int ID;
    @Column(name = "nom")
    private String nom;
    @Column(name = "prenom")
    private String prenom;
    @Column(name = "mail")
    private String mail;
    @Column(name = "mdp")
    private String password;
    @Column(name = "isAdmin")
    private boolean isAdmin;
    @OneToMany
    @JoinColumn(name = "livreEmprunte")
    private List<Book> livresEmpruntes;

    public User(int ID, String nom, String prenom, String mail, String password, boolean isAdmin, List<Book> livresEmpruntes) {
        this.ID = ID;
        this.nom = nom;
        this.prenom = prenom;
        this.mail = mail;
        this.password = password;
        this.isAdmin = isAdmin;
        this.livresEmpruntes = livresEmpruntes;
    }

    public User() {

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

    public List<Book> getLivresEmpruntes() {
        return livresEmpruntes;
    }

    public void setLivresEmpruntes(List<Book> livresEmpruntes) {
        this.livresEmpruntes = livresEmpruntes;
    }
}
