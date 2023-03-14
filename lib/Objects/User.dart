import 'Book.dart';

class User{

  String nom;
  String prenom;
  String mail;
  String password;
  List<Book> wishlist;

  User(this.nom, this.prenom, this.mail, this.password, this.wishlist);
}