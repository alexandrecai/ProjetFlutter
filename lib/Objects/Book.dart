import 'Categorie.dart';
import 'User.dart';

class Book{
  int ID;
  String name;
  String author;
  String ISBN;
  String libelle;
  String image;
  int releaseYear;
  String description;
  Categorie categorie;
  String cote;
  bool isAvailable;

  Book(this.name, this.author, this.ISBN, this.releaseYear, this.description,
      this.categorie, this.isAvailable, this.emprunteur);
}