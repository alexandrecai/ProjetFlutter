import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:projetflutter/Objects/Categorie.dart';

import '../Objects/Author.dart';

class HttpServiceAuthor {

  final String baseURL = "localhost:8080";  //       Pour le Web
  //final String baseURL = "10.0.2.2:8080"; //        pour Android

  Future<Author> getAuthorByID(int id) async {
    Uri request = Uri.http(baseURL,"/auteurs/"+ id.toString());
    final http.Response res = await http.get(request);
    if(res.statusCode == 200){
      final obj = jsonDecode(res.body);
      Author author = Author(obj['id'],obj['nom'],obj['prenom']);
      return author;
    }
    else{
      return Author(0, "noauthor", "noauthor");
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
    else if(res.statusCode == 409){
      // Conflit - l'auteur est lié à au moins un livre
      return res.statusCode.toString();
    }
    else{
      print(res.statusCode.toString());
      return res.statusCode.toString();
    }
  }

}