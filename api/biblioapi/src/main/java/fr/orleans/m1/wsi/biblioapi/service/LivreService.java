package fr.orleans.m1.wsi.biblioapi.service;

import fr.orleans.m1.wsi.biblioapi.modele.Livre;
import fr.orleans.m1.wsi.biblioapi.repository.LivreRepository;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Transactional
public class LivreService {

    private final LivreRepository livreRepository;

    public LivreService(LivreRepository livreRepository) {
        this.livreRepository = livreRepository;
    }

    public List<Livre> getAllLivres() {
        return livreRepository.findAll();
    }

    public Livre getLivreById(Long livreId) {
        return livreRepository.findById(livreId).orElse(null);
    }

    public Livre saveLivre(Livre livre) {
        return livreRepository.save(livre);
    }

    public Livre updateLivre(Livre livre) {
        return livreRepository.save(livre);
    }

    public void deleteLivreById(Long livreId) {
        livreRepository.deleteById(livreId);
    }

    public List<Livre> getLivresByAuteurId(Long id) {
        return livreRepository.findByAuteur_Id(id);
    }

    public List<Livre> getLivresByMaisonEditionId(Long id) {return livreRepository.findByMaisonEdition_Id(id);}

    public List<Livre> getLivresByCategorieId(Long id) {
        return livreRepository.findByCategorie_Id(id);
    }

    public List<Livre> getLivresByNom(String nom) {
        return livreRepository.findByNomContainingIgnoreCase(nom);
    }
}

