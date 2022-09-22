import 'dart:developer';

import 'Family.dart';

class Driver {
  final int id;
  final String lastName;
  final String firstName;
  final Family family;

  const Driver(
      {required this.id,
      required this.lastName,
      required this.firstName,
      required this.family});

  factory Driver.fromJson(Map<String, dynamic> json) {
    inspect(json);
    return Driver(
        id: json['id'],
        lastName: json['lastName'],
        firstName: json['firstName'],
        family: Family.fromJson(json['family']));
  }
}
