import 'package:aid_first/models/appointment.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppointmentHistory extends StatefulWidget {
  final List<Appointment>? appointments;
  const AppointmentHistory({
    this.appointments,
    Key? key,
  }) : super(key: key);

  @override
  State<AppointmentHistory> createState() => _AppointmentHistoryState();
}

class _AppointmentHistoryState extends State<AppointmentHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Your Appointments',
          style: GoogleFonts.prociono(
            fontSize: 30,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.maxFinite,
        child: widget.appointments!.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 100,
                      backgroundImage: NetworkImage(
                          'https://media.giphy.com/media/UQva8IcXoo0ZI4V0HF/giphy.gif'),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Seems you are healthy!',
                      style: GoogleFonts.prociono(fontSize: 24),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "You haven't booked any appointments yet!",
                      style: GoogleFonts.prociono(fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Stay healthy!",
                      style: GoogleFonts.prociono(fontSize: 14),
                    ),
                    const SizedBox(height: 120),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(400),
                        child: SizedBox(
                          width: 300,
                          child: Image.asset(
                            'assets/diagnose.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ...widget.appointments!
                          .map((e) => Column(
                                children: [
                                  Material(
                                    elevation: 2,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        border: Border.all(
                                          color: Colors.blue,
                                          width: 2,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          const CircleAvatar(
                                            radius: 35,
                                            backgroundImage:
                                                AssetImage('assets/doctor.png'),
                                          ),
                                          const SizedBox(width: 15),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                e.name,
                                                style: GoogleFonts.prociono(
                                                    fontSize: 18),
                                              ),
                                              Text(
                                                'Date: ${e.date.day}/${e.date.month}/${e.date.year}',
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                              Text(
                                                'Slot: ${e.slot}',
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ))
                          .toList()
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
