import 'package:flutter/material.dart';
import 'package:projetflutter/Pages/BookDetailsPage.dart';
import 'package:projetflutter/Pages/SearchBarDelegate.dart';

import '../Objects/Author.dart';
import '../Objects/Book.dart';
import '../Objects/Categorie.dart';
import '../Objects/MaisonEdition.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {


  List<Book> books = [
  Book(1,     "The Great Gatsby", "The story of the mysteriously wealthy Jay Gatsby and his love for the beautiful Daisy Buchanan, of lavish parties on Long Island at a time when The New York Times noted 'gin was the national drink and sex the national obsession,' it is an exquisitely crafted tale of America in the 1920s.",
  Categorie("Classic Fiction",1), MaisonEdition(1,"Scribner",[],[]), Author(1, "Scott", "Scott Fitzgerald"),
  "lee", "978-0-06-112008-4", true, 1925, []),
    Book(2, "To Kill a Mockingbird", "The unforgettable novel of a childhood in a sleepy Southern town and the crisis of conscience that rocked it, To Kill A Mockingbird became both an instant bestseller and a critical success when it was first published in 1960. ", Categorie("Classic Fiction",2),
      MaisonEdition(2,"HarperCollins",[],[]), Author(2,"Harper" ,"Lee"), "Lee", "978-0-06-112008-4", true, 1960, [],),
    Book(3, "The Hitchhiker's Guide to the Galaxy", "Seconds before the Earth is demolished to make way for a galactic freeway, Arthur Dent is plucked off the planet by his friend Ford Prefect, a researcher for the revised edition of The Hitchhiker's Guide to the Galaxy who, for the last fifteen years, has been posing as an out-of-work actor. Together this dynamic pair begin a journey through space aided by quotes from The Hitchhiker's Guide ('A towel is about the most massively useful thing an interstellar hitchhiker can have') and a galaxy-full of fellow travelers: Zaphod Beeblebrox—the two-headed, three-armed ex-hippie and totally out-to-lunch president of the galaxy; Trillian, Zaphod's girlfriend (formally Tricia McMillan), whom Arthur tried to pick up at a cocktail party once upon a time zone; Marvin, a paranoid, brilliant, and chronically depressed robot; Veet Voojagig, a former graduate student who is obsessed with the disappearance of all the ballpoint pens he bought over the years.", Categorie("Science Fiction",3), MaisonEdition(3,"Del Rey Books",[],[]),
      Author(3,"Douglas", "Adams"), "Adams", "978-0-345-39181-9", true, 1979, [],
    )  ];


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
          delegate: SearchBarDelegate(books),
        );
      },
    ),


    body: ListView.builder(
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

  );

}