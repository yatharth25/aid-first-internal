class AuthConstants {
  static const String uri = "https://authservice.priaid.ch/login";
  static const String apiKey = "b2W3E_ABES_AC_IN_AUT";
  static const String secretKey = "s7A2Pwq3KSy6a4GYi";

  static healthApiDiagnosisUri(String bearerToken) =>
      'https://healthservice.priaid.ch/diagnosis?token=' +
      bearerToken +
      '&language=en-gb&format=json';
  static healthApiSymptoms(String bearerToken) =>
      'https://healthservice.priaid.ch/symptoms?token=' +
      bearerToken +
      '&language=en-gb&format=json';
  static healthApiDiseaseInfo(dynamic issueId, String bearerToken) =>
      'https://healthservice.priaid.ch/issues/$issueId/info?token=' +
      bearerToken +
      '&language=en-gb&format=json';
}
