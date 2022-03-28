class AuthConstants {
  static const bearerToken =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InlhdGhhcnRoLjE4Yml0MTA0M0BhYmVzLmFjLmluIiwicm9sZSI6IlVzZXIiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9zaWQiOiI5OTEwIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy92ZXJzaW9uIjoiMjAwIiwiaHR0cDovL2V4YW1wbGUub3JnL2NsYWltcy9saW1pdCI6Ijk5OTk5OTk5OSIsImh0dHA6Ly9leGFtcGxlLm9yZy9jbGFpbXMvbWVtYmVyc2hpcCI6IlByZW1pdW0iLCJodHRwOi8vZXhhbXBsZS5vcmcvY2xhaW1zL2xhbmd1YWdlIjoiZW4tZ2IiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL2V4cGlyYXRpb24iOiIyMDk5LTEyLTMxIiwiaHR0cDovL2V4YW1wbGUub3JnL2NsYWltcy9tZW1iZXJzaGlwc3RhcnQiOiIyMDIxLTExLTEyIiwiaXNzIjoiaHR0cHM6Ly9zYW5kYm94LWF1dGhzZXJ2aWNlLnByaWFpZC5jaCIsImF1ZCI6Imh0dHBzOi8vaGVhbHRoc2VydmljZS5wcmlhaWQuY2giLCJleHAiOjE2NDg0OTU5MTEsIm5iZiI6MTY0ODQ4ODcxMX0.exmtkZBYm_5alDURFpW9aZQi961H0z9LSLsXj6dQ6y8';
  static const healthApiDiagnosisUri =
      'https://sandbox-healthservice.priaid.ch/diagnosis?token=' +
          bearerToken +
          '&language=en-gb&format=json';
  static const healthApiSymptoms =
      'https://sandbox-healthservice.priaid.ch/symptoms?token=' +
          bearerToken +
          '&language=en-gb&format=json';
  static healthApiDiseaseInfo(dynamic issueId) =>
      'https://sandbox-healthservice.priaid.ch/issues/$issueId/info?token=' +
      bearerToken +
      '&language=en-gb&format=json';
}
