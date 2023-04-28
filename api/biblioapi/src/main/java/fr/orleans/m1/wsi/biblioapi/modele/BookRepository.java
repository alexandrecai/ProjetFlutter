package fr.orleans.m1.wsi.biblioapi.modele;

import org.springframework.data.jpa.repository.JpaRepository;

public interface BookRepository extends JpaRepository<Book, Integer>{

}