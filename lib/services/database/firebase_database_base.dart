import 'package:aid_first/models/user.dart';

abstract class FirebaseDatabaseServiceBase {
  Future setUserDetails({
    String? userId,
    String? name,
    String? email,
    String? phoneNumber,
  });
  Future updateUserDetails(
      {required String userId, Map<String, Object?>? updateDetails});
  Future<User?> getUserDetails(String id);
}
