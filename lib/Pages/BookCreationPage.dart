import 'package:flutter/material.dart';

class BookCreationPage extends StatefulWidget{

  /* variable à ajouter dans le futur pour récupérer la liste
  des livres depuis la bdd

   */

  @override
  State<StatefulWidget> createState() => BookCreationState();
}

class BookCreationState extends State<BookCreationPage>{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //final ;

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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState!.validate()) {
                    // Process data.
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