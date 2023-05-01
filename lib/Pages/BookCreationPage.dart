
import 'package:flutter/material.dart';
import 'package:projetflutter/Controllers/HttpServiceCategorie.dart';
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

  String? title;
  String? author;
  String? isbn;
  String? description;
  String? category;
  String? year;


  TextEditingController nameController = TextEditingController();
  bool nameSubmited = true;
  TextEditingController descriptionController = TextEditingController();
  bool descriptionSubmited = true;
  TextEditingController categorieController = TextEditingController();
  bool categorieSubmited = true;
  TextEditingController maisonController = TextEditingController();
  bool maisonSubmited = true;
  TextEditingController auteurController = TextEditingController();
  bool auteurSubmited = true;
  TextEditingController coteController = TextEditingController();
  bool coteSubmited = true;
  TextEditingController isbnController = TextEditingController();
  bool isbnSubmited = true;
  TextEditingController anneeController = TextEditingController();
  bool anneeSubmited = true;

  bool hasEnoughChar(TextEditingController ed) {
    final text = ed.value.text;
    if (text.isEmpty || text.length < 4) {
      return false;
    }
    return true;
  }

  bool isCorrectYear(TextEditingController ed){
    if(ed.text.isEmpty){
      return false;
    }
    return RegExp(r"^\d+$").hasMatch(ed.value.text);
  }

  Future<List<Categorie>> getCategories(HttpServiceCategorie httpServiceCategorie) async {
    List<Categorie> categories = await httpServiceCategorie.getAllCategories();
    return categories;
  }





  @override
  Widget build(BuildContext context) {

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    HttpServiceBook httpServiceBook = HttpServiceBook();
    HttpServiceCategorie httpServiceCategorie = HttpServiceCategorie();

    final Width = MediaQuery.of(context).size.width;
    final Height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("Création d'un livre", textAlign: TextAlign.center))),
      resizeToAvoidBottomInset: false,
      body:
      Center(
        child: SingleChildScrollView(
            child: Center(
                child : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: Height*0.1, right: Width*0.05),
                          child: Form(
                              key: _formKey,
                              child:Container(
                                //padding : EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.4),
                                  width: Width>600 ? Width*0.3 : Width*0.75,
                                  height: Height>300 ? Height*0.75 : Height*0.9,
                                  child: SingleChildScrollView(
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                controller: nameController,
                                                keyboardType: TextInputType.name,
                                                decoration: InputDecoration(
                                                  labelText: 'Nom',
                                                  prefixIcon: Icon(Icons.book),
                                                  border: OutlineInputBorder(),
                                                  errorText: nameSubmited ? null : 'Trop court',
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                controller: descriptionController,
                                                keyboardType: TextInputType.name,
                                                decoration: InputDecoration(
                                                  labelText: 'Description',
                                                  prefixIcon: Icon(Icons.book),
                                                  border: OutlineInputBorder(),
                                                  errorText: descriptionSubmited ? null : 'Trop court',
                                                ),
                                              ),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                controller: categorieController,
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                  labelText: 'Id de la catégorie',
                                                  prefixIcon: Icon(Icons.book),
                                                  border: OutlineInputBorder(),
                                                  errorText: categorieSubmited ? null : 'Trop court',
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                controller: maisonController,
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                  labelText: 'Id de la maison édition',
                                                  prefixIcon: Icon(Icons.book),
                                                  border: OutlineInputBorder(),
                                                  errorText: maisonSubmited ? null : 'Trop court',
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                controller: auteurController,
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                  labelText: "Id de l'Auteur",
                                                  prefixIcon: Icon(Icons.book),
                                                  border: OutlineInputBorder(),
                                                  errorText: auteurSubmited ? null : 'Trop court',
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                controller: coteController,
                                                keyboardType: TextInputType.name,
                                                decoration: InputDecoration(
                                                  labelText: 'Cote',
                                                  prefixIcon: Icon(Icons.book),
                                                  border: OutlineInputBorder(),
                                                  errorText: coteSubmited ? null : 'Trop court',
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                controller: isbnController,
                                                keyboardType: TextInputType.name,
                                                decoration: InputDecoration(
                                                  labelText: 'ISBN',
                                                  prefixIcon: Icon(Icons.book),
                                                  border: OutlineInputBorder(),
                                                  errorText: isbnSubmited ? null : 'Trop court',
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                controller: anneeController,
                                                keyboardType: TextInputType.name,
                                                decoration: InputDecoration(
                                                  labelText: 'Année de parution',
                                                  prefixIcon: Icon(Icons.book),
                                                  border: OutlineInputBorder(),
                                                  errorText: anneeSubmited ? null : 'Annee incorrecte',
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: MaterialButton(
                                                padding: const EdgeInsets.all(20.0),
                                                minWidth: Width>600 ? Width*0.30 : Width*0.5,
                                                //minWidth: MediaQuery.of(context).size.width * 0.15,

                                                onPressed: () async {
                                                  setState(() {
                                                    hasEnoughChar(nameController) ? nameSubmited = true : nameSubmited = false;
                                                    hasEnoughChar(descriptionController) ? descriptionSubmited = true : descriptionSubmited = false;
                                                    hasEnoughChar(coteController) ? coteSubmited = true : coteSubmited = false;
                                                    hasEnoughChar(isbnController) ? isbnSubmited = true : isbnSubmited = false;
                                                    isCorrectYear(anneeController) ? anneeSubmited = true : anneeSubmited = false;
                                                    hasEnoughChar(anneeController) ? anneeSubmited = true : anneeSubmited = false;
                                                  });
                                                  if(nameSubmited && descriptionSubmited && categorieSubmited && maisonSubmited && auteurSubmited && coteSubmited && isbnSubmited && anneeSubmited){
                                                    await httpServiceBook.postBook(nameController.text, descriptionController.text,int.parse(categorieController.text),int.parse(maisonController.text),int.parse(auteurController.text),coteController.text,isbnController.text,int.parse(anneeController.text),true);
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(
                                                          content: Text("Le livre a bien été crée")),
                                                    );
                                                    nameController.clear();
                                                    descriptionController.clear();
                                                    categorieController.clear();
                                                    maisonController.clear();
                                                    auteurController.clear();
                                                    coteController.clear();
                                                    isbnController.clear();
                                                    anneeController.clear();
                                                    setState(() {
                                                    });
                                                  }
                                                  else{
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(
                                                          content: Text("Les informations n'ont pas été remplies correctement.")),
                                                    );
                                                  }
                                                }
                                                ,//,
                                                color: Colors.indigoAccent,
                                                textColor: Colors.white,
                                                child: const Text("Créer le livre"),
                                              ),
                                            )
                                          ]
                                      )
                                  )
                              )
                          )
                      ),

                    ]
                )


            )
        ),
      ),






    );

  }
}