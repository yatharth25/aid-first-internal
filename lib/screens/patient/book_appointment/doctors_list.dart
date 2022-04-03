import 'package:aid_first/models/doctor.dart';
import 'package:aid_first/screens/patient/book_appointment/doctor_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorsList extends StatelessWidget {
  final List<Doctor>? docList;

  const DoctorsList({
    this.docList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Select your doctor',
          style: GoogleFonts.prociono(
            fontSize: 30,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: docList!
                .map((doc) => Column(
                      children: [
                        Material(
                          elevation: 4,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          child: InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    DoctorDetails(doctorDetail: doc),
                              ),
                            ),
                            child: Container(
                              width: double.maxFinite,
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
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.blue[800],
                                    radius: 35,
                                    child: Image.asset(
                                      'assets/doctor.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        doc.name!,
                                        style: GoogleFonts.prociono(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        'Degree: ${doc.degree!}',
                                        style: GoogleFonts.prociono(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        'Experience: ${doc.experience!}',
                                        style: GoogleFonts.prociono(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
