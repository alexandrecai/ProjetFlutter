import 'package:flutter/material.dart';

import '../Objects/Book.dart';
import 'BookDetailsPage.dart';

class SearchBarDelegate extends SearchDelegate<String> {
  final List<Book> books;

  SearchBarDelegate(this.books);

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
    final List<Book> suggestionList = query.isEmpty
        ? books // show all books if query is empty
        : books.where((book) =>
        book.name.toLowerCase().contains(query.toLowerCase())).toList();

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
                      title: suggestionList[index].name,
                      author: suggestionList[index].author.nom,
                      description: suggestionList[index].description,
                      year: suggestionList[index].releaseYear.toString(),
                      isbn: suggestionList[index].ISBN,
                    ),
              ),
            );
          },
        );
      },
    );
  }
}
