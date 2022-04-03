import 'package:aid_first/models/doctor.dart';

abstract class FirebaseAppointmentServiceBase {
  Future setDoctorDetails({
    String? id,
    String? name,
    String? degree,
    String? experience,
    List<String>? appointmentSlots,
  });
  Future updateDoctorDetails(
      {required String id, Map<String, Object?>? updateDetails});
  Future<List<Doctor>?> getDoctorDetails();
}
