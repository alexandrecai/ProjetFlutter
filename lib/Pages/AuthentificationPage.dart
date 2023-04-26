import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                child: Text(suggestionText,
                  softWrap: false,
                  style: TextStyle(
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