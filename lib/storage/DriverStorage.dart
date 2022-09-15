import '../models/Driver.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DriverStorage {
  Future<Driver> fetchDriver(int i) async {
    final response = await http.get(Uri.parse(
        'http://fahrgemeinschaft.enconstruction.de/api/drivers/' +
            i.toString()));
    if (response.statusCode == 200) {
      return Driver.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}
