package fr.orleans.m1.wsi.biblioapi.modele;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class AuthorService {

    @Autowired
    private AuthorRepository authorRepository;

    public List<Author> getAllAuthor(){
        return authorRepository.findAll();
    }

    public void addAuthor(Author author) {
        authorRepository.save(author);
    }

    public Author getAuthor(Integer id) {
        return authorRepository.findById(id).get();
    }

    public void deleteAuthor(Integer id) {
        authorRepository.deleteById(id);
    }

}
