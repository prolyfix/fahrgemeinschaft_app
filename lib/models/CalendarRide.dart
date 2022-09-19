import 'package:intl/intl.dart';

import 'Driver.dart';

class CalendarRide {
  final int id;
  final DateTime date;
  final Driver driver;

  const CalendarRide(
      {required this.id, required this.date, required this.driver});

  factory CalendarRide.fromJson(Map<String, dynamic> json) {
    Driver driver = Driver.fromJson(json["hydra:member"][0]["ride"]["driver"]);
    return CalendarRide(
        id: json["hydra:member"][0]["id"],
        date: DateTime.parse(json["hydra:member"][0]['date'].toString()),
        driver: driver);
  }
}
