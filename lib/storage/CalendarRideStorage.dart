import '../models/CalendarRide.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CalendarRideStorage {
  Future<CalendarRide> fetchCalendarRideById(int i) async {
    final response = await http.get(Uri.parse(
        'http://fahrgemeinschaft.enconstruction.de/api/calendar_rides/1'));
    if (response.statusCode == 200) {
      return CalendarRide.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}
