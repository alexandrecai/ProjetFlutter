import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.favorite,
                    color:Colors.deepOrange,
                  ),
                  SizedBox(width: 10),
                  Text(
                      'Favorites',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize:  25,
                          fontWeight: FontWeight.bold
                      )
                  )
                ],
              ),
              Expanded(
                child: Container(),
              )
            ]
        )
    );
  }
}