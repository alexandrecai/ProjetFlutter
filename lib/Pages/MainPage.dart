import 'package:flutter/material.dart';
import 'package:projetflutter/Pages/BookCreationPage.dart';

class MainPage extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.white,
     body: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Container(
             padding: EdgeInsets.zero, // padding - à modifier sûrement
             child: ElevatedButton(
               style: ElevatedButton.styleFrom(
                 // set button style
               ),
               onPressed: () {
                 Navigator.push(context, MaterialPageRoute(
                     builder: (context) {
                       return BookCreationPage();
                     },
                 ),
                 );
               },
               child: Text(
                   "Ajouter Livre",
                 // style : ajouter une police / une taille
               ),

             ),
           ),
           Container(
             padding: EdgeInsets.zero, // padding - à modifier sûrement
             child: ElevatedButton(
               style: ElevatedButton.styleFrom(
                 // set button style
               ),
               onPressed: () {
                 Navigator.push(context, MaterialPageRoute(
                   builder: (context) {
                     return BookCreationPage(); // à modifier
                   },
                 ),
                 );
               },
               child: Text(
                 "Consulter mon profil",
                 // style : ajouter une police / une taille
               ),

             ),
           ),
         ],
       ),
     ),
   );
  }

}