// ignore_for_file: constant_identifier_names

import 'package:aid_first/screens/otherWidgetsAndScreen/about_us.dart';
import 'package:aid_first/screens/patient/diagnose_by_name/disease_by_name.dart';
import 'package:aid_first/screens/patient/diagnose_yourself/diagnose_yourself.dart';
import 'package:aid_first/screens/patient/patient_dashboard.dart';
import 'package:aid_first/screens/patient/patient_login.dart';
import 'package:aid_first/screens/patient/patient_profile.dart';
import 'package:aid_first/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String WELCOME_SCREEN = '/WelcomeScreen';
  static const String PATIENT_LOGIN = '/PatientLogin';
  static const String ABOUT_US = '/AboutUs';
  static const String PATIENT_DASHBOARD = '/PatientDashboard';
  static const String PATIENT_PROFILE = '/PatientProfile';
  static const String DISEASE_BY_NAME = '/DiseasebyName';
  static const String DIAGNOSE_YOURSELF = '/DiagnoseYourself';
}

Map<String, WidgetBuilder> getRoutes() {
  return {
    Routes.WELCOME_SCREEN: (_) => const WelcomeScreen(),
    Routes.PATIENT_LOGIN: (_) => const PatientLogin(),
    Routes.ABOUT_US: (_) => const AboutUs(),
    Routes.PATIENT_DASHBOARD: (_) => const PatientDashboard(),
    Routes.PATIENT_PROFILE: (_) => const PatientProfile(),
    Routes.DISEASE_BY_NAME: (_) => const DiseaseByName(),
    Routes.DIAGNOSE_YOURSELF: (_) => const DiagnoseYourself(),
  };
}
