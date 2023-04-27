package fr.orleans.m1.wsi.biblioapi.controleur;

import fr.orleans.m1.wsi.biblioapi.modele.Author;
import fr.orleans.m1.wsi.biblioapi.modele.AuthorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.NoSuchElementException;

@RestController
@RequestMapping("/authors")
public class AuthorController {

    @Autowired
    AuthorService authorService;

    @GetMapping("/{id}")
    public ResponseEntity<Author> get(@PathVariable Integer id){
        try {
            Author author = authorService.getAuthor(id);
            return new ResponseEntity<Author>(author, HttpStatus.OK);
        } catch (NoSuchElementException e) {
            return new ResponseEntity<Author>(HttpStatus.NOT_FOUND);
        }
    }
}
