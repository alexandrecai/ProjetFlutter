import 'package:flutter/material.dart';
import 'package:projetflutter/Pages/AuthentificationPage.dart';
import 'package:projetflutter/Pages/BookCreationPage.dart';
import 'package:projetflutter/Pages/LoginPage.dart';
import 'package:projetflutter/Pages/RegisterPage.dart';

class MainPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage>{

  int selectedIndex = 0;

  final List<Widget> pages = [
    AuthentificationPage(),
    BookCreationPage(),
    RegisterPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: MediaQuery.of(context).size.width < 600?
      BottomNavigationBar(
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (int index){
          setState((){
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "Connexion"),
          BottomNavigationBarItem(icon: Icon(Icons.book),label: "Ajoute un livre"),
          BottomNavigationBarItem(icon: Icon(Icons.library_books),label: "Bibliothèque"),
          BottomNavigationBarItem(icon: Icon(Icons.star),label: "Wishlist"),

        ],
      ):null,
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
                    child: NavigationRail(

                      onDestinationSelected: (int index) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      selectedIndex: selectedIndex, destinations: const [
                      NavigationRailDestination(
                          icon: Icon(Icons.person),label: Text("Connexion")),
                      NavigationRailDestination(
                          icon: Icon(Icons.book), label: Text('Ajoute un livre')),
                      NavigationRailDestination(
                          icon: Icon(Icons.library_books), label: Text('Bibliothèque')),
                      NavigationRailDestination(
                          icon: Icon(Icons.star), label: Text('Wishlist')),],
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
                      ),),
                  ),
                ),
              );
            })

          ,
          Expanded(child: pages[selectedIndex]),
        ]

      ),

    );


  }

}