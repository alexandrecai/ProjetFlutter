package fr.orleans.m1.wsi.biblioapi.repository;

import fr.orleans.m1.wsi.biblioapi.modele.Livre;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface LivreRepository extends JpaRepository<Livre, Long> {
    List<Livre> findByNomContainingIgnoreCase(String nom);
    List<Livre> findByAuteur_Id(Long auteurId);
    List<Livre> findByCategorie_Id(Long categorieId);
}