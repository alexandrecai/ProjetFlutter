package fr.orleans.m1.wsi.biblioapi.repository;

import fr.orleans.m1.wsi.biblioapi.modele.Utilisateur;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UtilisateurRepository extends JpaRepository<Utilisateur, Long> {
    Utilisateur findByMail(String mail);
}
