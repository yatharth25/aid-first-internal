import 'package:aid_first/models/doctor.dart';
import 'package:aid_first/services/appointment_service/firebase_apointment_base.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseAppointmentService implements FirebaseAppointmentServiceBase {
  late final DatabaseReference _ref;

  FirebaseAppointmentService._privateConstructor() {
    _ref = FirebaseDatabase.instance.ref('users');
  }

  static final FirebaseAppointmentService instance =
      FirebaseAppointmentService._privateConstructor();

  @override
  Future<List<Doctor>?> getDoctorDetails() async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('doctors');
    final res = await ref.once(DatabaseEventType.value);

    if (res.snapshot.exists) {
      final List result = res.snapshot.value as List;
      List<Doctor>? docList = [];

      for (int i = 1; i < result.length; i++) {
        List<String> appointments = [];
        for (int j = 0; j < result[i]['appointmentSlots'].length; j++) {
          appointments.add(result[i]['appointmentSlots'][j] as String);
        }
        docList.add(
          Doctor(
            id: i.toString(),
            name: result[i]['name'] as String,
            degree: result[i]['degree'] as String,
            experience: result[i]['experience'] as String,
            appointmentSlots: appointments,
          ),
        );
      }
      return docList;
    } else {
      return null;
    }
  }

  @override
  Future setDoctorDetails({
    String? id,
    String? name,
    String? degree,
    String? experience,
    List<String>? appointmentSlots,
  }) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('doctors/$id');

    final res = await ref.set({
      "name": name,
      "degree": degree,
      "experience": experience,
      "appointmentSlots": appointmentSlots,
    });
    return res;
  }

  @override
  Future updateDoctorDetails(
      {required String id, Map<String, Object?>? updateDetails}) async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref('doctors/$id');
    final res = await ref.update(updateDetails!);

    return res;
  }
}
