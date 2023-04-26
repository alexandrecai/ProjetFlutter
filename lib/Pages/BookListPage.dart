import 'package:flutter/material.dart';
import 'package:projetflutter/Pages/BookDetailsPage.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

  class _BookListPageState extends State<BookListPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
  appBar: AppBar(
    title: new Center(child: new Text("Liste des livres", textAlign: TextAlign.center)),

  ),
  floatingActionButton: FloatingActionButton(
  child: const Icon(Icons.search),
  onPressed: () {
  Navigator.push(context,
  MaterialPageRoute(builder: (_) => const BookDetailsPage()));
  },
  ),
  body: ListView.builder(
  itemCount: 20,
  itemBuilder: (context, i) => ListTile(
  leading: const Icon(Icons.book),
  title: Text("Titre du livre $i"),
  subtitle: Text("description du livre $i ..."),
  onTap: () {},
  ),
  ),
  );
  
}
