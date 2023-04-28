<<<<<<< HEAD
// /*
// import 'dart:convert';
// import 'dart:async';
// import 'dart:developer';
//
// import 'package:http/http.dart' as http;
//
// import '../Objects/Author.dart';
//
// class HttpService {
//
// <<<<<<< HEAD
//
//
//   //final String authorURL = "localhost:8080";  //       Pour le Web
//   final String authorURL = "10.0.2.2:8080"; //        pour Android
// =======
//   final String authorURL = "localhost:8080";  //       Pour le Web
//   //final String authorURL = "10.0.2.2:8080"; //        pour Android
// >>>>>>> 8b24c5499b1e56eaa85ab04937fe8222b96203f4
//
//   Future<Author> getAuthorByID(int id) async {
//     Uri request = Uri.http(authorURL,"/authors/"+ id.toString());
//     final http.Response res = await http.get(request);
//     if(res.statusCode == 200){
//       final obj = jsonDecode(res.body);
//       //print("Resultat requete : "+obj['nom']);
//       Author author = Author(obj['id'],obj['nom'],obj['prenom']);
//       return author;
//     }
//     else{
//       return Author(0, "noauthor", "noauthor");
//     }
//   }
//
//   Future<http.Response> postAuthor(int id,String nom,String prenom) async {
//     String stringRequest = authorURL+"/authors/create?nom="+nom+"&prenom="+prenom+"&id="+ id.toString();
//     Map<String,Object> parameters = Map();
//     parameters.putIfAbsent("nom", () => nom);
//     parameters.putIfAbsent("prenom", () => prenom);
//     parameters.putIfAbsent("id", () => id.toString());
//     Uri request = Uri.http(authorURL,"/authors/create",parameters);
//     print(stringRequest);
//     final http.Response res = await http.post(request,headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     });
//     print(res.statusCode);
//     return res;
//   }
//
//   Future<List<Author>> getAllAuthors() async {
//     Uri request = Uri.http(authorURL,"/authors/all");
//     final http.Response res = await http.get(request);
//     if(res.statusCode == 200){
//       var body = jsonDecode(res.body);
//       List<Author> authors = [];
//       for (var author in body) {
//         Author auth = Author(
//             author["id"],
//             author["nom"],
//             author["prenom"],
//         );
//         print(author.toString());
//         authors.add(auth);
//       }
//       return authors;
//     }
//     else{
//       List<Author> authors = [];
//       return authors;
//     }
//   }
//
//   Future<int> getAuthorSize() async{
//     Uri request = Uri.http(authorURL,"/authors/size");
//     final http.Response res = await http.get(request);
//     if(res.statusCode == 200){
//       var size = jsonDecode(res.body);
//       return size;
//     }
//     else{
//       return 0;
//     }
//   }
//
//
//   Future<String> deleteAuthorById(int id) async{
//     Uri request = Uri.http(authorURL,"/authors/"+id.toString());
//     final http.Response res = await http.delete(request);
//     if(res.statusCode == 204){
//       return res.statusCode.toString();
//     }
//     else{
//       return res.statusCode.toString();
//     }
//   }
// }*/
=======
import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:projetflutter/Objects/Categorie.dart';

import '../Objects/Author.dart';

class HttpService {

  final String baseURL = "localhost:8080";  //       Pour le Web
  //final String baseURL = "10.0.2.2:8080"; //        pour Android

  Future<Author> getAuthorByID(int id) async {
    Uri request = Uri.http(baseURL,"/authors/"+ id.toString());
    final http.Response res = await http.get(request);
    if(res.statusCode == 200){
      final obj = jsonDecode(res.body);
      //print("Resultat requete : "+obj['nom']);
      Author author = Author(obj['id'],obj['nom'],obj['prenom']);
      return author;
    }
    else{
      return Author(0, "noauthor", "noauthor");
    }
  }

  Future<http.Response> postAuthor(int id,String nom,String prenom) async {
    String stringRequest = baseURL+"/authors/create?nom="+nom+"&prenom="+prenom+"&id="+ id.toString();
    Map<String,Object> parameters = Map();
    parameters.putIfAbsent("nom", () => nom);
    parameters.putIfAbsent("prenom", () => prenom);
    parameters.putIfAbsent("id", () => id.toString());
    Uri request = Uri.http(baseURL,"/authors/create",parameters);
    print(stringRequest);
    final http.Response res = await http.post(request,headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    print(res.statusCode);
    return res;
  }

  Future<List<Author>> getAllAuthors() async {
    Uri request = Uri.http(baseURL,"/authors/all");
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
    Uri request = Uri.http(baseURL,"/authors/size");
    final http.Response res = await http.get(request);
    if(res.statusCode == 200){
      var size = jsonDecode(res.body);
      return size;
    }
    else{
      return 0;
    }
  }


  Future<String> deleteAuthorByID(int id) async{
    Uri request = Uri.http(baseURL,"/authors/"+id.toString());
    final http.Response res = await http.delete(request);
    if(res.statusCode == 204){
      return res.statusCode.toString();
    }
    else{
      return res.statusCode.toString();
    }
  }

  Future<Categorie> getCategorieByID(int id) async {
    Uri request = Uri.http(baseURL,"/categories/"+ id.toString());
    final http.Response res = await http.get(request);
    if(res.statusCode == 200){
      final obj = jsonDecode(res.body);
      return Categorie( obj['id'], obj['nom']);
    }
    else{
      return Categorie(0,"noname");
    }
  }

  Future<http.Response> postCategorie(int id,String nom) async {
    String stringRequest = baseURL+"/categories/create?nom="+nom+"&id="+ id.toString();
    Map<String,Object> parameters = Map();
    parameters.putIfAbsent("nom", () => nom);
    parameters.putIfAbsent("id", () => id.toString());
    Uri request = Uri.http(baseURL,"/categories/create",parameters);
    print(stringRequest);
    final http.Response res = await http.post(request,headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    print(res.statusCode);
    return res;
  }

  Future<List<Categorie>> getAllCategories() async {
    Uri request = Uri.http(baseURL,"/categories/all");
    final http.Response res = await http.get(request);
    if(res.statusCode == 200){
      var body = jsonDecode(res.body);
      List<Categorie> categories = [];
      for (var _categorie in body) {
        Categorie categorie = Categorie(
          _categorie["id"],
          _categorie["nom"]
        );
        print(categorie.toString());
        categories.add(categorie);
      }
      return categories;
    }
    else{
      List<Categorie> categories = [];
      return categories;
    }
  }

  Future<int> getCategorieSize() async{
    Uri request = Uri.http(baseURL,"/categories/size");
    final http.Response res = await http.get(request);
    if(res.statusCode == 200){
      var size = jsonDecode(res.body);
      return size;
    }
    else{
      return 0;
    }
  }

  Future<String> deleteCategorieByID(int id) async{
    Uri request = Uri.http(baseURL,"/categories/"+id.toString());
    final http.Response res = await http.delete(request);
    if(res.statusCode == 204){
      return res.statusCode.toString();
    }
    else{
      return res.statusCode.toString();
    }
  }
}
>>>>>>> 37cd5f772ea71637cf6a64612d29982ea39df7f5
