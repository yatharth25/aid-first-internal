// Dart imports:
import 'dart:async';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';

// Project imports:

abstract class AuthServiceBase {
  Future<String?> getAuthToken();
  Future<String?> getAuthId();
  Future<void> logOut();
  Future verifyPhoneNumber(String phoneNumber, Function setData);
  Future<bool> signInWithPhoneNumber(String verificationId, String smsCode);
  Future<bool> signInWithPhoneNumberOnWeb(String phoneNumber, Function setData);
  Future<void> storeTokenAndData(UserCredential userCredential);
  Future<void> updateUser();
}
