import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projetflutter/Controllers/HttpServiceBook.dart';
import 'package:projetflutter/Controllers/HttpServiceWishlist.dart';
import 'package:projetflutter/Objects/Author.dart';
import 'package:projetflutter/Objects/Categorie.dart';
import 'package:projetflutter/Objects/MaisonEdition.dart';

import '../Objects/Book.dart';
import '../Objects/User.dart';

class BookDetailsPage extends StatefulWidget {


  String provenance;
  Book currentBook;
  User currentUser;


  /*
  final String title;
  final String author;
  final String description;
  final String year;
  final String isbn;

   */

  BookDetailsPage({
    Key? key,
    required this.provenance,
    required this.currentBook,
    required this.currentUser,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => BookDetailsState(provenance,currentBook,currentUser);

}

class BookDetailsState extends State<BookDetailsPage>{

  String provenance;
  Book currentBook;
  User currentUser;


  BookDetailsState(this.provenance, this.currentBook, this.currentUser);

  bool inWishList = false;
  bool borrowed = false;
  bool isClicked = false;

  Future<List<bool>> alreadyInWishlist() async {
    List<bool> bools = [];
    HttpServiceWishlist httpServiceWishlist = HttpServiceWishlist();
    var Wishlist = await httpServiceWishlist.getWishlistById(currentUser.ID, currentBook.ID);
    if(Wishlist.utilisateurId == 0 && Wishlist.livreId == 0){
      bools.add(false);
    }
    else{
      bools.add(true);
    }
    HttpServiceBook httpServiceBook = HttpServiceBook();
    var book = await httpServiceBook.getBookByID(currentBook.ID);
    if(book.isAvailable){
      bools.add(false);
    }
    else{
      bools.add(true);
    }
    return bools;
  }

  Future<bool> alreadyBorrowed() async {
    HttpServiceBook httpServiceBook = HttpServiceBook();
    var book = await httpServiceBook.getBookByID(currentBook.ID);
    if(book.isAvailable){
      return false;
    }
    else{
      return true;
    }
  }


  Row boutons(double Width, double Height){
    HttpServiceWishlist httpServiceWishlist = HttpServiceWishlist();
    HttpServiceBook httpServiceBook = HttpServiceBook();
    if(provenance == "booklist"){
      if(inWishList==true){
        if(borrowed==false){
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  minWidth: Width>600 ? Width*0.1 : Width*0.2,
                  color: Colors.indigoAccent,
                  textColor: Colors.white,
                  onPressed: () {
                    httpServiceWishlist.deleteWishlistByID(currentUser.ID, currentBook.ID);
                    // Code pour ajouter un livre
                    setState((){
                      inWishList = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text("Vous venez de retirer le livre nommé " + currentBook.name + " de votre Wishlist")),
                    );
                  },
                  child: Text('Retirer de ma Wishlist'),
                ),
                MaterialButton(
                  minWidth: Width>600 ? Width*0.1 : Width*0.2,
                  color: Colors.indigoAccent,
                  textColor: Colors.white,
                  onPressed: () async {
                    Book book = await httpServiceBook.getBookByID(currentBook.ID);
                    httpServiceBook.updateBook(book.ID, book.name, book.description, book.categorie, book.maisonEdition, book.author, book.cote, book.ISBN, book.releaseYear, false, currentUser.ID);
                    setState((){
                      borrowed = true;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text("Vous venez d'emprunter le livre nommé " + currentBook.name)),
                    );
                    // Code pour emprunter un livre
                  },
                  child: Text('Emprunter'),
                ),
              ]);
        }
        else{
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  minWidth: Width>600 ? Width*0.1 : Width*0.2,
                  color: Colors.indigoAccent,
                  textColor: Colors.white,
                  onPressed: () {

                    httpServiceWishlist.deleteWishlistByID(currentUser.ID, currentBook.ID);
                    // Code pour ajouter un livre
                    setState((){
                      inWishList = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text("Vous venez de retirer le livre nommé " + currentBook.name + " de votre Wishlist")),
                    );
                    // Code pour ajouter un livre
                  },
                  child: Text('Retirer de ma Wishlist'),
                ),

              ]);
        }

      }
      else {
        if (borrowed == false) {
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  minWidth: Width > 600 ? Width * 0.1 : Width * 0.2,
                  color: Colors.indigoAccent,
                  textColor: Colors.white,
                  onPressed: () {
                    httpServiceWishlist.postWishlist(
                        currentUser.ID, currentBook.ID);
                    setState(() {
                      inWishList = true;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text("Vous venez d'ajouter le livre nommé " + currentBook.name + " à votre Wishlist")),
                    );
                    // Code pour ajouter un livre
                  },
                  child: Text('Ajouter à ma Wishlist'),
                ),
                MaterialButton(
                  minWidth: Width > 600 ? Width * 0.1 : Width * 0.2,
                  color: Colors.indigoAccent,
                  textColor: Colors.white,
                  onPressed: () async {
                    Book book = await httpServiceBook.getBookByID(
                        currentBook.ID);
                    httpServiceBook.updateBook(
                        book.ID,
                        book.name,
                        book.description,
                        book.categorie,
                        book.maisonEdition,
                        book.author,
                        book.cote,
                        book.ISBN,
                        book.releaseYear,
                        false,
                        currentUser.ID);
                    setState(()  {
                      borrowed = true;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text("Vous venez d'emprunter le livre nommé " + currentBook.name)),
                    );
                    // Code pour emprunter un livre
                  },
                  child: Text('Emprunter'),
                ),
              ]);
        } else {
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  minWidth: Width > 600 ? Width * 0.1 : Width * 0.2,
                  color: Colors.indigoAccent,
                  textColor: Colors.white,
                  onPressed: () {
                    httpServiceWishlist.postWishlist(
                        currentUser.ID, currentBook.ID);
                    setState(() {
                      inWishList = true;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text("Vous venez d'ajouter le livre nommé " + currentBook.name + " à votre Wishlist")),
                    );
                    // Code pour ajouter un livre
                  },
                  child: Text('Ajouter à ma Wishlist'),
                ),

              ]);
        }
      }
    }
    else{
      if(!isClicked){
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                minWidth: Width>600 ? Width*0.1 : Width*0.2,
                color: Colors.indigoAccent,
                textColor: Colors.white,
                onPressed: () async {
                  Book book = await httpServiceBook.getBookByID(currentBook.ID);
                  httpServiceBook.rendreBook(book.ID, book.name, book.description, book.categorie, book.maisonEdition, book.author, book.cote, book.ISBN, book.releaseYear, true);
                  setState((){
                    borrowed = false;
                    isClicked = true;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Vous venez de rendre le livre nommé ' + currentBook.name)),
                  );
                  // Code pour rendre un livre
                },
                child: Text('Rendre'),
              ),
            ]);
      }else{
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: []);
      }

    }
  }

  @override
  Widget build(BuildContext context) {

    final Width = MediaQuery.of(context).size.width;
    final Height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(true),
          ),
          title: Text(currentBook.name),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: Height*0.1),
              child: Container(
                  alignment: Alignment.center,
                  width: Width>1000 ? Width*0.3 : Width*0.7,
                  height: Height*0.6,
                  color: CupertinoColors.lightBackgroundGray,
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              currentBook.name,
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              currentBook.author.prenom + " " + currentBook.author.nom,
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              currentBook.maisonEdition.name,
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              currentBook.categorie.libelle,
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              currentBook.description,
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              currentBook.releaseYear.toString(),
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              "ISBN : " + currentBook.ISBN,
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          FutureBuilder<List<bool>>(
                              future: alreadyInWishlist(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  inWishList = snapshot.data!.first;
                                  borrowed = snapshot.data!.last;
                                  return Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: boutons(
                                        Width, Height),
                                  );
                                } else {
                                  return const Padding(
                                    padding: EdgeInsets.only(right: 15.0,
                                        left: 15.0,
                                        bottom: 15.0,
                                        top: 60),
                                    child: Center(
                                        child: Text(
                                            'Erreur lors du chargement des boutons')),
                                  );
                                }

                              }
                          )]

                    ),
                  )
              ),
            ),
          ),
        )
    );
  }
}
