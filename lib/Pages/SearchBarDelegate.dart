import 'package:flutter/material.dart';
import 'package:projetflutter/Controllers/HttpServiceBook.dart';

import '../Objects/Book.dart';
import '../Objects/User.dart';
import 'BookDetailsPage.dart';

class SearchBarDelegate extends SearchDelegate<String> {

  List<Book> books;
  User currentUser;

  SearchBarDelegate(this.books,this.currentUser);

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[ IconButton(
      icon: const Icon(Icons.clear), onPressed: () {
      query = '';
    },),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // buildResults is not used in this example
    return const SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    HttpServiceBook httpServiceBook = HttpServiceBook();

    final List<Book> suggestionList = query.isEmpty
        ? books // show all books if query is empty
        : books.where((book) =>
        book.name.toLowerCase().contains(query.toLowerCase())).toList();

    return FutureBuilder<List<Book>>(
        future: httpServiceBook.getAllBook(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            books = snapshot.requireData;
            return ListView.builder(
              itemCount: suggestionList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.book),
                  title: Text(suggestionList[index].name),
                  subtitle: Text(suggestionList[index].description),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            BookDetailsPage(
                              provenance: "booklist",
                              currentBook: suggestionList[index],
                              currentUser: currentUser,
                            ),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(child: Text("Il n'y a pas de livre"));
          }
        }
    );
  }
}
