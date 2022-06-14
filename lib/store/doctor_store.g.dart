// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DoctorStore on _DoctorStore, Store {
  late final _$doctorIdAtom =
      Atom(name: '_DoctorStore.doctorId', context: context);

  @override
  String? get doctorId {
    _$doctorIdAtom.reportRead();
    return super.doctorId;
  }

  @override
  set doctorId(String? value) {
    _$doctorIdAtom.reportWrite(value, super.doctorId, () {
      super.doctorId = value;
    });
  }

  late final _$doctorAtom = Atom(name: '_DoctorStore.doctor', context: context);

  @override
  Doctor? get doctor {
    _$doctorAtom.reportRead();
    return super.doctor;
  }

  @override
  set doctor(Doctor? value) {
    _$doctorAtom.reportWrite(value, super.doctor, () {
      super.doctor = value;
    });
  }

  late final _$_DoctorStoreActionController =
      ActionController(name: '_DoctorStore', context: context);

  @override
  dynamic setDoctorId(String id) {
    final _$actionInfo = _$_DoctorStoreActionController.startAction(
        name: '_DoctorStore.setDoctorId');
    try {
      return super.setDoctorId(id);
    } finally {
      _$_DoctorStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setDoctorDetails(Doctor docDetails) {
    final _$actionInfo = _$_DoctorStoreActionController.startAction(
        name: '_DoctorStore.setDoctorDetails');
    try {
      return super.setDoctorDetails(docDetails);
    } finally {
      _$_DoctorStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
doctorId: ${doctorId},
doctor: ${doctor}
    ''';
  }
}
