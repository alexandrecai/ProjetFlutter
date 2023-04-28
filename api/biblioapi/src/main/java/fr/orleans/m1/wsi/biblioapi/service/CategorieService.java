package fr.orleans.m1.wsi.biblioapi.service;

import fr.orleans.m1.wsi.biblioapi.modele.Categorie;
import fr.orleans.m1.wsi.biblioapi.repository.CategorieRepository;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Transactional
public class CategorieService {

    private final CategorieRepository categorieRepository;

    public CategorieService(CategorieRepository categorieRepository) {
        this.categorieRepository = categorieRepository;
    }

    public List<Categorie> getAllCategories() {
        return categorieRepository.findAll();
    }

    public Categorie getCategorieById(Long categorieId) {
        return categorieRepository.findById(categorieId).orElse(null);
    }

    public Categorie createCategorie(Categorie categorie) {
        return categorieRepository.save(categorie);
    }

    public Categorie updateCategorie(Categorie categorie) {
        return categorieRepository.save(categorie);
    }

    public void deleteCategorieById(Long categorieId) {
        categorieRepository.deleteById(categorieId);
    }
}

