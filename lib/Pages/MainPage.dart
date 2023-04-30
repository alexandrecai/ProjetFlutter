import 'package:flutter/material.dart';
import 'package:projetflutter/Pages/AuthentificationPage.dart';
import 'package:projetflutter/Pages/BookCreationPage.dart';
import 'package:projetflutter/Pages/BookListPage.dart';
import 'package:projetflutter/Pages/LoginPage.dart';
import 'package:projetflutter/Pages/RegisterPage.dart';
import 'package:projetflutter/Pages/UserBookBorrowedPage.dart';
import 'package:projetflutter/Pages/WishlistPage.dart';

import '../Objects/User.dart';

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
          BookListPage(),
          WishlistPage(currentUser),
          UserBookBorrowedPage(currentUser),
          BookCreationPage(),
        ];
      }
      return [
        BookListPage(),
        WishlistPage(currentUser),
        UserBookBorrowedPage(currentUser),
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
          BottomNavigationBarItem(icon: Icon(Icons.book),label: "Ajoute un livre"),

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
        BottomNavigationBarItem(icon: Icon(Icons.bookmark),label: "Mes livres empruntés"),]
    );
  }



  NavigationRail setNavigationBar(){
    if(currentUser.isAdmin){
      return NavigationRail(
        onDestinationSelected: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        selectedIndex: selectedIndex, destinations: const [
        NavigationRailDestination(
            icon: Icon(Icons.library_books), label: Text('Bibliothèque')),
        NavigationRailDestination(
            icon: Icon(Icons.favorite), label: Text('Wishlist')),
        NavigationRailDestination(
            icon: Icon(Icons.bookmark), label: Text('Mes livres empruntés')),
        NavigationRailDestination(
            icon: Icon(Icons.book), label: Text('Ajoute un livre')),],
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
      selectedIndex: selectedIndex, destinations: const [
      NavigationRailDestination(
          icon: Icon(Icons.library_books), label: Text('Bibliothèque')),
      NavigationRailDestination(
          icon: Icon(Icons.favorite), label: Text('Wishlist')),
      NavigationRailDestination(
          icon: Icon(Icons.bookmark), label: Text('Mes livres empruntés')),
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