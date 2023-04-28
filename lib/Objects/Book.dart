import 'Author.dart';
import 'Categorie.dart';
import 'MaisonEdition.dart';
import 'User.dart';

class Book{
  int ID;
  String name;
  String description;
  Categorie categorie;
  MaisonEdition maisonEdition;
  Author author;
  String cote;
  String ISBN;
  bool isAvailable;
  int releaseYear;
  List<User> inWishlist;

  Book(
      this.ID,
      this.name,
      this.description,
      this.categorie,
      this.maisonEdition,
      this.author,
      this.cote,
      this.ISBN,
      this.isAvailable,
      this.releaseYear,
      this.inWishlist);


  
}