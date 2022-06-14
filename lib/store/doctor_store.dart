import 'package:aid_first/models/doctor.dart';
import 'package:mobx/mobx.dart';

part 'doctor_store.g.dart';

class DoctorStore = _DoctorStore with _$DoctorStore;

abstract class _DoctorStore with Store {
  @observable
  String? doctorId;

  @observable
  Doctor? doctor;

  @action
  setDoctorId(String id) {
    doctorId = id;
  }

  @action
  setDoctorDetails(Doctor docDetails) {
    doctor = docDetails;
  }
}

DoctorStore doctorStore = DoctorStore();
