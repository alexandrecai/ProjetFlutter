package fr.orleans.m1.wsi.biblioapi.modele;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class BookService {

    @Autowired
    private BookRepository bookRepository;

    public List<Book> getAllBooks(){
        return bookRepository.findAll();
    }

    public void addBook(Book book) {
        bookRepository.save(book);
    }

    public Book getBook(Integer id) {
        return bookRepository.findById(id).get();
    }

    public void deleteBook(Integer id) {
        bookRepository.deleteById(id);
    }
}
