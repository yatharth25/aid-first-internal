import 'package:aid_first/models/doctor.dart';
import 'package:aid_first/screens/patient/book_appointment/doctors_list.dart';
import 'package:aid_first/services/appointment_service/firebase_appointment_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Appointment extends StatefulWidget {
  const Appointment({Key? key}) : super(key: key);

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  late final TextEditingController? _textController;
  late final FocusNode _textFocusNode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _textFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _textController!.dispose();
    _textFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Book Appointment',
          style: GoogleFonts.prociono(
            fontSize: 30,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    width: double.maxFinite,
                    child: Image.asset(
                      'assets/bigDoc.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Hello Patient!',
                    style: GoogleFonts.prociono(fontSize: 26),
                  ),
                  Text(
                    'Not feeling fine?',
                    style: GoogleFonts.prociono(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(
                        'Explain what problems are you getting.',
                        style: GoogleFonts.prociono(fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your problems!';
                        }
                        return null;
                      },
                      maxLines: 8,
                      controller: _textController,
                      focusNode: _textFocusNode,
                      decoration: const InputDecoration(
                          hintText: 'Explain what problems are you getting',
                          border: InputBorder.none),
                      style: GoogleFonts.prociono(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
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

                        await FirebaseAppointmentService.instance
                            .getDoctorDetails()
                            .then(
                              (List<Doctor>? doctors) => {
                                Navigator.pop(context),
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => DoctorsList(
                                      docList: doctors,
                                    ),
                                  ),
                                )
                              },
                            );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(40)),
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        'Find Doctors',
                        style: GoogleFonts.prociono(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
