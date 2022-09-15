class Passenger {
  final int id;
  final String lastName;
  final String firstName;

  const Passenger(
      {required this.id, required this.lastName, required this.firstName});

  factory Passenger.fromJson(Map<String, dynamic> json) {
    return Passenger(
        id: json['id'], lastName: 'temp', firstName: json['firstName']);
  }
}
