import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class DiseaseByNameDetails extends StatelessWidget {
  final Map details;
  List<Widget> text = [];
  DiseaseByNameDetails({required this.details, Key? key}) : super(key: key) {
    final List d = details['facts'];
    for (int i = 0; i < d.length; i++) {
      text.add(
        Text(
          d[i],
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 15,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    void _launchUrl() async {
      const _url = 'http://maps.google.co.uk/maps?q=Chemists&hl=en';
      if (!await launch(_url)) throw 'Could not launch $_url';
    }

    return Scaffold(
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
                  'Search nearest pharmacy',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.width * 0.2,
                alignment: Alignment.centerLeft,
                child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 30,
                    )),
              ),
              Text(
                details['name'],
                textAlign: TextAlign.center,
                style: GoogleFonts.prociono(
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
              Text(
                'Details',
                style: GoogleFonts.poppins(fontSize: 15),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all()),
                width: double.maxFinite,
                child: Column(
                  children: [
                    Text(
                      'Info',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: text,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Symptoms',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      details['symptoms'] ?? 'N/A',
                      style: GoogleFonts.poppins(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Transmission',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      details['transmission'] ?? 'N/A',
                      style: GoogleFonts.poppins(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Diagnosis',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      details['diagnosis'] ?? 'N/A',
                      style: GoogleFonts.poppins(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Treatment',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      details['treatment'] ?? 'N/A',
                      style: GoogleFonts.poppins(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Prevention',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      details['prevention'] ?? 'N/A',
                      style: GoogleFonts.poppins(fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
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
                  fontSize: 15,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
