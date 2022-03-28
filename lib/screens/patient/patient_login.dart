import 'package:aid_first/screens/patient/patient_otp.dart';
import 'package:aid_first/services/auth/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PatientLogin extends StatefulWidget {
  const PatientLogin({Key? key}) : super(key: key);

  @override
  State<PatientLogin> createState() => _PatientLoginState();
}

class _PatientLoginState extends State<PatientLogin> {
  late final TextEditingController _controller;
  String? _phoneNumber;
  String _verificationIdFinal = '';
  String? _isoCode;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 250),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign In',
                  style: GoogleFonts.prociono(fontSize: 25),
                ),
                const SizedBox(height: 20),
                Text(
                  'One stop solution for all your medical needs!',
                  style: GoogleFonts.prociono(
                    fontSize: 15,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 60),
                Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(),
                      color: Colors.white,
                    ),
                    child: IntlPhoneField(
                      onChanged: (number) {
                        _phoneNumber = number.number;
                      },
                      onCountryChanged: (code) {
                        _isoCode = code.countryCode;
                      },
                      initialCountryCode: 'IN',
                      decoration: const InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                        hintText: 'Enter Phone no.',
                        isDense: true,
                      ),
                      iconPosition: IconPosition.trailing,
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      keyboardType: TextInputType.phone,
                      focusNode: _focusNode,
                      autoValidate: false,
                      showCountryFlag: true,
                      controller: _controller,
                      autofocus: true,
                      onSubmitted: (String _phoneNumber) async {
                        _isoCode ??= '+91';
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          behavior: SnackBarBehavior.fixed,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          )),
                          content: Text('Sending Pin'),
                          backgroundColor: Colors.blue,
                        ));
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => Material(
                                  color: Colors.transparent,
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                        FirebaseAuthService.instance.verifyPhoneNumber(
                            '$_isoCode$_phoneNumber', setData);
                      },
                      onSaved: (_phoneNumber) async {
                        _isoCode ??= '+91';
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          behavior: SnackBarBehavior.fixed,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          )),
                          content: Text('Sending Pin'),
                          backgroundColor: Colors.blue,
                        ));
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
                          ),
                        );
                        FirebaseAuthService.instance.verifyPhoneNumber(
                            '$_isoCode$_phoneNumber', setData);
                      },
                    )
                    // InternationalPhoneNumberInput(
                    //   onInputChanged: (phone) {
                    //     _phoneNumber = phone;
                    //   },
                    //   initialValue: PhoneNumber(isoCode: 'IN'),
                    //   selectorConfig: const SelectorConfig(
                    //       leadingPadding: 20,
                    //       setSelectorButtonAsPrefixIcon: true,
                    //       selectorType: PhoneInputSelectorType.DIALOG),
                    //   inputDecoration: const InputDecoration(
                    //     border: InputBorder.none,
                    //     hintText: 'Enter Phone no.',
                    //   ),
                    //   onSubmit: () async {
                    //     showDialog(
                    //       context: context,
                    //       builder: (BuildContext context) => const Center(
                    //         child: CircularProgressIndicator(),
                    //       ),
                    //     );
                    //     FirebaseAuthService.instance
                    //         .verifyPhoneNumber(_phoneNumber.toString(), setData);
                    //   },
                    //   focusNode: _focusNode,
                    //   textFieldController: _controller,
                    // ),
                    ),
                const SizedBox(
                  height: 40,
                ),
                InkWell(
                    onTap: () async {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        behavior: SnackBarBehavior.fixed,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        )),
                        content: Text('Sending Pin'),
                        backgroundColor: Colors.blue,
                      ));
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
                        ),
                      );
                      FirebaseAuthService.instance
                          .verifyPhoneNumber(_phoneNumber.toString(), setData);
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
                          'Next',
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

  void setData(String verificationId) {
    if (mounted) {
      setState(() {
        _verificationIdFinal = verificationId;
        if (_verificationIdFinal.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PatientOTP(
                verificationIdFinal: _verificationIdFinal,
                phoneNumber: '$_isoCode$_phoneNumber',
              ),
            ),
          );
        }
      });
    }
  }
}
