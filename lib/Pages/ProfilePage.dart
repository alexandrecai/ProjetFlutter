import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Objects/User.dart';
import 'MainPage.dart';

class ProfilePage extends StatelessWidget{

  User currentUser;

  ProfilePage(this.currentUser);

  @override
  Widget build(BuildContext context) {

    final Width = MediaQuery.of(context).size.width;
    final Height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(title: const Center(child: Text("Profil", textAlign: TextAlign.center)),
        ),
        body: SingleChildScrollView(
          child:
          Padding(
            padding: EdgeInsets.only(top: Height*0.1),
            child: Center(
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
                    Icon(Icons.person,size: Height*0.15),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            const Text("Id : ",style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                            Text(currentUser.ID.toString(),style: const TextStyle(
                              fontSize: 20,
                            )),
                          ]
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            const Text("Nom : ",style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                            Text(currentUser.nom,style: const TextStyle(
                              fontSize: 20,
                            )),
                          ]
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            const Text("Prénom : ",style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                            Text(currentUser.prenom,style: const TextStyle(
                              fontSize: 20,
                            )),
                          ]
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            const Text("Email : ",style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                            Text(currentUser.mail,style: const TextStyle(
                              fontSize: 20,
                            )),
                          ]
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            const Text("isAdmin : ",style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                            Text(currentUser.isAdmin.toString(),style: const TextStyle(
                              fontSize: 20,
                            )),
                          ]
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        padding: const EdgeInsets.all(20.0),
                        minWidth: Width>600 ? Width*0.20 : Width*0.4,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Vous venez de vous déconnecter')),
                          );
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage(false, User(0,"null","null","null","null",false,[],[]))));
                        },
                        color: Colors.indigoAccent,
                        textColor: Colors.white,
                        child: const Text("Se déconnecter"),
                      ),
                    ),


                  ],
                ),
                ),
              ),
            ),
          ),
        ));
  }




}