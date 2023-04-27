import 'package:flutter/material.dart';
import 'package:projetflutter/Controllers/HttpService.dart';
import 'package:projetflutter/Controllers/SQLiteController.dart';

import '../Objects/Author.dart';
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
    var httpservice = HttpService();
    var size = httpservice.getAuthorSize();
    var res = httpservice.postAuthor(10, "Jil", "Marcel");
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
              FutureBuilder<String>(
                future: httpservice.deleteAuthorByID(6),
                //initialData: List,
                builder: (context, snapshot){
                  return snapshot.hasData ? Text(snapshot.data!):
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