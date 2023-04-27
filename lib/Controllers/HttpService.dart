import 'dart:convert';
import 'dart:async';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../Objects/Author.dart';

class HttpService {



  final String authorURL = "localhost:8080";  //       Pour le Web
  //final String authorURL = "10.0.2.2:8080"; //        pour Android

  Future<String> getAuthorByID(int id) async {

    print("test");
    Uri request = Uri.http(authorURL,"/authors/1");
    print(request.toString());

    final http.Response res = await http.get(request);
    print("test2");

    if(res.statusCode == 200){
      final obj = jsonDecode(res.body);
      //print("Resultat requete : "+obj['nom']);
      Author author = Author(obj['id'],obj['nom'],obj['prenom']);
      return res.body;
    }
    else{
      return "Not found";
    }
  }
}