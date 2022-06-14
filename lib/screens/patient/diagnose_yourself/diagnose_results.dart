import 'dart:convert';

import 'package:aid_first/screens/patient/constants.dart';
import 'package:aid_first/screens/patient/diagnose_yourself/result_card.dart';
import 'package:aid_first/services/preferences/shared_preferences_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DiagnoseResults extends StatefulWidget {
  final List symptoms;
  final String age;
  final String gender;

  const DiagnoseResults({
    required this.symptoms,
    required this.age,
    required this.gender,
    Key? key,
  }) : super(key: key);

  @override
  State<DiagnoseResults> createState() => _DiagnoseResultsState();
}

Future<dynamic> getDiagnosisResults(
    List<dynamic> symptomIds, String age, String gender) async {
  try {
    final symptoms = json.encode(symptomIds);
    String urlComponent =
        '&symptoms=$symptoms&year_of_birth=$age&gender=$gender';
    final token =
        await SharedPreferencesService.instance.getString('BEARER_TOKEN');
    final res = await http.get(
        Uri.parse(AuthConstants.healthApiDiagnosisUri(token!) + urlComponent));
    final dynamic response = json.decode(res.body);
    List<Map<String, dynamic>> formattedRes = [];
    for (int i = 0; i < response.length; i++) {
      formattedRes.add({
        'id': response[i]['Issue']['ID'],
        'name': response[i]['Issue']['ProfName'],
        'accuracy': response[i]['Issue']['Accuracy'],
      });
    }

    return formattedRes;
  } catch (e) {
    print('Error aayi hai');
    print(e);
  }
}

class _DiagnoseResultsState extends State<DiagnoseResults> {
  List<Map<String, dynamic>> diagnosisResults = [];

  @override
  void initState() {
    super.initState();
    List symptomsIds = [];
    final age = widget.age;
    final gender = widget.gender;
    for (int i = 0; i < widget.symptoms.length; i++) {
      symptomsIds.add(widget.symptoms[i]['id']);
    }
    getDiagnosisResults(symptomsIds, age, gender).then((value) => {
          if (mounted)
            {
              setState(() {
                diagnosisResults = value;
              })
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> resultChildren = diagnosisResults
        .map<Widget>((result) => Column(
              children: [
                ResultCard(
                  id: result['id'],
                  name: result['name'],
                  accuracy: result['accuracy'],
                ),
                const SizedBox(height: 10),
              ],
            ))
        .toList();
    resultChildren.insert(
        0,
        SizedBox(
          child: Column(
            children: [
              Image.asset('assets/diagnose2.png', fit: BoxFit.contain),
            ],
          ),
        ));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Diagnosis Results',
          style: GoogleFonts.prociono(
            fontSize: 30,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: diagnosisResults.isEmpty
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
                  children: resultChildren,
                ),
              ),
            ),
    );
  }
}
