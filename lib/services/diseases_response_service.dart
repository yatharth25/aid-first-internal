import 'dart:convert';

import 'package:http/http.dart' as http;

class DiseaseResponseService {
  getDiseasesData() async {
    const String uri = 'https://disease-info-api.herokuapp.com/diseases.json';
    final response = await http.get(Uri.parse(uri));
    final jsonDecode = json.decode(response.body);
    return jsonDecode;
  }

  Future getDiseasesList() async {
    final diseases = await getDiseasesData();
    return diseases['diseases'];
  }
}
