package fr.orleans.m1.wsi.biblioapi.service;

import fr.orleans.m1.wsi.biblioapi.modele.MaisonEdition;
import fr.orleans.m1.wsi.biblioapi.repository.MaisonEditionRepository;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Transactional
public class MaisonEditionService {

    private final MaisonEditionRepository maisonEditionRepository;

    public MaisonEditionService(MaisonEditionRepository maisonEditionRepository) {
        this.maisonEditionRepository = maisonEditionRepository;
    }

    public List<MaisonEdition> getAllMaisonEditions() {
        return maisonEditionRepository.findAll();
    }

    public MaisonEdition getMaisonEditionById(Long maisonEditionId) {
        return maisonEditionRepository.findById(maisonEditionId).orElse(null);
    }

    public MaisonEdition createMaisonEdition(MaisonEdition maisonEdition) {
        return maisonEditionRepository.save(maisonEdition);
    }

    public MaisonEdition updateMaisonEdition(MaisonEdition maisonEdition) {
        return maisonEditionRepository.save(maisonEdition);
    }

    public void deleteMaisonEditionById(Long maisonEditionId) {
        maisonEditionRepository.deleteById(maisonEditionId);
    }
}

