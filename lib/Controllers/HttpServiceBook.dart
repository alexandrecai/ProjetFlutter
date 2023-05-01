import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:projetflutter/Objects/Book.dart';
import 'package:projetflutter/Objects/Categorie.dart';
import 'package:projetflutter/Objects/MaisonEdition.dart';

import '../Objects/Author.dart';
import '../Objects/User.dart';

class HttpServiceBook {

  final String baseURL = "localhost:8080";  //       Pour le Web
  //final String baseURL = "10.0.2.2:8080"; //        pour Android

  Future<Book> getBookByID(int id) async {
    Uri request = Uri.http(baseURL,"/livres/"+ id.toString());
    //print("debut");
    final http.Response res = await http.get(request);
    //print(res.body);
    if(res.statusCode == 200){
      final obj = jsonDecode(res.body);
      bool statut = false;
      if(obj['statut'] == "LIBRE"){
        statut = true;
      }
      Book book = Book(obj['id'],obj['nom'],obj['description'],Categorie(obj['categorie']["id"],obj['categorie']["nom"]),MaisonEdition(obj['maisonEdition']["id"],obj['maisonEdition']["nom"],[],[]),Author(obj['auteur']["id"],obj['auteur']["nom"],obj['auteur']["prenom"]),obj['cote'],obj['isbn'],statut,obj['anneeParution'],[]);
      //print("Resultat requete : "+book.toString());
      return book;
    }
    else{
      //print("test ici");
      return Book(0, "nodata", "nodata",Categorie(0,"nodata"),MaisonEdition(0,"nodata",[],[]),Author(0,"nodata","nodata"),"nodata","nodata",false,0,[]);
    }
  }

  Future<http.Response> postBook(String nom,String description,Categorie categorie,MaisonEdition maisonEdition,Author author,String cote,String ISBN,int annee,bool statut) async {
    Map<String,dynamic> bodyMap = {
      'nom': nom,
      'description': description,
      'categorie': categorie.ID,
      'maison_edition': maisonEdition.ID,
      'auteur': author.ID,
      'cote': cote,
      'ISBN': ISBN,
      'annee': annee,
      'statut': statut
    };
    final body = jsonEncode(bodyMap);
    Uri request = Uri.http(baseURL,"/livres/");
    print(body.toString());
    final http.Response res = await http.post(
        request,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: body
    );
    print(res.statusCode);
    return res;
  }


  Future<http.Response> updateBook(int id,String nom,String description,Categorie categorie,MaisonEdition maisonEdition,Author author,String cote,String ISBN,int annee,bool statut, int idUserEmprunt) async {
    Map<String,Object> bodyMap = {
      'nom': nom,
      'description': description,
      'categorie': categorie.ID,
      'maison_edition': maisonEdition.ID,
      'auteur': author.ID,
      'cote': cote,
      'ISBN': ISBN,
      'annee': annee,
      'statut': statut,
      'emprunte_par' : idUserEmprunt
    };
    final body = jsonEncode(bodyMap);
    Uri request = Uri.http(baseURL,"/livres/"+id.toString());
    print(request.toString());
    final http.Response res = await http.put(
        request,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: body
    );
    print(res.statusCode);
    return res;
  }

  Future<http.Response> rendreBook(int id,String nom,String description,Categorie categorie,MaisonEdition maisonEdition,Author author,String cote,String ISBN,int annee,bool statut) async {
    Map<String,dynamic> bodyMap = {
      'nom': nom,
      'description': description,
      'categorie': categorie.ID,
      'maison_edition': maisonEdition.ID,
      'auteur': author.ID,
      'cote': cote,
      'ISBN': ISBN,
      'annee': annee,
      'statut': statut,
    };
    final body = jsonEncode(bodyMap);
    Uri request = Uri.http(baseURL,"/livres/"+id.toString());
    print(request.toString());
    final http.Response res = await http.put(
        request,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: body
    );
    print(res.statusCode);
    return res;
  }


  Future<List<Book>> getAllBook() async {
    Uri request = Uri.http(baseURL,"/livres/");
    final http.Response res = await http.get(request);
    print(res.statusCode);
    if(res.statusCode == 200){
      var body = jsonDecode(res.body);
      List<Book> books = [];
      for (var liv in body) {
        bool statut = false;
        if(liv['statut'] == "LIBRE"){
          statut = true;
        }
        Book livre = Book(
            liv['id'],liv['nom'],liv['description'],Categorie(liv['categorie']["id"],liv['categorie']["nom"]),MaisonEdition(liv['maisonEdition']["id"],liv['maisonEdition']["nom"],[],[]),Author(liv['auteur']["id"],liv['auteur']["nom"],liv['auteur']["prenom"]),liv['cote'],liv['isbn'],statut,liv['anneeParution'],[]
        );
        print(livre.toString());
        books.add(livre);
      }
      return books;
    }
    else{
      List<Book> books = [];
      return books;
    }
  }

  Future<List<Book>> getAllBookByAuthor(int authorId) async {
    Uri request = Uri.http(baseURL,"/livres/auteur/"+authorId.toString());
    final http.Response res = await http.get(request);
    print(res.statusCode);
    if(res.statusCode == 200){
      var body = jsonDecode(res.body);
      List<Book> books = [];
      for (var liv in body) {
        bool statut = false;
        if(liv['statut'] == "LIBRE"){
          statut = true;
        }
        Book livre = Book(
            liv['id'],liv['nom'],liv['description'],Categorie(liv['categorie']["id"],liv['categorie']["nom"]),MaisonEdition(liv['maisonEdition']["id"],liv['maisonEdition']["nom"],[],[]),Author(liv['auteur']["id"],liv['auteur']["nom"],liv['auteur']["prenom"]),liv['cote'],liv['isbn'],statut,liv['anneeParution'],[]
        );
        print(livre.toString());
        books.add(livre);
      }
      return books;
    }
    else{
      List<Book> books = [];
      return books;
    }
  }

  Future<List<Book>> getAllBookByCategorie(int categorieId) async {
    Uri request = Uri.http(baseURL,"/livres/categorie/"+categorieId.toString());
    final http.Response res = await http.get(request);
    print(res.statusCode);
    if(res.statusCode == 200){
      var body = jsonDecode(res.body);
      List<Book> books = [];
      for (var liv in body) {
        bool statut = false;
        if(liv['statut'] == "LIBRE"){
          statut = true;
        }
        Book livre = Book(
            liv['id'],liv['nom'],liv['description'],Categorie(liv['categorie']["id"],liv['categorie']["nom"]),MaisonEdition(liv['maisonEdition']["id"],liv['maisonEdition']["nom"],[],[]),Author(liv['auteur']["id"],liv['auteur']["nom"],liv['auteur']["prenom"]),liv['cote'],liv['isbn'],statut,liv['anneeParution'],[]
        );
        print(livre.toString());
        books.add(livre);
      }
      return books;
    }
    else{
      List<Book> books = [];
      return books;
    }
  }

  Future<List<Book>> getAllBookByUtilisateur(int utilisateurId) async {
    Uri request = Uri.http(baseURL,"/livres/emprunte-par/"+utilisateurId.toString());
    final http.Response res = await http.get(request);
    print(res.statusCode);
    if(res.statusCode == 200){
      var body = jsonDecode(res.body);
      List<Book> books = [];
      for (var liv in body) {
        bool statut = false;
        if(liv['statut'] == "LIBRE"){
          statut = true;
        }
        Book livre = Book(
            liv['id'],liv['nom'],liv['description'],Categorie(liv['categorie']["id"],liv['categorie']["nom"]),MaisonEdition(liv['maisonEdition']["id"],liv['maisonEdition']["nom"],[],[]),Author(liv['auteur']["id"],liv['auteur']["nom"],liv['auteur']["prenom"]),liv['cote'],liv['isbn'],statut,liv['anneeParution'],[]
        );
        print(livre.toString());
        books.add(livre);
      }
      return books;
    }
    else{
      List<Book> books = [];
      return books;
    }
  }

  Future<List<Book>> getAllBookByName(String name) async {
    Uri request = Uri.http(baseURL,"/livres/nom/"+name);
    final http.Response res = await http.get(request);
    print(res.statusCode);
    if(res.statusCode == 200){
      var body = jsonDecode(res.body);
      List<Book> books = [];
      for (var liv in body) {
        bool statut = false;
        if(liv['statut'] == "LIBRE"){
          statut = true;
        }
        Book livre = Book(
            liv['id'],liv['nom'],liv['description'],Categorie(liv['categorie']["id"],liv['categorie']["nom"]),MaisonEdition(liv['maisonEdition']["id"],liv['maisonEdition']["nom"],[],[]),Author(liv['auteur']["id"],liv['auteur']["nom"],liv['auteur']["prenom"]),liv['cote'],liv['isbn'],statut,liv['anneeParution'],[]
        );
        print(livre.toString());
        books.add(livre);
      }
      return books;
    }
    else{
      List<Book> books = [];
      return books;
    }
  }

  Future<int> getBookSize() async{
    Uri request = Uri.http(baseURL,"/livres/");
    final http.Response res = await http.get(request);
    if(res.statusCode == 200){
      var body = jsonDecode(res.body);
      int cpt = 0;
      for (var book in body) {
        cpt++;
      }
      return cpt;
    }
    else{
      return 0;
    }
  }


  Future<String> deleteBookByID(int id) async{
    Uri request = Uri.http(baseURL,"/livres/"+id.toString());
    final http.Response res = await http.delete(request);
    if(res.statusCode == 204){
      return res.statusCode.toString();
    }
    else{
      return res.statusCode.toString();
    }
  }

}