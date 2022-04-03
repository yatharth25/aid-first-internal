import 'package:aid_first/models/appointment.dart';
import 'package:aid_first/models/doctor.dart';
import 'package:aid_first/screens/patient/book_appointment/appointment_booked.dart';
import 'package:aid_first/services/auth/firebase_auth_service.dart';
import 'package:aid_first/services/database/firebase_database_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorDetails extends StatefulWidget {
  final Doctor doctorDetail;
  const DoctorDetails({
    required this.doctorDetail,
    Key? key,
  }) : super(key: key);

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  String selectedSlot = '10AM-10:30AM';
  DateTime selectedDate = DateTime.now();
  String? userId;
  List<Appointment> appointments = [];

  @override
  void initState() {
    FirebaseAuthService.instance.getAuthId().then((id) {
      if (id == null) return;
      setState(() {
        userId = id;
      });
      FirebaseDatabaseService.instance.getUserDetails(id).then((res) {
        if (res?.appointments == null) return;
        setState(() {
          appointments = res?.appointments ?? [];
        });
      });
    });

    super.initState();
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Material(
                    elevation: 4,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: Colors.red,
                          width: 3,
                        ),
                      ),
                      child: Text(
                        'Confirm Appointment Details',
                        style: GoogleFonts.prociono(
                            fontSize: 24, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Material(
                    elevation: 4,
                    borderRadius: const BorderRadius.all(Radius.circular(70)),
                    child: CircleAvatar(
                      backgroundColor: Colors.blue[800],
                      radius: 70,
                      child: Image.asset(
                        'assets/bigDoc.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Material(
                    elevation: 0,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                          color: Colors.blue,
                          width: 3,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Doctor Details',
                            style: GoogleFonts.prociono(
                                fontSize: 30, color: Colors.red),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            widget.doctorDetail.name!,
                            style: GoogleFonts.prociono(
                                fontSize: 24, color: Colors.black),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Degree: ${widget.doctorDetail.degree!}',
                            style: GoogleFonts.prociono(
                                fontSize: 20, color: Colors.black),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Experience: ${widget.doctorDetail.experience!}',
                            style: GoogleFonts.prociono(
                                fontSize: 20, color: Colors.black),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                    bottom: 5,
                    left: 20,
                    right: 20,
                  ),
                  child: Text(
                    'Select Appointment Date',
                    style:
                        GoogleFonts.prociono(fontSize: 24, color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: InkWell(
                    onTap: () => _showDialog(context),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(15),
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
                        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                    bottom: 5,
                    left: 20,
                    right: 20,
                  ),
                  child: Text(
                    'Select Appointment Slot',
                    style:
                        GoogleFonts.prociono(fontSize: 24, color: Colors.black),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  height: 130,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: widget.doctorDetail.appointmentSlots!
                        .map(
                          (e) => Row(
                            children: [
                              const SizedBox(width: 10),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedSlot = e;
                                  });
                                },
                                child: Material(
                                  elevation: selectedSlot == e ? 4 : 0,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(40)),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 100,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: selectedSlot == e
                                          ? Colors.blue
                                          : Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(40)),
                                      border: Border.all(
                                        color: selectedSlot == e
                                            ? Colors.white
                                            : Colors.blue,
                                        width: 2,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          e.split('-').first,
                                          style: TextStyle(
                                            color: selectedSlot == e
                                                ? Colors.white
                                                : Colors.blue,
                                          ),
                                        ),
                                        Text(
                                          'to',
                                          style: TextStyle(
                                            color: selectedSlot == e
                                                ? Colors.white
                                                : Colors.blue,
                                          ),
                                        ),
                                        Text(
                                          e.split('-').last,
                                          style: TextStyle(
                                            color: selectedSlot == e
                                                ? Colors.white
                                                : Colors.blue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: InkWell(
                    onTap: () async {
                      final List app = [];
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
                      for (int i = 0; i < appointments.length; i++) {
                        app.add({
                          'doctorId': appointments[i].id,
                          'name': appointments[i].name,
                          'slot': appointments[i].slot,
                          'date': appointments[i].date.toIso8601String(),
                        });
                      }
                      app.add({
                        'doctorId': widget.doctorDetail.id,
                        'name': widget.doctorDetail.name,
                        'slot': selectedSlot,
                        'date': selectedDate.toIso8601String(),
                      });
                      await FirebaseDatabaseService.instance.updateUserDetails(
                        userId: userId!,
                        updateDetails: {'appointments': app},
                      );
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const AppointmentBooked()));
                    },
                    child: Material(
                      elevation: 4,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
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
                          'Confirm & Book',
                          style: GoogleFonts.prociono(
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showDialog(context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year, DateTime.now().month + 1),
    );
    if (date != null && date != selectedDate) {
      setState(() {
        selectedDate = date;
      });
    }
  }
}
