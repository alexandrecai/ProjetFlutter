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

  Future<Wishlist> getWishlistById(int userId, int bookId) async {
    Uri request = Uri.http(baseURL,"/wishlists/" + userId.toString() + "/" + bookId.toString());
    final http.Response response = await http.get(request);
    if(response.statusCode == 200) {
      final _wishlist = jsonDecode(response.body);
      Wishlist wishlist = Wishlist(_wishlist["id"]["utilisateurId"], _wishlist["id"]["livreId"]);
      return wishlist;
    }
    else {
      return Wishlist(0, 0);
    }
  }

  Future<List<Wishlist>> getWishlistsByUserId(int userId) async {
    Uri request = Uri.http(baseURL, "/wishlists/utilisateur/" + userId.toString());
    final http.Response response = await http.get(request);
    if(response.statusCode == 200){
      var body = jsonDecode(response.body);
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

  Future<List<Wishlist>> getWishlistsByBookId(int bookId) async {
    Uri request = Uri.http(baseURL, "/wishlists/livre/" + bookId.toString());
    final http.Response response = await http.get(request);
    if(response.statusCode == 200){
      var body = jsonDecode(response.body);
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

  // à modifier
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

  // à modifier
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



  Future<int> getWishlistSize() async{
    Uri request = Uri.http(baseURL,"/wishlists/");
    final http.Response res = await http.get(request);
    if(res.statusCode == 200){
      var body = jsonDecode(res.body);
      int cpt = 0;
      for (var wishlist in body) {
        cpt++;
      }
      return cpt;
    }
    else{
      return 0;
    }
  }

  Future<String> deleteWishlistByID(int id) async{
    Uri request = Uri.http(baseURL,"/wishlists/"+id.toString());
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