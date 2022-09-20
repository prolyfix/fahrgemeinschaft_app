import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  String object = "/";
  Map<String, dynamic> params = {};
  final String prefix = "http://fahrgemeinschaft.enconstruction.de/api";
  late Map<String, dynamic> rawReponse = {};
  late Map<String, dynamic> data;

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
    if (params.isNotEmpty) {
      url += '?';
    }
    params.forEach((k, v) => {url += k + '=' + v + '&'});

    if (params.isNotEmpty) {
      url = url.substring(0, url.length - 1);
    }
    debugPrint(url);
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      rawReponse = jsonDecode(response.body);
      return true;
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
    inspect(rawReponse["hydra:member"]);
    return rawReponse["hydra:member"];
  }
}
