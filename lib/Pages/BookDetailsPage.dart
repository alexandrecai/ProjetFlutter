  import 'package:flutter/material.dart';

class BookDetailsPage extends StatelessWidget {
  final String title;
  final String author;
  final String description;
  final String year;
  final String isbn;

  const BookDetailsPage({
    Key? key,
    required this.title,
    required this.author,
    required this.description,
    required this.year,
    required this.isbn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              author,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              description,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text(
              year,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text(
              isbn,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Code pour ajouter un livre
                  },
                  child: Text('Wishlist'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Code pour emprunter un livre
                  },
                  child: Text('Emprunter'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Code pour rendre un livre
                  },
                  child: Text('Rendre'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
