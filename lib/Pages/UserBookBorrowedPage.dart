import 'package:flutter/material.dart';
import 'package:projetflutter/Controllers/HttpServiceUser.dart';

import '../Controllers/HttpServiceBook.dart';
import '../Objects/Book.dart';
import '../Objects/User.dart';
import 'BookDetailsPage.dart';

class UserBookBorrowedPage extends StatefulWidget {

  User currentUser;

  UserBookBorrowedPage(this.currentUser,{super.key});

  @override
  State<UserBookBorrowedPage> createState() => _UserBookBorrowedState(currentUser);
}

class _UserBookBorrowedState extends State<UserBookBorrowedPage> {

  User currentUser;

  _UserBookBorrowedState(this.currentUser);

  HttpServiceUser httpServiceUser = HttpServiceUser();
  List<Book> books = [];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Center(child: Text("Mes livres empruntés", textAlign: TextAlign.center)),
    ),
    body: FutureBuilder<User>(
      future: httpServiceUser.getUserByID(currentUser.ID),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print("hasData");
          books = snapshot.data!.livresEmpruntes;
          if (books.isNotEmpty) {
          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.book),
                  title: Text(books[index].name),
                  subtitle: Text(books[index].description),
                  onTap: () async {
                    bool? updated = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            BookDetailsPage(
                              provenance: "userborrowed",
                              currentBook: books[index],
                              currentUser: currentUser,
                            ),
                      ),
                    );
                    if (updated == true) {
                      setState(() {});
                    }
                  },
                );
              } );
            }
            else {
              return const Center(child: Text("Vous n'avez emprunté aucun livre"));
          }
        } else {
          return const Center(
              child: Text('Erreur lors du chargement des données'));
        }
      }),
  );

}

