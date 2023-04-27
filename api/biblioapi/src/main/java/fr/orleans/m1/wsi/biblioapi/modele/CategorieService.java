package fr.orleans.m1.wsi.biblioapi.modele;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class CategorieService {

    @Autowired
    private CategorieRepository categorieRepository;

    public List<Categorie> getAllCategorie(){
        return categorieRepository.findAll();
    }

    public void addCategorie(Categorie categorie) {
        categorieRepository.save(categorie);
    }

    public Categorie getCategorie(Integer id) {
        return categorieRepository.findById(id).get();
    }

    public void deleteCategorie(Integer id) {
        categorieRepository.deleteById(id);
    }

}
