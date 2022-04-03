import 'package:aid_first/screens/patient/patient_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppointmentBooked extends StatelessWidget {
  const AppointmentBooked({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Success',
          style: GoogleFonts.prociono(
            fontSize: 30,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(
                  'https://media.giphy.com/media/tf9jjMcO77YzV4YPwE/giphy.gif',
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Success!!',
                style: GoogleFonts.prociono(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Appointment booked',
                style: GoogleFonts.prociono(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Note: You can check your appointments in your profile',
                style: GoogleFonts.prociono(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const PatientDashboard()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
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
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
