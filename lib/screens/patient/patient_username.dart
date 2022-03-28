import 'package:aid_first/services/auth/firebase_auth_service.dart';
import 'package:aid_first/services/database/firebase_database_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PatientUsername extends StatefulWidget {
  final String phoneNumber;

  const PatientUsername({required this.phoneNumber, Key? key})
      : super(key: key);

  @override
  State<PatientUsername> createState() => _PatientOTPState();
}

class _PatientOTPState extends State<PatientUsername> {
  late final TextEditingController? _usernameController;
  late final FocusNode _usernameFocusNode;
  late final TextEditingController? _userEmailController;
  late final FocusNode _userEmailFocusNode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // late int _countdownSeconds;
  // bool _isbuttonEnabled = false;
  // Timer? _pinTimer;

  @override
  void initState() {
    super.initState();
    // if (mounted) {
    //   startTimer();
    // }
    _usernameFocusNode = FocusNode();
    _usernameController = TextEditingController();
    _userEmailFocusNode = FocusNode();
    _userEmailController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _usernameController?.dispose();
    _userEmailFocusNode.dispose();
    _userEmailController?.dispose();
    // _pinTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                padding: const EdgeInsets.all(15),
                child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      children: [
                        Text(
                          'Enter Your Details',
                          style: GoogleFonts.prociono(fontSize: 25),
                        ),
                        const SizedBox(height: 40),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              'Enter Name:',
                              style: GoogleFonts.prociono(fontSize: 20),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(40)),
                            border: Border.all(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                          child: TextFormField(
                            controller: _usernameController,
                            focusNode: _usernameFocusNode,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                hintText: 'Enter your name',
                                border: InputBorder.none),
                            style: GoogleFonts.prociono(fontSize: 16),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              'Enter your email:',
                              style: GoogleFonts.prociono(fontSize: 20),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(40)),
                            border: Border.all(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                          child: TextFormField(
                            controller: _userEmailController,
                            focusNode: _userEmailFocusNode,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter valid email';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                hintText: 'Enter a valid email',
                                border: InputBorder.none),
                            style: GoogleFonts.prociono(fontSize: 16),
                          ),
                        ),
                        const SizedBox(height: 30),
                        InkWell(
                            onTap: () async {
                              final firebaseUserId = await FirebaseAuthService
                                  .instance
                                  .getAuthId();
                              if (_formKey.currentState!.validate()) {
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
                                  ),
                                );

                                await FirebaseDatabaseService.instance
                                    .setUserDetails(
                                      userId: firebaseUserId,
                                      name: _usernameController!.text,
                                      email: _userEmailController!.text,
                                      phoneNumber: widget.phoneNumber,
                                    )
                                    .then((value) =>
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            '/PatientDashboard',
                                            (Route<dynamic> route) => false));
                              }
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
                                  'Submit',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            )),
                      ],
                    )),
              ),
            ),
          ),
        ));
  }
}
