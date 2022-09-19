import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  String object = "/";
  Map<String, dynamic> params = {};
  final String prefix = "http://fahrgemeinschaft.de/api";
  late Map<String, dynamic> rawReponse;
  late Map<String, dynamic> data;

  bool isResponseEmpty() {
    return false;
  }

  void setObject(String objet) {
    this.object = objet;
  }

  void fetchApi() async {
    final response = await http.get(Uri.parse(prefix + object));
    if (response.statusCode == 200) {
      rawReponse = jsonDecode(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }
}
