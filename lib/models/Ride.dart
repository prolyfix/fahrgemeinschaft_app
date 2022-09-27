import 'dart:developer';

import 'package:intl/intl.dart';

import 'Driver.dart';
import 'Passenger.dart';

class Ride {
  final int id;
  final Driver driver;
  final List<Passenger> passengers;
  final String direction;

  const Ride(
      {required this.id,
      required this.driver,
      required this.passengers,
      required this.direction});

  factory Ride.fromJson(Map<String, dynamic> json) {
    Driver driver = Driver.fromJson(json["driver"]);
    List jsonPassengers = json["passengers"];
    List<Passenger> passengers = [];
    jsonPassengers.forEach((element) {
      inspect(element);
      passengers.add(Passenger.fromJson(element));
    });

    return Ride(
        id: json["id"],
        direction: json["direction"],
        driver: driver,
        passengers: passengers);
  }
}
