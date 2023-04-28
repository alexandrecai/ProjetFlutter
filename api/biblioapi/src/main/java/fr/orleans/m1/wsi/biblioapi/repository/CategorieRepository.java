package fr.orleans.m1.wsi.biblioapi.repository;

import fr.orleans.m1.wsi.biblioapi.modele.Categorie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CategorieRepository extends JpaRepository<Categorie, Long> {
}
