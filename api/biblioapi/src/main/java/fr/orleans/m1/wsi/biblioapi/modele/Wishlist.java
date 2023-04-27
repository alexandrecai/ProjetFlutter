package fr.orleans.m1.wsi.biblioapi.modele;

import jakarta.persistence.*;

import java.io.Serializable;



public class Wishlist implements Serializable {

    @OneToOne
    @JoinColumn(name = "livre")
    private Book book;

    @OneToOne
    @JoinColumn(name = "utilisateur")
    private User user;
}
