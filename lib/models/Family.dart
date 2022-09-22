class Family {
  final String name;
  final String color;

  const Family({required this.name, required this.color});

  factory Family.fromJson(Map<String, dynamic> json) {
    return Family(name: json['name'], color: json['color']);
  }
}
