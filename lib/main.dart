import 'dart:convert';

import 'package:aid_first/app_routes.dart';
import 'package:aid_first/screens/patient/constants.dart';
import 'package:aid_first/screens/patient/patient_dashboard.dart';
import 'package:aid_first/screens/welcome_screen.dart';
import 'package:aid_first/services/database/firebase_database_service.dart';
import 'package:aid_first/services/preferences/shared_preferences_service.dart';
import 'package:aid_first/store/user_store.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    runApp(const AidFirstApp());
  });
}

class AidFirstApp extends StatefulWidget {
  const AidFirstApp({Key? key}) : super(key: key);

  @override
  State<AidFirstApp> createState() => _AidFirstAppState();
}

class _AidFirstAppState extends State<AidFirstApp> {
  String? isSignedIn;

  Future getDiagnoseToken(
      String uri, String apiKey, String computedHashString) async {
    try {
      var res = await http.post(
        Uri.parse(uri),
        headers: {'Authorization': "Bearer $apiKey:$computedHashString"},
      );
      Map token = await json.decode(res.body);
      return token['Token'];
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    String uri = AuthConstants.uri;
    String apiKey = AuthConstants.apiKey;
    String secretKey = AuthConstants.secretKey;
    List<int> secretBytes = utf8.encode(secretKey);
    String computedHashString = '';
    var hmac = Hmac(md5, secretBytes);
    List<int> dataBytes = utf8.encode(uri);
    Digest computedHash = hmac.convert(dataBytes);
    computedHashString = base64.encode(computedHash.bytes);
    getDiagnoseToken(uri, apiKey, computedHashString).then((value) =>
        SharedPreferencesService.instance.setString('BEARER_TOKEN', value));
    SharedPreferencesService.instance.getString("AUTH_TOKEN").then((value) {
      setState(() {
        isSignedIn = value;
      });
      if (isSignedIn != null) {
        SharedPreferencesService.instance.getString("FIREBASE_ID").then((id) {
          userStore.setUserId(id!);
          FirebaseDatabaseService.instance
              .getUserDetails(id)
              .then((user) => userStore.setUser(user!));
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color(0xFFE6E5EB),
        canvasColor: const Color(0xFFE6E5EB),
        primaryColor: Colors.black,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
      ),
      title: 'AidFirst',
      debugShowCheckedModeBanner: false,
      routes: getRoutes(),
      home:
          isSignedIn != null ? const PatientDashboard() : const WelcomeScreen(),
    );
  }
}
