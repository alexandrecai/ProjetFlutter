import 'package:flutter/material.dart';

import '../Controllers/HttpServiceUser.dart';
import '../Objects/Book.dart';
import '../Objects/User.dart';
import 'BookDetailsPage.dart';

class WishlistPage extends StatefulWidget {

  User currentUser;

  WishlistPage(this.currentUser,{super.key});

  @override
  State<WishlistPage> createState() => _WishlistState(currentUser);
}

class _WishlistState extends State<WishlistPage> {

  User currentUser;

  _WishlistState(this.currentUser);

  HttpServiceUser httpServiceUser = HttpServiceUser();
  List<Book> books = [];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Center(child: Text("Wishlist", textAlign: TextAlign.center)),
    ),
    body: FutureBuilder<User>(
        future: httpServiceUser.getUserByID(currentUser.ID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("hasData");
            books = snapshot.data!.wishlist;
            if (books.isNotEmpty) {
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
                            builder: (_) =>
                                BookDetailsPage(
                                  title: books[index].name,
                                  author: books[index].author.nom,
                                  description: books[index].description,
                                  year: books[index].releaseYear.toString(),
                                  isbn: books[index].ISBN,
                                ),
                          ),
                        );
                      },
                    );
                  } );
            }
            else {
              return const Center(child: Text("Vous n'avez aucun livre dans votre wishlist"));
            }
          } else {
            return const Center(
                child: Text('Erreur lors du chargement des données'));
          }
        }),
  );

}

