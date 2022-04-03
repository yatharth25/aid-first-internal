import 'dart:convert';

import 'package:aid_first/screens/patient/constants.dart';
import 'package:aid_first/screens/patient/diagnose_yourself/diagnose_results.dart';
import 'package:aid_first/services/preferences/shared_preferences_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';

class DiagnoseYourself extends StatefulWidget {
  const DiagnoseYourself({Key? key}) : super(key: key);

  @override
  State<DiagnoseYourself> createState() => _DiagnoseYourselfState();
}

class _DiagnoseYourselfState extends State<DiagnoseYourself> {
  final _multiSelectKey = GlobalKey<FormFieldState>();
  DateTime yearOfBirth = DateTime.now();
  dynamic symptoms;
  String? gender;
  List<Map<String, dynamic>> symptomsList = [];
  bool isSelected = false;

  Future<dynamic>? getSymptoms() async {
    try {
      final token =
          await SharedPreferencesService.instance.getString('BEARER_TOKEN');
      final res =
          await http.get(Uri.parse(AuthConstants.healthApiSymptoms(token!)));
      final List<dynamic> response = json.decode(res.body);
      List<Map<String, dynamic>> formattedRes = [];
      for (int i = 0; i < response.length; i++) {
        formattedRes
            .add({'id': response[i]['ID'], 'name': response[i]['Name']});
      }
      print(formattedRes);
      return formattedRes;
    } catch (e) {
      print('Error aayi hai');
      print(e);
    }
    return null;
  }

  @override
  initState() {
    super.initState();
    getSymptoms()?.then((value) => {
          if (mounted)
            {
              setState(() {
                symptomsList = value;
              })
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _items = symptomsList
        .map((e) =>
            MultiSelectItem<Map<String, dynamic>?>(e, e['name'].toString()))
        .toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Diagnose Yourself',
          style: GoogleFonts.prociono(
            fontSize: 30,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: symptomsList.isEmpty
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/syrup.png'),
                const SizedBox(height: 10),
                const Text("Loading..."),
                const SizedBox(height: 10),
                SizedBox(
                  width: 300,
                  child: LinearProgressIndicator(
                    color: Colors.blue[800],
                  ),
                ),
              ],
            ))
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.width * 0.8,
                          width: size.width * 0.8,
                          child: Image.asset(
                            'assets/diagnose.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              'What Symptoms are you getting?',
                              style: GoogleFonts.prociono(fontSize: 20),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        MultiSelectBottomSheetField(
                          backgroundColor: Colors.white,
                          selectedColor: Colors.blue[800],
                          key: _multiSelectKey,
                          searchable: true,
                          title: Text(
                            'Symptoms',
                            style: GoogleFonts.prociono(fontSize: 20),
                          ),
                          items: _items,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(40)),
                            border: Border.all(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                          listType: MultiSelectListType.LIST,
                          buttonIcon: const Icon(
                            Icons.healing,
                            color: Colors.blue,
                          ),
                          buttonText: Text(
                            "Add your symptoms",
                            style: GoogleFonts.prociono(
                              color: Colors.blue[800],
                              fontSize: 16,
                            ),
                          ),
                          initialChildSize: 0.5,
                          validator: (values) {
                            if (values == null || values.isEmpty) {
                              return "Required";
                            } else {
                              return null;
                            }
                          },
                          chipDisplay: MultiSelectChipDisplay(
                            textStyle:
                                GoogleFonts.prociono(color: Colors.white),
                            chipColor: Colors.blue,
                            onTap: (val) {
                              setState(() {
                                symptoms.remove(val);
                              });
                              _multiSelectKey.currentState!.validate();
                            },
                          ),
                          onConfirm: (values) {
                            setState(() {
                              symptoms = values;
                            });
                            _multiSelectKey.currentState!.validate();
                          },
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              'What is your Year of Birth?',
                              style: GoogleFonts.prociono(fontSize: 20),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        InkWell(
                          onTap: () => _showDialog(context),
                          child: Container(
                              padding: EdgeInsets.only(
                                top: 10,
                                bottom: 10,
                                left: isSelected ? 20 : 10,
                                right: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(40)),
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    isSelected
                                        ? yearOfBirth.year.toString()
                                        : 'Add your year of birth',
                                    style: GoogleFonts.prociono(
                                      color: Colors.blue[800],
                                      fontSize: isSelected ? 18 : 16,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.event_note,
                                    color: Colors.blue,
                                  )
                                ],
                              )),
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              'Any medical history? (Optional)',
                              style: GoogleFonts.prociono(fontSize: 20),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(40)),
                            border: Border.all(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                          child: TextField(
                            controller: TextEditingController(),
                            focusNode: FocusNode(),
                            decoration: const InputDecoration(
                                hintText: 'Enter medical conditions',
                                border: InputBorder.none),
                            style: GoogleFonts.prociono(fontSize: 16),
                          ),
                        ),
                        const SizedBox(height: 20),
                        GenderPickerWithImage(
                          size: 60,
                          showOtherGender: false,
                          verticalAlignedText: false,
                          selectedGender: Gender.Male,
                          selectedGenderTextStyle: GoogleFonts.prociono(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          unSelectedGenderTextStyle: GoogleFonts.prociono(
                              color: Colors.blue[800],
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                          onChanged: (Gender? gen) {
                            switch (gen) {
                              case Gender.Male:
                                setState(() {
                                  gender = 'male';
                                });
                                break;
                              case Gender.Female:
                                gender = 'female';
                                break;
                              default:
                                break;
                            }
                          },
                          equallyAligned: true,
                          animationDuration: const Duration(milliseconds: 300),
                          isCircular: true,
                          // default : true,
                          opacityOfGradient: 0.4,
                          padding: const EdgeInsets.all(3),
                          //default : 40
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/pill.png',
                          fit: BoxFit.contain,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DiagnoseResults(
                                  symptoms: symptoms as List<dynamic>,
                                  age: yearOfBirth.year.toString(),
                                  gender: gender ?? 'male',
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(40)),
                              border: Border.all(
                                color: Colors.blue,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              'Diagnose',
                              style: GoogleFonts.prociono(fontSize: 20),
                            ),
                          ),
                        ),
                        Image.asset(
                          'assets/injection.png',
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }

  _showDialog(context) {
    setState(() {
      isSelected = true;
    });
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Theme(
            data: ThemeData(
              canvasColor: Colors.white,
              backgroundColor: Colors.white,
            ),
            child: AlertDialog(
              title: Text(
                'Year',
                style: GoogleFonts.prociono(
                    fontSize: 20, fontWeight: FontWeight.w200),
                textAlign: TextAlign.center,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              content: Container(
                height: 400,
                width: 400,
                color: Colors.white,
                child: Material(
                  child: YearPicker(
                      firstDate: DateTime(DateTime.now().year - 100, 1),
                      lastDate: DateTime(DateTime.now().year),
                      initialDate: DateTime.now(),
                      selectedDate: yearOfBirth,
                      currentDate: yearOfBirth,
                      onChanged: (DateTime dateTime) {
                        setState(() {
                          yearOfBirth = dateTime;
                        });
                        Navigator.pop(context);
                      }),
                ),
              ),
            ),
          );
        });
  }
}
