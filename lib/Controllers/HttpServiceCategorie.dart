import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:projetflutter/Objects/Categorie.dart';

import '../Objects/Author.dart';

class HttpServiceCategorie {

  final String baseURL = "localhost:8080";  //       Pour le Web
  //final String baseURL = "10.0.2.2:8080"; //        pour Android


  Future<Categorie> getCategorieByID(int id) async {
    Uri request = Uri.http(baseURL,"/categories/"+ id.toString());
    final http.Response res = await http.get(request);
    print(res.body);
    if(res.statusCode == 200){
      final obj = jsonDecode(res.body);
      return Categorie( obj['id'], obj['nom']);
    }
    else{
      return Categorie(0,"noname");
    }
  }

  Future<http.Response> postCategorie(String nom) async {
    //String stringRequest = baseURL+"/categories/create?nom="+nom+"&id="+ id.toString();
    Map<String,dynamic> bodyMap = Map();
    bodyMap.putIfAbsent("nom", () => nom);
    final body = jsonEncode(bodyMap);
    Uri request = Uri.http(baseURL,"/categories/");
    print(body.toString());
    final http.Response res = await http.post(request,headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },body: body);
    print(res.statusCode);
    return res;
  }

  Future<http.Response> updateCategorie(int id,String nom) async {
    //String stringRequest = baseURL+"/categories/create?nom="+nom+"&id="+ id.toString();
    Map<String,dynamic> bodyMap = Map();
    bodyMap.putIfAbsent("nom", () => nom);
    final body = jsonEncode(bodyMap);
    Uri request = Uri.http(baseURL,"/categories/"+id.toString());
    print(body.toString());
    final http.Response res = await http.put(request,headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },body: body);
    print(res.statusCode);
    return res;
  }

  Future<List<Categorie>> getAllCategories() async {
    Uri request = Uri.http(baseURL,"/categories/");
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
    Uri request = Uri.http(baseURL,"/categories/");
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
      return categories.length;
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

