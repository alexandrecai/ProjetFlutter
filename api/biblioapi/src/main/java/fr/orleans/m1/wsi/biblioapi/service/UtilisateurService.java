package fr.orleans.m1.wsi.biblioapi.service;

import fr.orleans.m1.wsi.biblioapi.modele.Utilisateur;
import fr.orleans.m1.wsi.biblioapi.repository.UtilisateurRepository;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class UtilisateurService {

    private final UtilisateurRepository utilisateurRepository;

    public UtilisateurService(UtilisateurRepository utilisateurRepository) {
        this.utilisateurRepository = utilisateurRepository;
    }

    public Utilisateur createUtilisateur(Utilisateur utilisateur) {
        return utilisateurRepository.save(utilisateur);
    }

    public List<Utilisateur> getAllUtilisateurs() {return utilisateurRepository.findAll();}

    public Utilisateur getUtilisateurById(Long utilisateurId) {
        Optional<Utilisateur> optionalUtilisateur = utilisateurRepository.findById(utilisateurId);
        if (optionalUtilisateur.isPresent()) {
            return optionalUtilisateur.get();
        } else {
            throw new EntityNotFoundException("Utilisateur with id " + utilisateurId + " not found");
        }
    }

    public Utilisateur getUtilisateurByMail(String utilisateurmail) {
        Optional<Utilisateur> optionalUtilisateur = Optional.ofNullable(utilisateurRepository.findByMail(utilisateurmail));
        return optionalUtilisateur.orElse(null);
    }

    public Utilisateur updateUtilisateur(Utilisateur utilisateur) {
        Optional<Utilisateur> optionalUtilisateur = utilisateurRepository.findById(utilisateur.getId());
        if (optionalUtilisateur.isPresent()) {
            return utilisateurRepository.save(utilisateur);
        } else {
            throw new EntityNotFoundException("Utilisateur with id " + utilisateur.getId() + " not found");
        }
    }

    public void deleteUtilisateurById(Long utilisateurId) {
        if (utilisateurRepository.existsById(utilisateurId)) {
            utilisateurRepository.deleteById(utilisateurId);
        } else {
            throw new EntityNotFoundException("Utilisateur with id " + utilisateurId + " not found");
        }
    }
}
