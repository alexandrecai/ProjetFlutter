import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:projetflutter/Pages/BookDetailsPage.dart';
import 'package:projetflutter/Pages/SearchBarDelegate.dart';
import 'package:sqflite/sqflite.dart';

import '../Controllers/HttpServiceBook.dart';
import '../Objects/Author.dart';
import '../Objects/Book.dart';
import '../Objects/Categorie.dart';
import '../Objects/MaisonEdition.dart';
import '../Objects/User.dart';

class BookListPage extends StatefulWidget {

  User currentUser;

  BookListPage({
    super.key,
    required this.currentUser,
  });

  @override
  State<BookListPage> createState() => _BookListPageState(currentUser);
}

class _BookListPageState extends State<BookListPage> {

  User currentUser;

  _BookListPageState(
      this.currentUser,
      );

  HttpServiceBook liste = HttpServiceBook();
  List<Book> books=[];
  /*Future<void> fetchBooks() async {
    books = await liste.getAllBook();

  }*/

  /*List<Book> books = [
    Book(1,     "The Great Gatsby", "The story of the mysteriously wealthy Jay Gatsby and his love for the beautiful Daisy Buchanan, of lavish parties on Long Island at a time when The New York Times noted 'gin was the national drink and sex the national obsession,' it is an exquisitely crafted tale of America in the 1920s.",
        Categorie(1,"Classic Fiction"), MaisonEdition(1,"Scribner",[],[]), Author(1, "Scott", "Scott Fitzgerald"),
        "lee", "978-0-06-112008-4", true, 1925, []),
    Book(2, "To Kill a Mockingbird", "The unforgettable novel of a childhood in a sleepy Southern town and the crisis of conscience that rocked it, To Kill A Mockingbird became both an instant bestseller and a critical success when it was first published in 1960. ", Categorie(2,"Classic Fiction"),
      MaisonEdition(2,"HarperCollins",[],[]), Author(2,"Harper" ,"Lee"), "Lee", "978-0-06-112008-4", true, 1960, [],),
    Book(3, "The Hitchhiker's Guide to the Galaxy", "Seconds before the Earth is demolished to make way for a galactic freeway, Arthur Dent is plucked off the planet by his friend Ford Prefect, a researcher for the revised edition of The Hitchhiker's Guide to the Galaxy who, for the last fifteen years, has been posing as an out-of-work actor. Together this dynamic pair begin a journey through space aided by quotes from The Hitchhiker's Guide ('A towel is about the most massively useful thing an interstellar hitchhiker can have') and a galaxy-full of fellow travelers: Zaphod Beeblebrox—the two-headed, three-armed ex-hippie and totally out-to-lunch president of the galaxy; Trillian, Zaphod's girlfriend (formally Tricia McMillan), whom Arthur tried to pick up at a cocktail party once upon a time zone; Marvin, a paranoid, brilliant, and chronically depressed robot; Veet Voojagig, a former graduate student who is obsessed with the disappearance of all the ballpoint pens he bought over the years.", Categorie(3,"Science Fiction"), MaisonEdition(3,"Del Rey Books",[],[]),
      Author(3,"Douglas", "Adams"), "Adams", "978-0-345-39181-9", true, 1979, [],
    )  ];*/


  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: new Center(child: new Text("Liste des livres", textAlign: TextAlign.center)),

    ),


    floatingActionButton: FloatingActionButton(
      child: const Icon(Icons.search),
      onPressed: () async {
        final String? searchQuery = await showSearch<String>(
          context: context,
          delegate: SearchBarDelegate(books,currentUser),
        );
      },
    ),

    body: FutureBuilder<List<Book>>(
      future: liste.getAllBook(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Book> books = snapshot.data!;
          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.book),
                title: Text(books[index].name),
                subtitle: Text(books[index].description),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookDetailsPage(
                        provenance: "booklist",
                        currentBook: books[index],
                        currentUser: currentUser,
                      ),
                    ),
                  );
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur lors du chargement des données'));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },

    ),
  );





    /*body: ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, i) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BookDetailsPage(
                title: books[i].name,
                author: books[i].author.nom,
                description: books[i].description,
                year: books[i].releaseYear.toString(),
                isbn: books[i].ISBN,
              ),
            ),
          );
        },
        child: ListTile(
          leading: const Icon(Icons.book),
          title: Text(books[i].name),
          subtitle: Text(books[i].releaseYear.toString()),
        ),

      ),
    ),
*/




}