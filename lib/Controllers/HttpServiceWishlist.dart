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


  Future<http.Response> postWishlist(int utilisateurId, int livreId) async {
    Map<String,dynamic> bodyMap = {
      "utilisateur_id" : utilisateurId,
      "livre_id" : livreId
    };
    final body = jsonEncode(bodyMap);
    Uri request = Uri.http(baseURL,"/wishlists/");
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

  // à modifier
  Future<http.Response> updateWishlist(int utilisateurId, int livreId, int newUtilisateurId, int newLivreId) async {
    Map<String,dynamic> bodyMap = {
      "utilisateur_id" : newUtilisateurId,
      "livre_id" : newLivreId
    };
    final body = jsonEncode(bodyMap);
    Uri request = Uri.http(baseURL,"/wishlists/"+utilisateurId.toString()+"/"+livreId.toString());
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

  Future<String> deleteWishlistByID(int utilisateurId, int livreId) async{
    Uri request = Uri.http(baseURL,"/wishlists/"+utilisateurId.toString()+"/"+livreId.toString());
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