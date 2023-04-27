package fr.orleans.m1.wsi.biblioapi.controleur;

import fr.orleans.m1.wsi.biblioapi.modele.Categorie;
import fr.orleans.m1.wsi.biblioapi.modele.CategorieService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;
import java.util.NoSuchElementException;

@RestController
@RequestMapping("/categories")
public class CategorieController {

    final CategorieService categorieService;

    public CategorieController(CategorieService categorieService) {
        this.categorieService = categorieService;
    }


    @GetMapping("/{id}")
    public ResponseEntity<Categorie> getCategorie(@PathVariable Integer id){
        try {
            Categorie categorie = categorieService.getCategorie(id);
            return new ResponseEntity<Categorie>(categorie, HttpStatus.OK);
        } catch (NoSuchElementException e) {
            return new ResponseEntity<Categorie>(HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping(value = "/create")
    public ResponseEntity<String> postCategorie(@RequestParam String nom, @RequestParam int id) throws URISyntaxException {
        try {
            Categorie categorieTest = categorieService.getCategorie(id);

        }catch (Exception e){
            try {
                Categorie categorie = new Categorie(nom, id);
                categorieService.addCategorie(categorie);
            }catch (Exception ex){
                return ResponseEntity.status(HttpStatus.CONFLICT).build();
            }
            URI uri = new URI("/"+id);
            return ResponseEntity.created(uri).body("nom = " + nom);
        }

        return ResponseEntity.status(HttpStatus.CONFLICT).build();
    }

    @GetMapping("/all")
    public ResponseEntity<List<Categorie>> getAll(){
        try {
            List<Categorie> categories = categorieService.getAllCategorie();
            return new ResponseEntity<List<Categorie>>(categories, HttpStatus.OK);
        } catch (NoSuchElementException e) {
            return new ResponseEntity<List<Categorie>>(HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping("/size")
    public ResponseEntity<Integer> getSize(){
        try {
            List<Categorie> categories = categorieService.getAllCategorie();
            return new ResponseEntity<Integer>(categories.size(), HttpStatus.OK);
        } catch (NoSuchElementException e) {
            return new ResponseEntity<Integer>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> removeById(@PathVariable Integer id){
        try {
            categorieService.deleteCategorie(id);
            return new ResponseEntity<Void>( HttpStatus.NO_CONTENT);
        } catch (NoSuchElementException e) {
            return new ResponseEntity<Void>(HttpStatus.NOT_FOUND);
        }
    }






}
