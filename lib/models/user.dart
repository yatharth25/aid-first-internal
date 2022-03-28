class User {
  final String userId;
  final String name;
  final String email;
  final String phoneNumber;

  const User({
    required this.userId,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  factory User.fromJson(dynamic json) {
    return User(
      userId: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': userId,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }
}
