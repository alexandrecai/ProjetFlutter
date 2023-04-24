import 'Author.dart';
import 'Book.dart';

class MaisonEdition{
  int ID;
  String name;
  List<Author> authorList;
  List<Book> bookList;

  MaisonEdition(this.ID, this.name, this.authorList, this.bookList);
}