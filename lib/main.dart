import 'dart:convert';

import 'package:aid_first/screens/patient/constants.dart';
import 'package:aid_first/screens/patient/diagnose_yourself/diagnose_yourself.dart';
import 'package:aid_first/screens/patient/diagnose_by_name/disease_by_name.dart';
import 'package:aid_first/screens/patient/patient_dashboard.dart';
import 'package:aid_first/screens/patient/patient_profile.dart';
import 'package:aid_first/services/preferences/shared_preferences_service.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aid_first/screens/otherWidgetsAndScreen/about_us.dart';
import 'package:aid_first/screens/patient/patient_login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;

import 'animations/fade_animation.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    runApp(const AidFirstApp());
  });

  // runApp(const AidFirstApp());
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
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

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
      debugShowCheckedModeBanner: false,
      home:
          isSignedIn != null ? const PatientDashboard() : const WelcomeScreen(),
      routes: {
        '/PatientLogin': (context) => const PatientLogin(),
        '/AboutUs': (context) => const AboutUs(),
        '/PatientDashboard': (context) => const PatientDashboard(),
        '/PatientProfile': (context) => const PatientProfile(),
        '/DiseasebyName': (context) => const DiseaseByName(),
        '/DiagnoseYourself': (context) => const DiagnoseYourself(),
      },
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _scaleController2;
  late AnimationController _widthController;
  late AnimationController _positionController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _scale2Animation;
  late Animation<double> _widthAnimation;
  late Animation<double> _positionAnimation;

  bool hideIcon = false;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.8).animate(_scaleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _widthController.forward();
            }
          });

    _widthController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    _widthAnimation =
        Tween<double>(begin: 80.0, end: 300.0).animate(_widthController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _positionController.forward();
            }
          });

    _positionController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    _positionAnimation =
        Tween<double>(begin: 0.0, end: 215.0).animate(_positionController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                hideIcon = true;
              });
              _scaleController2.forward();
            }
          });
    _scaleController2 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    _scale2Animation =
        Tween<double>(begin: 1.0, end: 32.0).animate(_scaleController2)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: const PatientLogin(),
                ),
              );
            }
          });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black, // navigation bar color
        statusBarColor: Colors.black.withOpacity(0.1)));
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: width,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: height * 0.05,
              left: width - 240,
              child: FadeAnimation(
                1,
                SizedBox(
                  width: width,
                  child: const Image(image: AssetImage('assets/hospital.png')),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                margin: EdgeInsets.fromLTRB(0, 0, 0, height * 0.01),
                height: height * 0.55,
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(
                        1,
                        Text(
                          'AID FIRST',
                          style: GoogleFonts.prociono(
                              color: Colors.black, fontSize: height * 0.06),
                        )),
                    FadeAnimation(
                        1,
                        Text(
                          "Cause sometimes First Aid isn't enough",
                          style: GoogleFonts.prociono(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: height * 0.017),
                        )),
                    SizedBox(
                      height: height * 0.26,
                    ),
                    Column(
                      children: <Widget>[
                        FadeAnimation(
                            1.6,
                            AnimatedBuilder(
                              animation: _scaleController,
                              builder: (context, child) => Transform.scale(
                                scale: _scaleAnimation.value,
                                child: Center(
                                  child: AnimatedBuilder(
                                    animation: _widthController,
                                    builder: (context, child) => Container(
                                      width: _widthAnimation.value,
                                      height: 80,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.black.withOpacity(0.4),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          _scaleController.forward();
                                        },
                                        child: Stack(
                                          children: <Widget>[
                                            AnimatedBuilder(
                                              animation: _positionController,
                                              builder: (context, child) =>
                                                  Positioned(
                                                left: _positionAnimation.value,
                                                child: AnimatedBuilder(
                                                  animation: _scaleController2,
                                                  builder: (context, child) =>
                                                      Transform.scale(
                                                          scale:
                                                              _scale2Animation
                                                                  .value,
                                                          child: Container(
                                                              width: 60,
                                                              height: 60,
                                                              decoration: const BoxDecoration(
                                                                  color: Colors
                                                                      .black,
                                                                  shape: BoxShape
                                                                      .circle),
                                                              child: hideIcon ==
                                                                      false
                                                                  ? const Icon(
                                                                      Icons
                                                                          .arrow_forward,
                                                                      color: Colors
                                                                          .white,
                                                                    )
                                                                  : Container())),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        FadeAnimation(
                            1,
                            Text(
                              'Proceed!',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(fontSize: 20),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
