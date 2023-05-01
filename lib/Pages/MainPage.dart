import 'package:flutter/material.dart';
import 'package:projetflutter/Pages/AuthentificationPage.dart';
import 'package:projetflutter/Pages/BookCreationPage.dart';
import 'package:projetflutter/Pages/BookListPage.dart';
import 'package:projetflutter/Pages/LoginPage.dart';
import 'package:projetflutter/Pages/MaisonEditionCreationPage.dart';
import 'package:projetflutter/Pages/ProfilePage.dart';
import 'package:projetflutter/Pages/RegisterPage.dart';
import 'package:projetflutter/Pages/UserBookBorrowedPage.dart';
import 'package:projetflutter/Pages/WishlistPage.dart';

import '../Objects/User.dart';
import 'AuthorCreationPage.dart';

class MainPage extends StatefulWidget {

  bool isConnected;
  User currentUser;
  MainPage(this.isConnected,this.currentUser);

  @override
  State<StatefulWidget> createState() => MainPageState(isConnected,currentUser);
}

class MainPageState extends State<MainPage>{


  bool isConnected;
  User currentUser;
  MainPageState(this.isConnected,this.currentUser);

  int selectedIndex = 0;


  List<Widget> setPages(){
    if(isConnected){
      if(currentUser.isAdmin){
        return [
          BookListPage(currentUser: currentUser,),
          WishlistPage(currentUser),
          UserBookBorrowedPage(currentUser),
          ProfilePage(currentUser),
          BookCreationPage(),
          MaisonEditionCreationPage(),
          AuthorCreationPage()
        ];
      }
      return [
        BookListPage(currentUser: currentUser,),
        WishlistPage(currentUser),
        UserBookBorrowedPage(currentUser),
        ProfilePage(currentUser),
      ];
    }
    return [
      AuthentificationPage()
    ];
  }

  BottomNavigationBar setBottomBar(){
    if(currentUser.isAdmin){
      return BottomNavigationBar(
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (int index){
          setState((){
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.library_books),label: "Bibliothèque"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Wishlist"),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark),label: "Mes livres empruntés"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profil"),
          BottomNavigationBarItem(icon: Icon(Icons.book),label: "Creer livre"),
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Creer Maison Edition"),
          BottomNavigationBarItem(icon: Icon(Icons.create),label: "Creer Auteur"),
        ],
      );
    }
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index){
        setState((){
          selectedIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.library_books),label: "Bibliothèque"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Wishlist"),
        BottomNavigationBarItem(icon: Icon(Icons.bookmark),label: "Mes livres empruntés"),
        BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profil"),]
    );
  }



  NavigationRail setNavigationBar(){

    var Width = MediaQuery.of(context).size.width;
    var Height = MediaQuery.of(context).size.height;

    if(currentUser.isAdmin){
      return NavigationRail(
        onDestinationSelected: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        groupAlignment: BorderSide.strokeAlignCenter,
        minWidth: Width*0.05,
        selectedIndex: selectedIndex, destinations: [
        NavigationRailDestination(
            icon: Icon(Icons.library_books,size: Height>600 ? Height*0.05 : Height*0.1 ), label: const Text('Bibliothèque'),padding: EdgeInsetsDirectional.all(8)),
        NavigationRailDestination(
            icon: Icon(Icons.favorite,size: Height>600 ? Height*0.05 : Height*0.1), label: const Text('Wishlist'), padding: EdgeInsetsDirectional.all(8)),
        NavigationRailDestination(
            icon: Icon(Icons.bookmark,size: Height>600 ? Height*0.05 : Height*0.1), label: const Text('Mes livres empruntés'), padding: EdgeInsetsDirectional.all(8)),
          NavigationRailDestination(
              icon: Icon(Icons.person,size: Height>600 ? Height*0.05 : Height*0.1), label: const Text('Profil'), padding: EdgeInsetsDirectional.all(8)),
        NavigationRailDestination(
            icon: Icon(Icons.book,size: Height>600 ? Height*0.05 : Height*0.1), label: const Text('Créer livre'), padding: EdgeInsetsDirectional.all(8)),
        NavigationRailDestination(
            icon: Icon(Icons.house,size: Height>600 ? Height*0.05 : Height*0.1), label: const Text('Créer maison edition'), padding: EdgeInsetsDirectional.all(8)),
        NavigationRailDestination(
            icon: Icon(Icons.create,size: Height>600 ? Height*0.05 : Height*0.1), label: const Text('Créer auteur'), padding: EdgeInsetsDirectional.all(8)),
        ],
        labelType: NavigationRailLabelType.all,
        selectedLabelTextStyle: const TextStyle(
          color: Colors.indigoAccent,
        ),
        leading: Column(
          children: const [
            SizedBox(
              height: 10,
            ),
          ],
        ),);
    }

    return NavigationRail(


      onDestinationSelected: (int index) {
        setState(() {
          selectedIndex = index;
        });
      },
      groupAlignment: BorderSide.strokeAlignCenter,
      minWidth: Width*0.05,
      selectedIndex: selectedIndex, destinations: [
      NavigationRailDestination(
          icon: Icon(Icons.library_books,size: Height>600 ? Height*0.05 : Height*0.1 ), label: const Text('Bibliothèque'),padding: EdgeInsetsDirectional.all(8)),
      NavigationRailDestination(
          icon: Icon(Icons.favorite,size: Height>600 ? Height*0.05 : Height*0.1 ), label: const Text('Wishlist'),padding: EdgeInsetsDirectional.all(8)),
      NavigationRailDestination(
          icon: Icon(Icons.bookmark,size: Height>600 ? Height*0.05 : Height*0.1 ), label: const Text('Mes livres empruntés'),padding: EdgeInsetsDirectional.all(8)),
      NavigationRailDestination(
          icon: Icon(Icons.person,size: Height>600 ? Height*0.05 : Height*0.1 ), label: const Text('Profil'),padding: EdgeInsetsDirectional.all(8)),
      ],
      labelType: NavigationRailLabelType.all,
      selectedLabelTextStyle: const TextStyle(
        color: Colors.indigoAccent,
      ),

      leading: Column(
        children: const [
          SizedBox(
            height: 10,
          ),
        ],
      )

      );

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: MediaQuery.of(context).size.width < 600 && isConnected ?
      setBottomBar():null,
      backgroundColor: Colors.white,
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width >= 600)
            LayoutBuilder(builder: (context,constraints){
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: isConnected ? setNavigationBar() : null,
                  ),
                ),
              );
            })
          ,
          Expanded(child: setPages()[selectedIndex]),
        ]
      ),

    );


  }

}