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
@RequestMapping("/books")
public class BookController {

    @Autowired
    BookService bookService;


    @GetMapping("/{id}")
    public ResponseEntity<Book> getBook(@PathVariable Integer id){
        try {
            Book book = bookService.getBook(id);
            return new ResponseEntity<Book>(book, HttpStatus.OK);
        } catch (NoSuchElementException e) {
            return new ResponseEntity<Book>(HttpStatus.NOT_FOUND);
        }
    }


}
