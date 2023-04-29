import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:projetflutter/Controllers/HttpServiceBook.dart';
import 'package:projetflutter/Objects/Categorie.dart';
import 'package:projetflutter/Objects/MaisonEdition.dart';
import 'package:projetflutter/Objects/User.dart';
import 'package:projetflutter/Objects/Wishlist.dart';

import '../Objects/Author.dart';
import '../Objects/Book.dart';

class HttpServiceUser {

  final String baseURL = "localhost:8080";  //       Pour le Web
  //final String baseURL = "10.0.2.2:8080"; //        pour Android

  Future<User> getUserByID(int id) async {
    Uri request = Uri.http(baseURL,"/utilisateurs/"+ id.toString());
    final http.Response res = await http.get(request);
    if(res.statusCode == 200){
      final obj = jsonDecode(res.body);
      List<Book> inWishlist = [];
      List<Book> livresEmpruntes = [];
      for(var curwishlist in obj['wishlists']){
        print("la");
        bool statut = false;
        if(curwishlist['livre']['statut'] == "LIBRE"){
          statut = true;
        }
        print(curwishlist['livre']['maisonEdition']['nom']);
        Book book = Book(curwishlist['livre']['id'], curwishlist['livre']['nom'], curwishlist['livre']['description'], Categorie(curwishlist['livre']['categorie']['id'],curwishlist['livre']['categorie']['nom']), MaisonEdition(curwishlist['livre']['maisonEdition']['id'],curwishlist['livre']['maisonEdition']['nom'],[],[]), Author(curwishlist['livre']['auteur']['id'],curwishlist['livre']['auteur']['nom'],curwishlist['livre']['auteur']['prenom']), curwishlist['livre']['cote'], curwishlist['livre']['isbn'], statut, curwishlist['livre']['anneeParution'], []);
        inWishlist.add(book);
      }
      for(var curEmprunts in obj['livresEmpruntes']){
        print("la");
        bool statut = false;
        if(curEmprunts['livre']['statut'] == "LIBRE"){
          statut = true;
        }
        print(curEmprunts['livre']['maisonEdition']['nom']);
        Book book = Book(curEmprunts['livre']['id'], curEmprunts['livre']['nom'], curEmprunts['livre']['description'], Categorie(curEmprunts['livre']['categorie']['id'],curEmprunts['livre']['categorie']['nom']), MaisonEdition(curEmprunts['livre']['maisonEdition']['id'],curEmprunts['livre']['maisonEdition']['nom'],[],[]), Author(curEmprunts['livre']['auteur']['id'],curEmprunts['livre']['auteur']['nom'],curEmprunts['livre']['auteur']['prenom']), curEmprunts['livre']['cote'], curEmprunts['livre']['isbn'], statut, curEmprunts['livre']['anneeParution'], []);
        livresEmpruntes.add(book);
      }
      User user = User(obj['id'],obj['nom'],obj['prenom'],obj['mail'],obj['motDePasse'],obj['admin'],inWishlist,livresEmpruntes);
      print(user.wishlist.toString());
      return user;
    }
    else{
      return User(0,"null","null","null","null",false,[],[]);
    }
  }


  Future<List<Author>> getAllAuthors() async {
    Uri request = Uri.http(baseURL,"/auteurs/");
    final http.Response res = await http.get(request);
    if(res.statusCode == 200){
      var body = jsonDecode(res.body);
      List<Author> authors = [];
      for (var author in body) {
        Author auth = Author(
          author["id"],
          author["nom"],
          author["prenom"],
        );
        print(author.toString());
        authors.add(auth);
      }
      return authors;
    }
    else{
      List<Author> authors = [];
      return authors;
    }
  }

  Future<http.Response> postAuthor(String nom,String prenom) async {
    //String stringRequest = baseURL+"/auteurs/?nom="+nom+"&prenom="+prenom+"&id="+ id.toString();
    Map<String,dynamic> bodyMap = Map();
    bodyMap.putIfAbsent("nom", () => nom);
    bodyMap.putIfAbsent("prenom", () => prenom);
    final body = jsonEncode(bodyMap);
    Uri request = Uri.http(baseURL,"/auteurs/");
    print(body.toString());
    final http.Response res = await http.post(request,headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },body: body);
    print(res.statusCode);
    return res;
  }

  Future<http.Response> updateAuthor(int id,String nom,String prenom) async {
    Map<String,dynamic> bodyMap = Map();
    bodyMap.putIfAbsent("nom", () => nom);
    bodyMap.putIfAbsent("prenom", () => prenom);
    final body = jsonEncode(bodyMap);
    Uri request = Uri.http(baseURL,"/auteurs/"+id.toString());
    print(body.toString());
    final http.Response res = await http.put(request,headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },body: body);
    print(res.statusCode);
    return res;
  }

  Future<int> getAuthorSize() async{
    Uri request = Uri.http(baseURL,"/auteurs/");
    final http.Response res = await http.get(request);
    if(res.statusCode == 200){
      var body = jsonDecode(res.body);
      List<Author> authors = [];
      for (var author in body) {
        Author auth = Author(
          author["id"],
          author["nom"],
          author["prenom"],
        );
        print(author.toString());
        authors.add(auth);
      }
      return authors.length;
    }
    else{
      return 0;
    }
  }

  Future<String> deleteAuthorByID(int id) async{
    Uri request = Uri.http(baseURL,"/auteurs/"+id.toString());
    final http.Response res = await http.delete(request);
    if(res.statusCode == 204){
      return res.statusCode.toString();
    }
    else{
      print(res.statusCode.toString());
      return res.statusCode.toString();
    }
  }

}