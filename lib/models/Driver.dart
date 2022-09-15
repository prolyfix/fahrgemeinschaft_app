class Driver {
  final int id;
  final String lastName;
  final String firstName;

  const Driver(
      {required this.id, required this.lastName, required this.firstName});

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
        id: json['id'], lastName: 'temp', firstName: json['firstName']);
  }
}
