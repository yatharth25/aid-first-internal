import 'dart:convert';

import 'package:aid_first/models/doctor.dart';
import 'package:aid_first/screens/patient/book_appointment/doctors_list.dart';
import 'package:aid_first/screens/patient/constants.dart';
import 'package:aid_first/screens/patient/patient_dashboard.dart';
import 'package:aid_first/services/appointment_service/firebase_appointment_service.dart';
import 'package:aid_first/services/preferences/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class DiseaseInfo extends StatefulWidget {
  final dynamic issueId;
  final String name;
  const DiseaseInfo({required this.issueId, required this.name, Key? key})
      : super(key: key);

  @override
  State<DiseaseInfo> createState() => _DiseaseInfoState();
}

class _DiseaseInfoState extends State<DiseaseInfo> {
  Map<String, dynamic> diseaseInfo = {};
  Future<dynamic> getDiseaseInfo(url) async {
    try {
      final res = await http.get(Uri.parse(url));
      final dynamic response = json.decode(res.body);
      return response;
    } catch (e) {
      print('Error Ayi hai');
      print(e);
    }
  }

  @override
  void initState() {
    SharedPreferencesService.instance.getString('BEARER_TOKEN').then((token) {
      var url = AuthConstants.healthApiDiseaseInfo(widget.issueId, token!);
      getDiseaseInfo(url).then((value) => {
            if (mounted)
              {
                setState(() {
                  diseaseInfo = value;
                })
              }
          });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> getSymptomsArray() {
      String syms = diseaseInfo['PossibleSymptoms'];
      List<String> arraySyms = syms.split(",");
      return arraySyms;
    }

    void _launchUrl() async {
      const _url = 'http://maps.google.co.in/maps?q=Hospitals+&+clinics&hl=en';
      if (!await launch(_url)) throw 'Could not launch $_url';
    }

    print(widget.issueId);
    print(diseaseInfo);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '${widget.name} Info',
          style: GoogleFonts.prociono(
            fontSize: 30,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: Material(
        color: Colors.transparent,
        elevation: 4,
        borderRadius: BorderRadius.circular(15),
        child: GestureDetector(
          onTap: () => _launchUrl(),
          child: Container(
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
                Text(
                  'Search nearest clinic',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: diseaseInfo.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/syrup.png'),
                  const SizedBox(height: 10),
                  const Text("Loading..."),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 300,
                    child: LinearProgressIndicator(
                      color: Colors.blue[800],
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/steth.png', fit: BoxFit.contain),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text('Description',
                              style: GoogleFonts.prociono(
                                color: Colors.blue[800],
                                fontWeight: FontWeight.w600,
                                fontSize: 24,
                                decoration: TextDecoration.underline,
                              )),
                          const SizedBox(height: 10),
                          Text(diseaseInfo['Description'],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.prociono(
                                color: Colors.blue[800],
                                fontSize: 14,
                              )),
                          const SizedBox(height: 20),
                          Text('Symptoms',
                              style: GoogleFonts.prociono(
                                color: Colors.blue[800],
                                fontWeight: FontWeight.w600,
                                fontSize: 24,
                                decoration: TextDecoration.underline,
                              )),
                          const SizedBox(height: 10),
                          ...getSymptomsArray().map<Widget>(
                            (e) => SizedBox(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.125,
                                  ),
                                  Icon(
                                    Icons.personal_injury,
                                    color: Colors.blue[800],
                                  ),
                                  const SizedBox(width: 10),
                                  Text(e,
                                      style: GoogleFonts.prociono(
                                        color: Colors.blue[800],
                                        fontSize: 14,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text('Treatment',
                              style: GoogleFonts.prociono(
                                color: Colors.blue[800],
                                fontWeight: FontWeight.w600,
                                fontSize: 24,
                                decoration: TextDecoration.underline,
                              )),
                          const SizedBox(height: 10),
                          Text(diseaseInfo['TreatmentDescription'],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.prociono(
                                color: Colors.blue[800],
                                fontSize: 14,
                              )),
                          const SizedBox(height: 10)
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Icon(
                      Icons.dangerous_rounded,
                      size: 30,
                      color: Colors.red,
                    ),
                    Text(
                      'In case the symtoms persists or worsens contact a doctor as soon as possible',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () async {
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
                              (List<Doctor>? doctors) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DoctorsList(
                                    docList: doctors,
                                  ),
                                ),
                              ),
                            );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          border: Border.all(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          'Book Appointment',
                          style: GoogleFonts.prociono(
                            fontSize: 18,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const PatientDashboard()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          'Go to Home',
                          style: GoogleFonts.prociono(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
    );
  }
}
