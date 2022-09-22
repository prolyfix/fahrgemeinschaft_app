import 'Family.dart';

class Passenger {
  final String lastName;
  final String firstName;
  final Family family;

  const Passenger(
      {required this.lastName, required this.firstName, required this.family});

  factory Passenger.fromJson(Map<String, dynamic> json) {
    return Passenger(
        lastName: json['lastName'],
        firstName: json['firstName'],
        family: Family.fromJson(json['family']));
  }
}
