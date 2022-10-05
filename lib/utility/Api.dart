import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  String object = "/";
  Map<String, dynamic> params = {};
  final String prefix = "https://fahrgemeinschaft.enconstruction.de/api";
  late Map<String, dynamic> rawReponse = {};
  late Map<String, dynamic> data;

  Future<String?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('https://fahrgemeinschaft.enconstruction.de/api/login_check'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': 'marc.baudot@gmail.com',
        'password': 'sir0sE!24'
      }),
    );
    if (response.statusCode == 200) {
      rawReponse = jsonDecode(response.body);
      print(rawReponse['token']);
      return rawReponse["token"];
    } else {
      return null;
    }
  }

  bool isResponseEmpty() {
    return false;
  }

  void setObject(String objet) {
    this.object = "/" + objet;
  }

  void setParams(Map<String, dynamic> parametres) {
    this.params = parametres;
  }

  Future<bool> fetchApi() async {
    String url = prefix + object;
    FlutterSecureStorage secureStorage = FlutterSecureStorage();
    if (params.isNotEmpty) {
      url += '?';
    }
    params.forEach((k, v) => {url += k + '=' + v + '&'});

    if (params.isNotEmpty) {
      url = url.substring(0, url.length - 1);
    }
    debugPrint(url);
    final refreshToken =
        await secureStorage.read(key: 'refresh_token') ?? "null";
    final response = await http.get(Uri.parse(url),
        headers: {"Authorization": 'Bearer $refreshToken'});
    if (response.statusCode == 200) {
      rawReponse = jsonDecode(response.body);
      return true;
    } else if (response.statusCode == 401) {
      secureStorage.write(key: 'refresh_token', value: null);
    } else {
      throw Exception('Failed to load album');
    }
    ;

    return false;
  }

  bool isEmpty() {
    return rawReponse["hydra:totalItems"] == 0;
  }

  List<dynamic> getData() {
    return rawReponse["hydra:member"];
  }
}
