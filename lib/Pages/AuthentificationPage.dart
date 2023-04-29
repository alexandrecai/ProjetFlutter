import 'package:flutter/material.dart';
import 'package:projetflutter/Controllers/HttpServiceAuthor.dart';
import 'package:projetflutter/Controllers/HttpServiceBook.dart';
import 'package:projetflutter/Controllers/HttpServiceCategorie.dart';
import 'package:projetflutter/Controllers/HttpServiceMaisonEdition.dart';
import 'package:projetflutter/Controllers/HttpServiceUser.dart';
import 'package:projetflutter/Controllers/HttpServiceWishlist.dart';
import 'package:projetflutter/Objects/Categorie.dart';
import 'package:projetflutter/Objects/MaisonEdition.dart';
import 'package:projetflutter/Objects/Wishlist.dart';

import '../Objects/Author.dart';
import '../Objects/Book.dart';
import '../Objects/User.dart';
import 'LoginPage.dart';
import 'RegisterPage.dart';

class AuthentificationPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => AuthentificationState();
}

class AuthentificationState extends State<AuthentificationPage>{

  int selectedIndex = 0;
  String buttonText = "Créer un compte";
  String suggestionText = "Pas encore de compte ?";

  final List<Widget> pages = [
    LoginPage(),
    RegisterPage(),
  ];

  @override
  Widget build(BuildContext context) {
    var httpserviceauthor = HttpServiceAuthor();
    var httpservicebook = HttpServiceBook();
    var httpservicecategorie = HttpServiceCategorie();
    var httpservicemaison = HttpServiceMaisonEdition();
    var httpserviceuser = HttpServiceUser();
    var httpservicewishlist = HttpServiceWishlist();
    //var size = httpservice.getAuthorSize();
    //var res = httpserviceauthor.deleteAuthorByID(7);
    //var testadd = httpserviceauthor.postAuthor("Salut", "Toi");
    //var testupdate = httpserviceauthor.updateAuthor(10, "bonjour", "update");
    //httpservicecategorie.postCategorie("flutter");
    //httpservicecategorie.updateCategorie(6, "testUpdate");
    //httpservicecategorie.deleteCategorieByID(6);
    //httpservicemaison.deleteMaisonEditionByID(6);
  /*
    var controllerSql = SQLiteController();

    var author = httpservice.getAuthorByID(1);


    var author = Author(1,"Etoile","Patrick");
    var author2 = Author(1,"Eponge","Bob");
    controllerSql.insertAuteur(author);
    controllerSql.insertAuteur(author2);


     */
    //var authorlist = controllerSql.getAuthor().;

    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<List<Wishlist>>(

                //future: httpservice.deleteAuthorById(6),
                future: httpservicewishlist.getAllWishlist(),
                //initialData: List,
                builder: (context, snapshot){
                  return snapshot.hasData ? Text(snapshot.data!.first.utilisateurId.toString()):
                  const Text("nodata");
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(suggestionText,
                  softWrap: false,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),),

              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width * 0.15,
                  onPressed: () {
                    setState(() {
                      if(selectedIndex==1){
                        selectedIndex = 0;
                        buttonText = "Créer un compte";
                        suggestionText = "Pas encore de compte ?";
                      }
                      else{
                        selectedIndex = 1;
                        buttonText = "Me connecter";
                        suggestionText = "Déja un compte ?";
                      }
                    });
                  },
                  child: Text(buttonText),
                  color: Colors.indigoAccent,
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
          Expanded(child:
          pages[selectedIndex],
          )],),
    );
    // TODO: implement build
    throw UnimplementedError();
  }


}