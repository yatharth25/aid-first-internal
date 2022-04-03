import 'package:aid_first/models/appointment.dart';
import 'package:aid_first/models/user.dart';
import 'package:aid_first/services/database/firebase_database_base.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseService implements FirebaseDatabaseServiceBase {
  late final DatabaseReference _ref;

  FirebaseDatabaseService._privateConstructor() {
    _ref = FirebaseDatabase.instance.ref('users');
  }

  static final FirebaseDatabaseService instance =
      FirebaseDatabaseService._privateConstructor();

  @override
  Future<User?> getUserDetails(String id) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('users/$id');
    final res = await ref.once(DatabaseEventType.value);

    if (res.snapshot.exists) {
      final Map result = res.snapshot.value as Map;

      List<Appointment> appointments = [];
      if (result['appointments'] != null) {
        for (int i = 0; i < (result['appointments'] as List).length; i++) {
          appointments.add(
            Appointment(
              id: result['appointments'][i]['doctorId'],
              name: result['appointments'][i]['name'],
              slot: result['appointments'][i]['slot'],
              date: DateTime.parse(result['appointments'][i]['date']),
            ),
          );
        }
      }

      return User(
        userId: id,
        name: result['name'],
        email: result['email'],
        phoneNumber: result['phoneNumber'],
        appointments: appointments,
      );
    } else {
      return null;
    }
  }

  @override
  Future setUserDetails(
      {String? userId,
      String? name,
      String? email,
      String? phoneNumber}) async {
    final DatabaseReference ref =
        FirebaseDatabase.instance.ref('users/$userId');

    final res = await ref.set({
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
    });
    return res;
  }

  @override
  Future updateUserDetails(
      {required String userId, Map<String, Object?>? updateDetails}) async {
    final DatabaseReference ref =
        FirebaseDatabase.instance.ref('users/$userId');
    final res = await ref.update(updateDetails!);

    return res;
  }
}
