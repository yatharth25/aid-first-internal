class Appointment {
  String id;
  String name;
  String slot;
  DateTime date;

  Appointment({
    required this.id,
    required this.name,
    required this.slot,
    required this.date,
  });

  factory Appointment.fromJson(dynamic json) {
    return Appointment(
      id: json['doctorId'],
      name: json['name'],
      slot: json['slot'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slot': slot,
      'date': date,
    };
  }
}
