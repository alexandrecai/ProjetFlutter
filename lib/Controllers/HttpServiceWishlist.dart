import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:projetflutter/Objects/Categorie.dart';

import '../Objects/Author.dart';
import '../Objects/Wishlist.dart';

class HttpServiceWishlist {

  final String baseURL = "localhost:8080";  //       Pour le Web
  //final String baseURL = "10.0.2.2:8080"; //        pour Android

  Future<List<Wishlist>> getAllWishlist() async {
    Uri request = Uri.http(baseURL,"/wishlists/");
    final http.Response res = await http.get(request);
    if(res.statusCode == 200){
      var body = jsonDecode(res.body);
      List<Wishlist> wishlists = [];
      for (var wishlist in body) {
        Wishlist wish = Wishlist(
          wishlist["id"]["utilisateurId"],
          wishlist["id"]["livreId"]
        );
        print(wishlist.toString());
        wishlists.add(wish);
      }
      return wishlists;
    }
    else{
      List<Wishlist> wishlists = [];
      return wishlists;
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