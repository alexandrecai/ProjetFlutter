import 'package:flutter/material.dart';
import 'package:projetflutter/Controllers/HttpServiceBook.dart';
import 'package:projetflutter/Controllers/HttpServiceCategorie.dart';
import 'package:projetflutter/Controllers/HttpServiceMaisonEdition.dart';
import 'package:projetflutter/Objects/Categorie.dart';

import '../Objects/MaisonEdition.dart';

class CategorieCreationPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => CategorieCreationState();

}

class CategorieCreationState extends State<CategorieCreationPage>{

  TextEditingController nameController = TextEditingController();
  bool nameSubmited = true;

  bool hasEnoughChar(TextEditingController ed) {
    final text = ed.value.text;
    if (text.isEmpty || text.length < 4) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    HttpServiceCategorie httpServiceCategorie = HttpServiceCategorie();

    final Width = MediaQuery.of(context).size.width;
    final Height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("Création d'une catégorie", textAlign: TextAlign.center))),
        resizeToAvoidBottomInset: false,
        body:
            Center(
              child: SingleChildScrollView(
                  child: Center(
                          child : Width>600 ? Row(
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
                                            height: Height>300 ? Height*0.6 : Height*0.9,
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
                                                            labelText: 'Libelle',
                                                            prefixIcon: Icon(Icons.category),
                                                            border: OutlineInputBorder(),
                                                            errorText: nameSubmited ? null : 'Trop court',
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
                                                            });
                                                            if(nameSubmited){
                                                              await httpServiceCategorie.postCategorie(nameController.text);
                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                const SnackBar(
                                                                    content: Text("La catégorie a bien été crée")),
                                                              );
                                                              nameController.clear();
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
                                                          child: const Text("Créer la catégorie"),
                                                        ),
                                                      )
                                                    ]
                                                )
                                            )
                                        )
                                    )
                                ),
                                Center(
                                  child: SizedBox(
                                    height: Height*0.6,
                                    width: Width*0.4,
                                    child:
                                    FutureBuilder<List<Categorie>>(
                                      future: httpServiceCategorie.getAllCategories(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          List<Categorie> categories = snapshot.data!;
                                          return ListView.builder(
                                            itemCount: categories.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                leading: const Icon(Icons.category),
                                                title: Text(categories[index].libelle),
                                                subtitle: Text(categories[index].ID.toString()),
                                              );
                                            },
                                          );
                                        } else if (snapshot.hasError) {
                                          return Center(child: Text('Erreur lors du chargement des données'));
                                        } else {
                                          return Center(child: Text('Pas de catégorie'));
                                        }
                                      },

                                    ),
                                  ),
                                )
                              ]
                          ):Column(
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
                                            height: Height>300 ? Height*0.35 : Height*0.5,
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
                                                            labelText: 'Libelle',
                                                            prefixIcon: Icon(Icons.category),
                                                            border: OutlineInputBorder(),
                                                            errorText: nameSubmited ? null : 'Trop court',
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
                                                            });
                                                            if(nameSubmited){
                                                              await httpServiceCategorie.postCategorie(nameController.text);
                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                const SnackBar(
                                                                    content: Text("La catégorie a bien été crée")),
                                                              );
                                                              nameController.clear();
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
                                                          child: const Text("Créer la catégorie"),
                                                        ),
                                                      )
                                                    ]
                                                )
                                            )
                                        )
                                    )
                                ),
                                Center(
                                  child: SizedBox(
                                    height: Height*0.6,
                                    width: Width*0.4,
                                    child:
                                    FutureBuilder<List<Categorie>>(
                                      future: httpServiceCategorie.getAllCategories(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          List<Categorie> categories = snapshot.data!;
                                          return ListView.builder(
                                            itemCount: categories.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                leading: const Icon(Icons.category),
                                                title: Text(categories[index].libelle),
                                                subtitle: Text(categories[index].ID.toString()),
                                              );
                                            },
                                          );
                                        } else if (snapshot.hasError) {
                                          return Center(child: Text('Erreur lors du chargement des données'));
                                        } else {
                                          return Center(child: Text('Pas de catégorie'));
                                        }
                                      },

                                    ),
                                  ),
                                )
                              ]
                          )
                    ,


                      )
                  ),
            ),






        );

  }



}