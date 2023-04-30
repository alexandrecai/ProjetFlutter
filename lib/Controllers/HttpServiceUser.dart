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
        if(curEmprunts['statut'] == "LIBRE"){
          statut = true;
        }
        print(curEmprunts['maisonEdition']['nom']);
        Book book = Book(curEmprunts['id'], curEmprunts['nom'], curEmprunts['description'], Categorie(curEmprunts['categorie']['id'],curEmprunts['categorie']['nom']), MaisonEdition(curEmprunts['maisonEdition']['id'],curEmprunts['maisonEdition']['nom'],[],[]), Author(curEmprunts['auteur']['id'],curEmprunts['auteur']['nom'],curEmprunts['auteur']['prenom']), curEmprunts['cote'], curEmprunts['isbn'], statut, curEmprunts['anneeParution'], []);
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


  Future<List<User>> getAllUsers() async {
    Uri request = Uri.http(baseURL,"/utilisateurs/");
    final http.Response res = await http.get(request);
    if(res.statusCode == 200){
      var body = jsonDecode(res.body);
      List<User> users = [];
      for (var CurrUser in body) {
        //print("user");
        List<Book> inWishlist = [];
        List<Book> livresEmpruntes = [];
        if(CurrUser['wishlists'] != []) {
          for (var curwishlist in CurrUser['wishlists']) {
            //print("la");
            bool statut = false;
            if (curwishlist['livre']['statut'] == "LIBRE") {
              statut = true;
            }
            //print(curwishlist['livre']['maisonEdition']['nom']);
            Book book = Book(
                curwishlist['livre']['id'],
                curwishlist['livre']['nom'],
                curwishlist['livre']['description'],
                Categorie(curwishlist['livre']['categorie']['id'],
                    curwishlist['livre']['categorie']['nom']),
                MaisonEdition(curwishlist['livre']['maisonEdition']['id'],
                    curwishlist['livre']['maisonEdition']['nom'], [], []),
                Author(curwishlist['livre']['auteur']['id'],
                    curwishlist['livre']['auteur']['nom'],
                    curwishlist['livre']['auteur']['prenom']),
                curwishlist['livre']['cote'],
                curwishlist['livre']['isbn'],
                statut,
                curwishlist['livre']['anneeParution'],
                []);
            inWishlist.add(book);
            //print(book.name);
          }
        }
        if(CurrUser['livresEmpruntes'] != []) {
          for (var curEmprunts in CurrUser['livresEmpruntes']) {
            //print("ici");
            bool statut = false;
            if (curEmprunts['statut'] == "LIBRE") {
              //print("if");
              statut = true;
            }
            //print(curEmprunts['maisonEdition']['nom']);
            Book book = Book(
                curEmprunts['id'],
                curEmprunts['nom'],
                curEmprunts['description'],
                Categorie(curEmprunts['categorie']['id'],
                    curEmprunts['categorie']['nom']),
                MaisonEdition(curEmprunts['maisonEdition']['id'],
                    curEmprunts['maisonEdition']['nom'], [], []),
                Author(curEmprunts['auteur']['id'],
                    curEmprunts['auteur']['nom'],
                    curEmprunts['auteur']['prenom']),
                curEmprunts['cote'],
                curEmprunts['isbn'],
                statut,
                curEmprunts['anneeParution'],
                []);
            livresEmpruntes.add(book);
          }
        }
        User user = User(CurrUser['id'],CurrUser['nom'],CurrUser['prenom'],CurrUser['mail'],CurrUser['motDePasse'],CurrUser['admin'],inWishlist,livresEmpruntes);
        print(user.nom);
        users.add(user);
      }
      return users;
    }
    else{
      List<User> users = [];
      return users;
    }
  }

  Future<http.Response> postUser(String nom, String prenom, String mail, String pswd, bool isAdmin) async {
    Map<String,dynamic> bodyMap = {
      'nom': nom,
      'prenom': prenom,
      'mail': mail,
      'mot_de_passe': pswd,
      'is_admin': isAdmin,
    };
    final body = jsonEncode(bodyMap);
    print(body.toString());
    Uri request = Uri.http(baseURL,"/utilisateurs/");
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

  Future<http.Response> updateUser(int id,String nom, String prenom, String mail, String pswd, bool isAdmin) async {
    Map<String,dynamic> bodyMap = {
      'nom': nom,
      'prenom': prenom,
      'mail': mail,
      'mot_de_passe': pswd,
      'is_admin': isAdmin,
    };
    final body = jsonEncode(bodyMap);
    Uri request = Uri.http(baseURL,"/utilisateurs/"+id.toString());
    print(body.toString());
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

  Future<int> getUserSize() async{
    Uri request = Uri.http(baseURL,"/utilisateurs/");
    final http.Response res = await http.get(request);
    if(res.statusCode == 200){
      var body = jsonDecode(res.body);
      int cpt = 0;
      for (var user in body) {
        cpt++;
      }
      return cpt;
    }
    else{
      return 0;
    }
  }

  Future<String> deleteUserByID(int id) async{
    Uri request = Uri.http(baseURL,"/utilisateurs/"+id.toString());
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