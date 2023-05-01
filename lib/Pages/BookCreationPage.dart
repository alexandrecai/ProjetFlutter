
import 'package:flutter/material.dart';
import 'package:projetflutter/Objects/Categorie.dart';

import '../Controllers/HttpServiceBook.dart';
import '../Objects/Author.dart';
import '../Objects/Book.dart';
import '../Objects/MaisonEdition.dart';

class BookCreationPage extends StatefulWidget{

  /* variable à ajouter dans le futur pour récupérer la liste
  des livres depuis la bdd

   */

  @override
  State<StatefulWidget> createState() => BookCreationState();
}

class BookCreationState extends State<BookCreationPage>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController isbnController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController maisonEditionController = TextEditingController();
  final TextEditingController categorieController = TextEditingController();
  final TextEditingController coteController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // Ajoutez des variables pour stocker les informations du livre
  String? title;
  String? author;
  String? isbn;
  String? description;
  String? category;
  String? year;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          padding : EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.35),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Entrer le nom du livre',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez écrire du texte';
                }
                return null;
              },
              onSaved: (String? value) {
                title = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Entrez l\'auteur du livre',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez écrire du texte';
                }
                return null;
              },
              onSaved: (String? value) {
                author = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Entrez l\'ISBN du livre',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez écrire du texte';
                }
                return null;
              },
              onSaved: (String? value) {
                isbn = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Entrez l\'année de parution du livre',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez écrire du texte';
                }
                return null;
              },
              onSaved: (String? value) {
                year =value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Entrez la description du livre',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez écrire du texte';
                }
                return null;
              },
              onSaved: (String? value) {
                description = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Choisissez la catégorie du livre',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez écrire du texte';
                }
                return null;
              },
              onSaved: (String? value) {
                category = value;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState!.validate()) {
                    if (_formKey.currentState!.validate()) {
                      // Sauvegarder les données du formulaire dans les variables de classe
                      _formKey.currentState!.save();


                      Book newBook = Book(
                          1,
                          title!,
                          description!,
                          Categorie(1,categorieController.text ),
                          MaisonEdition(1,maisonEditionController.text,[],[]),
                          Author(1, authorController.text, ""),
                         "C003",
                          isbn!,
                          true,
                          int.parse(year!),
                          []
                      );


                      // Envoyer le nouvel objet Book au serveur
                      HttpServiceBook service = HttpServiceBook();
                      print(newBook.toString());
                      service.postBook(
                        newBook.name,
                        newBook.description,
                        newBook.categorie,
                        newBook.maisonEdition,
                        newBook.author,
                        newBook.cote,
                        newBook.ISBN,
                        newBook.releaseYear,
                        newBook.isAvailable,
                      ).then((value) {
                        // Si la création du livre réussit, afficher une alerte
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Livre ajouté'),
                              content: Text('Le livre a été ajouté avec succès à la base de données.'),
                              actions: [
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }).catchError((error) {
                        // Si la création du livre échoue, afficher une alerte avec l'erreur
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Erreur'),
                              content: Text('Une erreur est survenue lors de l\'ajout du livre à la base de données : $error'),
                              actions: [
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      });
                    }

                  }
                },
                child: const Text('Soumettre'),
              ),
            ),
          ],
        ),
      )
      )
    );
  }
}