import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:projetflutter/Objects/Author.dart';
class SQLiteController {

  String path = join('assets','biblio.db');


  SQLiteController(); // Constructeur

  Future initDB() async {
    final database = await openDatabase(
        path,
        version: 1,
        onCreate: (db,version) async {
          // Create tables
          await db.execute('CREATE TABLE IF NOT EXISTS auteur (id INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT NOT NULL, prenom TEXT NOT NULL)');
          await db.execute('CREATE TABLE IF NOT EXISTS categorie (id INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT NOT NULL)');
          await db.execute('CREATE TABLE IF NOT EXISTS livre (id INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT NOT NULL, description TEXT NOT NULL, categorie INTEGER, maisonedition INTEGER NOT NULL, auteur INTEGER NOT NULL, cote INTEGER, ISBN INTEGER, annee INTEGER NOT NULL, statut INTEGER NOT NULL, FOREIGN KEY(auteur) REFERENCES auteur(id), FOREIGN KEY(categorie) REFERENCES categorie(id))');
          await db.execute('CREATE TABLE IF NOT EXISTS maisonedition (id INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT NOT NULL, auteurs INTEGER, livres INTEGER, FOREIGN KEY(auteurs) REFERENCES auteur(id), FOREIGN KEY(livres) REFERENCES livre(id))');
          await db.execute('CREATE TABLE IF NOT EXISTS utilisateur (id INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT NOT NULL, prenom TEXT NOT NULL, mail TEXT NOT NULL, mdp TEXT NOT NULL, isadmin INTEGER NOT NULL, livreemprunte INTEGER NOT NULL, FOREIGN KEY(livreemprunte) REFERENCES livre(id))');
          await db.execute('CREATE TABLE IF NOT EXISTS wishlist (id INTEGER PRIMARY KEY AUTOINCREMENT, livre INTEGER NOT NULL, utilisateur INTEGER NOT NULL, FOREIGN KEY(livre) REFERENCES livre(id), FOREIGN KEY(utilisateur) REFERENCES utilisateur(id))');
        }
    );
  }

  Future<List<Author>> getAuthor() async {

    bool exist = await databaseExists(path);

    if(exist){
      print("DB exist");

      final database = await openDatabase(path);

      final List<Map<String, dynamic>> maps = await database.rawQuery('SELECT * FROM auteur;');

      close(database);

      print(maps);

      return List.generate(maps.length, (i) {
        return Author( maps[i]['id'], maps[i]['nom'], maps[i]['prenom']);
      });
    }
    else{
      print("DB no exist");

      initDB();

      List<Author> author = [];

      return author;
    }

  }





  Future<void> insertAuteur(Author author) async{

    bool exist = await databaseExists(path);

    if(exist){
      final database = await openDatabase(path);

      Map<String,dynamic> authorMap = author.toMap();

      authorMap.remove('id'); // /!\ On enlève l'ID lors de l'ajout dans la DB car auto increment

      print(authorMap);

      await database.insert(
        'auteur',
        author.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      close(database);

      await getAuthor();
    }
  }

  Future close(Database database) async{
    database.close();
  }

}