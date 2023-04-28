package fr.orleans.m1.wsi.biblioapi.service;

import fr.orleans.m1.wsi.biblioapi.modele.Auteur;
import fr.orleans.m1.wsi.biblioapi.repository.AuteurRepository;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Transactional
public class AuteurService {

    private final AuteurRepository auteurRepository;

    public AuteurService(AuteurRepository auteurRepository) {
        this.auteurRepository = auteurRepository;
    }

    public List<Auteur> getAllAuteurs() {
        return auteurRepository.findAll();
    }

    public Auteur getAuteurById(Long auteurId) {
        return auteurRepository.findById(auteurId).orElse(null);
    }

    public Auteur saveAuteur(Auteur auteur) {
        return auteurRepository.save(auteur);
    }

    public Auteur updateAuteur(Auteur auteur) {
        return auteurRepository.save(auteur);
    }

    public void deleteAuteurById(Long auteurId) {
        auteurRepository.deleteById(auteurId);
    }

}

