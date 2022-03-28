// Dart imports:
import 'dart:async';

// Package imports:

import 'package:aid_first/services/auth/auth_service_base.dart';
import 'package:aid_first/services/preferences/shared_preferences_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService implements AuthServiceBase {
  late final FirebaseAuth _auth;

  FirebaseAuthService._privateConstructor() {
    _auth = FirebaseAuth.instance;
  }

  static final FirebaseAuthService instance =
      FirebaseAuthService._privateConstructor();

  @override
  Future<String?> getAuthToken() async {
    return SharedPreferencesService.instance.getString("AUTH_TOKEN");
  }

  @override
  Future<String?> getAuthId() async {
    return SharedPreferencesService.instance.getString("FIREBASE_ID");
  }

  @override
  Future<void> logOut() async {
    await SharedPreferencesService.instance.remove("AUTH_TOKEN");
    await SharedPreferencesService.instance.remove("FIREBASE_ID");
  }

  @override
  Future verifyPhoneNumber(
    String phoneNumber,
    Function setData,
  ) async {
    final Completer completer = Completer();
    final String phone =
        phoneNumber.contains('+91') ? phoneNumber : '+91$phoneNumber';

    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
        completer.complete();
      },
      verificationFailed: (FirebaseAuthException exception) {
        print(exception);
        completer.complete();
      },
      codeSent: (String verificationID, int? forceResendingtoken) {
        setData(verificationID);
        completer.complete();
      },
      codeAutoRetrievalTimeout: (String verficationID) {
        completer.complete();
      },
    );

    return completer.future;
  }

  @override
  Future<bool> signInWithPhoneNumber(
    String verificationId,
    String smsCode,
  ) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      if (credential.toString().isEmpty) {
        _auth.currentUser;
      }
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      await storeTokenAndData(userCredential);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> signInWithPhoneNumberOnWeb(
    String phoneNumber,
    Function setData,
  ) async {
    try {
      final ConfirmationResult confirmationResult =
          await _auth.signInWithPhoneNumber(
        phoneNumber,
        RecaptchaVerifier(
          size: RecaptchaVerifierSize.compact,
          theme: RecaptchaVerifierTheme.dark,
        ),
      );
      setData(confirmationResult.verificationId);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  @override
  Future<void> storeTokenAndData(UserCredential userCredential) async {
    try {
      final String authToken = await userCredential.user!.getIdToken(true);
      final String userId = userCredential.user!.uid;
      SharedPreferencesService.instance.setString("AUTH_TOKEN", authToken);
      SharedPreferencesService.instance.setString("FIREBASE_ID", userId);
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future updateUser() async {
    throw UnimplementedError();
  }
}
