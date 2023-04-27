package fr.orleans.m1.wsi.biblioapi.controleur;

import fr.orleans.m1.wsi.biblioapi.modele.Author;
import fr.orleans.m1.wsi.biblioapi.modele.AuthorService;
import fr.orleans.m1.wsi.biblioapi.modele.Book;
import fr.orleans.m1.wsi.biblioapi.modele.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;
import java.util.NoSuchElementException;

@RestController
@RequestMapping("/authors")
public class AuthorController {

    @Autowired
    AuthorService authorService;




    @GetMapping("/{id}")
    public ResponseEntity<Author> getAuthor(@PathVariable Integer id){
        try {
            Author author = authorService.getAuthor(id);
            return new ResponseEntity<Author>(author, HttpStatus.OK);
        } catch (NoSuchElementException e) {
            return new ResponseEntity<Author>(HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping(value = "/create")
    public ResponseEntity<String> postAuthor(@RequestParam String nom, @RequestParam String prenom, @RequestParam int id) throws URISyntaxException {
        try {
            Author authorTest = authorService.getAuthor(id);

        }catch (Exception e){
            try {
                Author author = new Author(id,nom,prenom);
                authorService.addAuthor(author);
            }catch (Exception ex){
                return ResponseEntity.status(HttpStatus.CONFLICT).build();
            }
            URI uri = new URI("/"+id);
            return ResponseEntity.created(uri).body("nom = " + nom);
        }

        return ResponseEntity.status(HttpStatus.CONFLICT).build();
    }

    @GetMapping("/all")
    public ResponseEntity<List<Author>> getAll(){
        try {
            List<Author> authors = authorService.getAllAuthor();
            return new ResponseEntity<List<Author>>(authors, HttpStatus.OK);
        } catch (NoSuchElementException e) {
            return new ResponseEntity<List<Author>>(HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping("/size")
    public ResponseEntity<Integer> getSize(){
        try {
            List<Author> authors = authorService.getAllAuthor();
            return new ResponseEntity<Integer>(authors.size(), HttpStatus.OK);
        } catch (NoSuchElementException e) {
            return new ResponseEntity<Integer>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> removeById(@PathVariable Integer id){
        try {
            authorService.getAuthor(id);
            authorService.deleteAuthor(id);
            return new ResponseEntity<Void>( HttpStatus.NO_CONTENT);
        } catch (NoSuchElementException e) {
            return new ResponseEntity<Void>(HttpStatus.NOT_FOUND);
        }
    }






}
