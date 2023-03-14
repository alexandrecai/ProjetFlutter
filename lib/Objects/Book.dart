import 'Categorie.dart';
import 'User.dart';

class Book{

  String name;
  String author;
  String ISBN;
  int releaseYear;
  String description;
  Categorie categorie;
  bool isAvailable;
  User emprunteur;

  Book(this.name, this.author, this.ISBN, this.releaseYear, this.description,
      this.categorie, this.isAvailable, this.emprunteur);
}