import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  String object = "/";
  Map<String, dynamic> params = {};
  final String prefix = "http://fahrgemeinschaft.enconstruction.de/api";
  late Map<String, dynamic> rawReponse;
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

  Future<Null> fetchApi() async {
    String url = prefix + object;
    if (params.isNotEmpty) {
      url += '?';
    }
    params.forEach((k, v) => {url += k + '=' + v + '&'});

    if (params.isNotEmpty) {
      url = url.substring(0, url.length - 1);
    }
    debugPrint(url);
    final response = await http.get(Uri.parse(prefix + object));
    if (response.statusCode == 200) {
      rawReponse = jsonDecode(response.body);
    } else {
      throw Exception('Failed to load album');
    }
    return;
  }

  bool isEmpty() {
    return rawReponse["hydra:totalItems"] == 0;
  }
}
