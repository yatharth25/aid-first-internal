import 'package:aid_first/app_routes.dart';
import 'package:aid_first/screens/patient/appointment_history/appointment_history.dart';
import 'package:aid_first/screens/patient/book_appointment/appointment.dart';
import 'package:aid_first/screens/splash_screen.dart';
import 'package:aid_first/screens/welcome_screen.dart';
import 'package:aid_first/services/preferences/shared_preferences_service.dart';
import 'package:aid_first/store/user_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';

class PatientDashboard extends StatefulWidget {
  const PatientDashboard({Key? key}) : super(key: key);

  @override
  State<PatientDashboard> createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Observer(
      builder: (_) => userStore.user == null
          ? const SplashScreen()
          : Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text(
                  index == 0 ? 'Aid First' : 'Profile',
                  style: GoogleFonts.prociono(
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
                centerTitle: true,
              ),
              bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  elevation: 8,
                  enableFeedback: true,
                  backgroundColor: Colors.white,
                  currentIndex: index,
                  onTap: (value) {
                    setState(() {
                      index = value;
                    });
                  },
                  items: const [
                    BottomNavigationBarItem(
                      label: 'Home',
                      icon: Icon(
                        Icons.home_outlined,
                        size: 30,
                      ),
                      activeIcon: Icon(
                        Icons.home_rounded,
                        color: Colors.blue,
                        size: 30,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: 'Me',
                      icon: Icon(
                        Icons.person_outline,
                        size: 30,
                      ),
                      activeIcon: Icon(
                        Icons.person_rounded,
                        color: Colors.blue,
                        size: 30,
                      ),
                    )
                  ]),
              body: SingleChildScrollView(
                child: Center(
                    child: Padding(
                  padding: EdgeInsets.only(
                    top: index == 1 ? 20 : 30,
                    left: index == 1 ? 20 : 0,
                    right: index == 1 ? 20 : 0,
                  ),
                  child: Column(
                    children: index == 1
                        ? [
                            Image.asset('assets/bigPat.png'),
                            const SizedBox(height: 20),
                            Material(
                              elevation: 4,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  width: double.maxFinite,
                                  height: 70,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.blue,
                                        width: 2,
                                      )),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.person_pin,
                                        size: 32,
                                        color: Colors.blue[900],
                                      ),
                                      const SizedBox(width: 20),
                                      Text(
                                        userStore.user!.name,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.blue[900],
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Material(
                              elevation: 4,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  width: double.maxFinite,
                                  height: 70,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.blue,
                                        width: 2,
                                      )),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.email,
                                        color: Colors.blue[900],
                                      ),
                                      const SizedBox(width: 20),
                                      Text(
                                        userStore.user!.email,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.blue[900],
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Material(
                              elevation: 4,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  width: double.maxFinite,
                                  height: 70,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.blue,
                                        width: 2,
                                      )),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.phone_in_talk,
                                          color: Colors.blue[900]),
                                      const SizedBox(width: 20),
                                      Text(
                                        userStore.user!.phoneNumber,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.blue[900],
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Material(
                              elevation: 4,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => AppointmentHistory(
                                        appointments:
                                            userStore.user!.appointments,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  width: double.maxFinite,
                                  height: 70,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.blue,
                                        width: 2,
                                      )),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.history,
                                          color: Colors.blue[900]),
                                      const SizedBox(width: 20),
                                      Text(
                                        'Appointment History',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.blue[900],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Material(
                              elevation: 4,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              child: InkWell(
                                onTap: () {
                                  SharedPreferencesService.instance
                                      .remove('AUTH_TOKEN');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const WelcomeScreen(),
                                    ),
                                  );
                                },
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  width: double.maxFinite,
                                  height: 70,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.blue,
                                        width: 2,
                                      )),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.logout,
                                          color: Colors.blue[900]),
                                      const SizedBox(width: 20),
                                      Text(
                                        'Logout',
                                        style: GoogleFonts.prociono(
                                          fontSize: 20,
                                          color: Colors.blue[900],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ]
                        : [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 20),
                              child: Material(
                                elevation: 2,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  width: double.maxFinite,
                                  height: 100,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        width: 2, color: Colors.blue.shade200),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    children: [
                                      const CircleAvatar(
                                        radius: 30,
                                        child: Icon(
                                          Icons.person_rounded,
                                          size: 40,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      SizedBox(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Hey ${userStore.user!.name.split(' ').first}!',
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                fontSize: 30,
                                              ),
                                            ),
                                            Text(
                                              'Start Exploring below!',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: size.width * 0.7,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  const SizedBox(width: 20),
                                  Material(
                                    elevation: 4,
                                    shadowColor: Colors.white10,
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                    child: Container(
                                      margin: const EdgeInsets.all(8),
                                      height: size.width * 0.6,
                                      width: size.width * 0.7,
                                      padding:
                                          const EdgeInsets.only(bottom: 30),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: const Color(0xffeeeeee),
                                            width: 2.0),
                                        color: Colors.white38,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.white10,
                                            blurRadius: 4,
                                            spreadRadius: 2,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        children: [
                                          Image.asset(
                                            'assets/card.jpeg',
                                            fit: BoxFit.fitWidth,
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: GestureDetector(
                                              onTap: () => {
                                                Navigator.pushNamed(context,
                                                    Routes.DIAGNOSE_YOURSELF)
                                              },
                                              child: Container(
                                                height: 35,
                                                width: 220,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Colors.blueAccent,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Diagnose YourSelf',
                                                    style: GoogleFonts.inter(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Material(
                                    elevation: 4,
                                    shadowColor: Colors.white10,
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                    child: Container(
                                      margin: const EdgeInsets.all(8),
                                      height: size.width * 0.7,
                                      width: size.width * 0.7,
                                      padding:
                                          const EdgeInsets.only(bottom: 30),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: const Color(0xffeeeeee),
                                            width: 2.0),
                                        color: Colors.white38,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.white10,
                                            blurRadius: 4,
                                            spreadRadius: 2,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        children: [
                                          Image.asset(
                                            'assets/card.jpeg',
                                            fit: BoxFit.fitWidth,
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: GestureDetector(
                                              onTap: () => {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        const Appointment(),
                                                  ),
                                                ),
                                              },
                                              child: Container(
                                                height: 35,
                                                width: 220,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Colors.blueAccent,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Book Appointment',
                                                    style: GoogleFonts.inter(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: size.width * 0.7,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  const SizedBox(width: 20),
                                  Material(
                                    elevation: 4,
                                    shadowColor: Colors.white10,
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                    child: Container(
                                      margin: const EdgeInsets.all(8),
                                      height: size.width * 0.7,
                                      width: size.width * 0.7,
                                      padding:
                                          const EdgeInsets.only(bottom: 30),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: const Color(0xffeeeeee),
                                            width: 2.0),
                                        color: Colors.white38,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.white10,
                                            blurRadius: 4,
                                            spreadRadius: 2,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        children: [
                                          Image.asset(
                                            'assets/card.jpeg',
                                            fit: BoxFit.fitWidth,
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: GestureDetector(
                                              onTap: () => {
                                                Navigator.pushNamed(context,
                                                    Routes.DISEASE_BY_NAME)
                                              },
                                              child: Container(
                                                height: 35,
                                                width: 220,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Colors.blueAccent,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Diagnose By Disease',
                                                    style: GoogleFonts.inter(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Material(
                                    elevation: 4,
                                    shadowColor: Colors.white10,
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                    child: Container(
                                      margin: const EdgeInsets.all(8),
                                      height: size.width * 0.7,
                                      width: size.width * 0.7,
                                      padding:
                                          const EdgeInsets.only(bottom: 30),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: const Color(0xffeeeeee),
                                            width: 2.0),
                                        color: Colors.white38,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.white10,
                                            blurRadius: 4,
                                            spreadRadius: 2,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        children: [
                                          Image.asset(
                                            'assets/card.jpeg',
                                            fit: BoxFit.fitWidth,
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: GestureDetector(
                                              onTap: () => {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        AppointmentHistory(
                                                      appointments: userStore
                                                          .user!.appointments,
                                                    ),
                                                  ),
                                                )
                                              },
                                              child: Container(
                                                height: 35,
                                                width: 220,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Colors.blueAccent,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Appointment History',
                                                    style: GoogleFonts.inter(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10)
                          ],
                  ),
                )),
              ),
            ),
    );
  }
}
