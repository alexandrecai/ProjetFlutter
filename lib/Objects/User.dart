import 'Book.dart';

class User{
  int ID;
  String nom;
  String prenom;
  String mail;
  String password;
  bool isAdmin;
  List<Book> wishlist;
  List<Book> livresEmpruntes;

  User(this.ID, this.nom, this.prenom, this.mail, this.password, this.isAdmin,
      this.wishlist, this.livresEmpruntes);
}