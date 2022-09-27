import '../models/Ride.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RideStorage {
  Future<Ride> fetchRideById(int i) async {
    final response = await http.get(Uri.parse(
        'http://fahrgemeinschaft.enconstruction.de/api/calendar_rides/1'));
    if (response.statusCode == 200) {
      return Ride.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<Ride> fetchRidesFromScheduleId(int id) async {
    final response = await http.get(Uri.parse(
        'http://fahrgemeinschaft.enconstruction.de/api/rides?ride.id=' +
            id.toString()));
    if (response.statusCode == 200) {
      return Ride.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}
