import 'dart:developer';

import 'package:intl/intl.dart';

import 'Driver.dart';
import 'Passenger.dart';

class CalendarRide {
  final int id;
  final DateTime date;
  final Driver driver;
  final List<Passenger> passengers;

  const CalendarRide(
      {required this.id,
      required this.date,
      required this.driver,
      required this.passengers});

  factory CalendarRide.fromJson(Map<String, dynamic> json) {
    Driver driver = Driver.fromJson(json["ride"]["driver"]);
    List jsonPassengers = json["ride"]["passengers"];
    List<Passenger> passengers = [];
    jsonPassengers.forEach((element) {
      inspect(element);
      passengers.add(Passenger.fromJson(element));
    });

    return CalendarRide(
        id: json["id"],
        date: DateTime.parse(json['date'].toString()),
        driver: driver,
        passengers: passengers);
  }
}
