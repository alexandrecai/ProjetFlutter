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
