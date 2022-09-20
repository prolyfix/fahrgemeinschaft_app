import 'package:intl/intl.dart';

import 'Driver.dart';

class CalendarRide {
  final int id;
  final DateTime date;
  final Driver driver;

  const CalendarRide(
      {required this.id, required this.date, required this.driver});

  factory CalendarRide.fromJson(Map<String, dynamic> json) {
    Driver driver = Driver.fromJson(json["ride"]["driver"]);
    return CalendarRide(
        id: json["id"],
        date: DateTime.parse(json['date'].toString()),
        driver: driver);
  }
}
