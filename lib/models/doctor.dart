class Doctor {
  String? id;
  String? name;
  String? degree;
  String? experience;
  List<String>? appointmentSlots;

  Doctor({
    required this.id,
    required this.name,
    required this.degree,
    required this.experience,
    required this.appointmentSlots,
  });

  factory Doctor.fromJson(dynamic json) {
    return Doctor(
      id: json['id'],
      name: json['name'],
      degree: json['degree'],
      experience: json['experience'],
      appointmentSlots: json['appointmentSlots'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'degree': degree,
      'experience': experience,
      'appointmentSlots': appointmentSlots,
    };
  }
}
