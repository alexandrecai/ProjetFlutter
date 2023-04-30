import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:projetflutter/Objects/Categorie.dart';
import 'package:projetflutter/Objects/MaisonEdition.dart';

import '../Objects/Author.dart';

class HttpServiceMaisonEdition {

  final String baseURL = "localhost:8080";  //       Pour le Web
  //final String baseURL = "10.0.2.2:8080"; //        pour Android

  Future<MaisonEdition> getMaisonEditionByID(int id) async {
    Uri request = Uri.http(baseURL,"/maisoneditions/"+ id.toString());
    final http.Response res = await http.get(request);
    if(res.statusCode == 200){
      final obj = jsonDecode(res.body);
      //print("Resultat requete : "+obj['nom']);
      MaisonEdition maisonEdition = MaisonEdition(obj['id'],obj['nom'],[],[]);
      return maisonEdition;
    }
    else{
      return MaisonEdition(0, "noauthor", [],[]);
    }
  }

  Future<http.Response> postMaisonEdition(String nom) async {
    //String stringRequest = baseURL+"/auteurs/?nom="+nom+"&prenom="+prenom+"&id="+ id.toString();
    Map<String,dynamic> bodyMap = Map();
    bodyMap.putIfAbsent("nom", () => nom);
    final body = jsonEncode(bodyMap);
    Uri request = Uri.http(baseURL,"/maisoneditions/");
    print(body.toString());
    final http.Response res = await http.post(request,headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },body: body);
    print(res.statusCode);
    return res;
  }

  Future<http.Response> updateMaisonEdition(int id,String nom) async {
    //String stringRequest = baseURL+"/auteurs/?nom="+nom+"&prenom="+prenom+"&id="+ id.toString();
    Map<String,dynamic> bodyMap = Map();
    bodyMap.putIfAbsent("nom", () => nom);
    final body = jsonEncode(bodyMap);
    Uri request = Uri.http(baseURL,"/maisoneditions/"+id.toString());
    print(body.toString());
    final http.Response res = await http.put(request,headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },body: body);
    print(res.statusCode);
    return res;
  }

  Future<List<MaisonEdition>> getAllMaisonEdition() async {
    Uri request = Uri.http(baseURL,"/maisoneditions/");
    final http.Response res = await http.get(request);
    if(res.statusCode == 200){
      var body = jsonDecode(res.body);
      List<MaisonEdition> maisons = [];
      for (var maison in body) {
        MaisonEdition mais = MaisonEdition(
            maison["id"],
            maison["nom"],
          [],
          []
        );
        print(mais.toString());
        maisons.add(mais);
      }
      return maisons;
    }
    else{
      List<MaisonEdition> maisons = [];
      return maisons;
    }
  }

  Future<int> getMaisonEditionSize() async{
    Uri request = Uri.http(baseURL,"/maisoneditions/");
    final http.Response res = await http.get(request);
    if(res.statusCode == 200){
      var body = jsonDecode(res.body);
      List<MaisonEdition> maisons = [];
      for (var maison in body) {
        MaisonEdition mais = MaisonEdition(
            maison["id"],
            maison["nom"],
            [],
            []
        );
        print(mais.toString());
        maisons.add(mais);
      }
      return maisons.length;
    }
    else{
      return 0;
    }
  }


  Future<String> deleteMaisonEditionByID(int id) async{
    Uri request = Uri.http(baseURL,"/maisoneditions/"+id.toString());
    final http.Response res = await http.delete(request);
    if(res.statusCode == 204){
      return res.statusCode.toString();
    }
    else if(res.statusCode == 409){
      // Conflit - la maison d'édtion est liée à au moins un livre
      return res.statusCode.toString();
    }
    else{
      return res.statusCode.toString();
    }
  }

}