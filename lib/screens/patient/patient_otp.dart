import 'dart:async';

import 'package:aid_first/screens/patient/patient_login.dart';
import 'package:aid_first/screens/patient/patient_username.dart';
import 'package:aid_first/services/auth/firebase_auth_service.dart';
import 'package:aid_first/services/database/firebase_database_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pin_put/pin_put.dart';

class PatientOTP extends StatefulWidget {
  final String verificationIdFinal;
  final String? phoneNumber;

  const PatientOTP(
      {required this.verificationIdFinal, this.phoneNumber, Key? key})
      : super(key: key);

  @override
  State<PatientOTP> createState() => _PatientOTPState();
}

class _PatientOTPState extends State<PatientOTP> {
  late final TextEditingController? _pinPutController;
  late final FocusNode _pinPutFocusNode;
  late int _countdownSeconds;
  bool _isbuttonEnabled = false;
  Timer? _pinTimer;
  String? _code;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      startTimer();
    }
    _pinPutFocusNode = FocusNode();
    _pinPutController = TextEditingController();
  }

  @override
  void dispose() {
    _pinPutFocusNode.dispose();
    _pinPutController?.dispose();
    _pinTimer?.cancel();
    super.dispose();
  }

  void startTimer() {
    setState(() {
      _countdownSeconds = 30;
      _isbuttonEnabled = false;
    });

    _pinTimer?.cancel();
    _pinTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdownSeconds <= 0) {
        timer.cancel();
        _pinTimer = null;

        setState(() {
          _isbuttonEnabled = true;
        });
      } else {
        setState(() {
          _countdownSeconds--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final BoxDecoration? pinPutDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5.0),
    );
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 250),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enter OTP',
                  style: GoogleFonts.prociono(fontSize: 25),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: PinPut(
                    controller: _pinPutController,
                    focusNode: _pinPutFocusNode,
                    fieldsCount: 6,
                    submittedFieldDecoration: pinPutDecoration,
                    selectedFieldDecoration: pinPutDecoration?.copyWith(
                      color: Colors.white,
                      border: Border.all(
                        width: 2,
                        color: Colors.lightBlue,
                      ),
                    ),
                    onChanged: (String pin) {
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        if (mounted) {
                          setState(() {
                            _code = _pinPutController!.text;
                          });
                          if (_code!.length == 6) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => Material(
                                      color: Colors.transparent,
                                      child: Center(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/syrup.png'),
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            width: 300,
                                            child: LinearProgressIndicator(
                                              color: Colors.blue[800],
                                            ),
                                          ),
                                        ],
                                      )),
                                    ));
                            _verifyPin(
                              pin,
                              context,
                            );
                          }
                        }
                      });
                    },
                    onSubmit: (pin) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => Material(
                                color: Colors.transparent,
                                child: Center(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/syrup.png'),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      width: 300,
                                      child: LinearProgressIndicator(
                                        color: Colors.blue[800],
                                      ),
                                    ),
                                  ],
                                )),
                              ));
                      _verifyPin(pin, context);
                    },
                    followingFieldDecoration: pinPutDecoration,
                    pinAnimationType: PinAnimationType.scale,
                  ),
                ),
                const SizedBox(height: 15),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Resend',
                      ),
                      TextSpan(
                        text: ' in 00:$_countdownSeconds',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                InkWell(
                    onTap: () {
                      _isbuttonEnabled
                          ? Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PatientLogin(),
                              ),
                            )
                          : showDialog(
                              context: context,
                              builder: (BuildContext context) => Material(
                                    color: Colors.transparent,
                                    child: Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/syrup.png'),
                                        const SizedBox(height: 10),
                                        SizedBox(
                                          width: 300,
                                          child: LinearProgressIndicator(
                                            color: Colors.blue[800],
                                          ),
                                        ),
                                      ],
                                    )),
                                  ));
                      _verifyPin(_pinPutController!.text, context);
                    },
                    child: Container(
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xFF6C63FF).withOpacity(0.6),
                      ),
                      child: Center(
                        child: Text(
                          _isbuttonEnabled ? 'Resend' : 'Next',
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 15),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ));
  }

  Future<void> _verifyPin(
    String pin,
    BuildContext context,
  ) async {
    FirebaseAuthService.instance
        .signInWithPhoneNumber(
      widget.verificationIdFinal,
      pin,
    )
        .then((value) {
      final bool isSignedIn = value;

      if (isSignedIn) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.fixed,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
          content: Text('Logged In!'),
          backgroundColor: Colors.blue,
        ));
        FirebaseAuthService.instance.getAuthId().then((id) {
          FirebaseDatabaseService.instance.getUserDetails(id!).then((response) {
            response != null
                ? Navigator.pushNamedAndRemoveUntil(context,
                    '/PatientDashboard', (Route<dynamic> route) => false)
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          PatientUsername(phoneNumber: widget.phoneNumber!),
                    ),
                  );
          });
        });

        // readUserChangeNotifier.tryFindUser(widget.phoneNumber!).then(
        //       (userExists) => {
        //         if (userExists)
        //           {
        //             readUserChangeNotifier.logIn().then(
        //               (_) {
        //                 ref.read(appStateChangeNotifierProvider).isLoggedIn =
        //                     true;
        //               },
        //             ),
        //           }
        //         else
        //           {
        //             // Navigator.push(
        //             //   context,
        //             //   MaterialPageRoute(
        //             //     builder: (_) => UsernameInput(
        //             //       phoneNumber: widget.phoneNumber!,
        //             //     ),
        //             //   ),
        //             // ),
        //           }
        //       },
        //     );
      } else if (isSignedIn == false) {
        if (!mounted) return;
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Wrong Pin!'),
          behavior: SnackBarBehavior.fixed,
          duration: Duration(seconds: 2),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
          backgroundColor: Colors.red,
        ));
      }
    });
  }

  void setData() {
    if (widget.verificationIdFinal.isNotEmpty) {
      return;
    }
  }
}
