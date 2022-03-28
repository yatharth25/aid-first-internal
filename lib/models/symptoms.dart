class Symptoms {
  final String id;
  final String name;

  Symptoms({required this.id, required this.name});

  factory Symptoms.fromJson(dynamic json) {
    return Symptoms(
      id: json['ID'] as String,
      name: json['Name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name': name,
    };
  }
}
