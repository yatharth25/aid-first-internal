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
      return User(
        userId: id,
        name: result['name'],
        email: result['email'],
        phoneNumber: result['phoneNumber'],
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
