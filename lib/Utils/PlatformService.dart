import 'package:flutter/foundation.dart';

class PlatformService {
  static PlatformService? _instance = null;

  factory PlatformService() {
    if (_instance == null) {
      _instance = PlatformService._internal();
    }
    return _instance!;
  }

  PlatformService._internal();

  String testPlatform() {
    if(defaultTargetPlatform == TargetPlatform.android){
      print("Android :)");
      return "10.0.2.2:8080";
    }
    else {
      print("Web :(");
      return "localhost:8080";
    }
  }
}
