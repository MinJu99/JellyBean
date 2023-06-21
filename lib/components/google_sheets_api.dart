import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "spentlog",
  "private_key_id": "bba5b0ef8f61ee210ee6c7ed3f5a1c84c1f58966",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQC16KMEz1UGh4Q6\nqCzXF7q8w3hCgvYFMMc0rEDrpzjzWQPUeOcd6iNwgzVPUwTxzYDOayoA/V6J7BIg\n4oR0gYfmxP1BYXUSH5yaVINRgW4OkZDeZTIh/MuLfjVRbE2JpUAlP8pwRYaiyVCy\nL/VeP8UMUa6xD+59XM+gf9Y4rVhWP5b1p+157XHhb3QG+1LFv7j8Ff4m0OIclfaB\nG8Bpy7PJ7FDI/PHjfjj1I+95Acm7EK/hIjJuFYxaVn1+C5y4KKGeDb6kfgEtxGxL\n43N+WQiczdoqZm6vbPzttqXaraYlAagQjyh25fliFcYCu9PMtY9JiJVMHtcTGNdS\nwzQL21j7AgMBAAECggEADjAypDRmWwJaPkJRxQZqdUCrHPJJWBxMMqqLdxXtljrH\ngVywwh+PW2jl0TsWHqS7EDPsQcmBWdvvigsWQ7QQB+AuKgRSSkiW7AlSzhpR8ubz\nArWn6bNlo4quLpyg65nXsqVoF8ZZ0FFIGa3YmIemyeWGbPRjffmtjsTfI5U5rPha\nWxy63d5xtcxO69wJFvqKCq2QoeVFgQS4zN7R5hXaGluaMwy9cfVUK5PzlDNMT1z2\nIt/b75mbc1R/n0xfWjK+QAXxeornMH2WMSQ4A7POH0KdUwvUkZoQ7pO2vu2/7dG4\nwVOWc9yrr/oTwmGPMSMJcCcHZLCXM+bE9zMj6OlggQKBgQDl6A8g3V9rFpu6fm8f\nMbhQc1i96Yp3fKDrsWH0Qa1ZxWQzSRZEpWma8Kan/uZ6s+yDRK6Z84Gzobv48B3h\nr9WHIkkUWRWzh02qqNeZ0rMCyKXNpnOWlqundIO9AaSaA7NUQX1EJj5dePe3dpYt\nKJ6flBj9WwWrGdokXeoetq5SQQKBgQDKjgBm+5xSItpMqhq8arrzFQVE8M4vJZjE\njQC5duA5dEc/mxkvJwEYgUDF28FNqMYt/P4Dg25zKLBFshIw1DwtU2jXNcURVRe3\ns3PUELjYc5zLAlR0oT7g0W1FkQsbnDTwz97nOwv2KJDXFZJMk4SRw1XOvrvbzUZV\ntMnWHE1kOwKBgQCMNLQdJ8PMC/KWjgp4bJrpvR5OWwFNkxyUAA4rpm3wRDeyKw1A\nedvoWIBaDVJDXDyNZTJRwrXDdYur6ctfWhsPGTKWDSn13TrZK7SoI112AiVTQAJX\nwLUYHy9D8Z+PKViQtouNJwF7gY0YPmKhUZdC3E9NGthfGxn0ea2QY3n1wQKBgQCM\n8EulXJPDrw6YY5Ag5F7avxighLHiqlVnBfmoEugn8hmVT3UxkwE3LNCGG8egIrxq\nyWtxxGT46inlBOeVZEfO/geoH3jU+5F6N/pzZ4NG0QMbWq6rTHs08WQIEMla19Ea\ncnlWCYbkLAvELPVUJR0MU4+EQMD0SxwSjK4YNi8/ewKBgQCsJpx6IOTp5CZuk8//\nBzBR9xSdtZoiWY2mZDmnRyx5s8MeuxTZwUoa8oL++TyszkvbJIFOAl8Wspowu9Ne\n3kAGM/SzP8td//C/zNAAFB7WSNY9hvG/dV2+nrClnXfCWVG5lb5yIqQD7argms62\nvNkEGEWKiee6fYAEv6lNtiRsCw==\n-----END PRIVATE KEY-----\n",
  "client_email": "flutter-gsheet@spentlog.iam.gserviceaccount.com",
  "client_id": "103733011405459372356",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-gsheet%40spentlog.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
  }
''';

  //스프래드 시트 연동
  static final _spreadsheetId = '11pd8cevfZlw3cZPHyYq_QWWYZhMGE5Lf2_UhuzvaxQs';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;

  static int numberOffTransactions = 0;
  static List<List<dynamic>> currentTransactions = [];
  static bool loading = true;

  // 스프래드 시트 선언
  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = ss.worksheetByTitle('Worksheet1');
    countRows();
  }

  // 노트의 수
  static Future countRows() async {
    while ((await _worksheet!.values
            .value(column: 1, row: numberOffTransactions + 1)) !=
        '') {
      numberOffTransactions++;
    }
    // 노트 불러오기
    loadTransactions();
  }

  // 내역 불러오기
  static Future loadTransactions() async {
    if (_worksheet == null) return;

    for (int i = 1; i < numberOffTransactions; i++) {
      final String transactionName =
          await _worksheet!.values.value(column: 1, row: i + 1);
      final String transactionAmount =
          await _worksheet!.values.value(column: 2, row: i + 1);
      final String transactionType =
          await _worksheet!.values.value(column: 3, row: i + 1);

      if (currentTransactions.length < numberOffTransactions) {
        currentTransactions.add([
          transactionName,
          transactionAmount,
          transactionType,
        ]);
      }
    }
    loading = false;
  }

  //새로운 내역 입력 함수
  static Future insert(String name, String amount, bool _isIncome) async {
    if (_worksheet == null) return;
    numberOffTransactions++;
    currentTransactions.add([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
    await _worksheet!.values.appendRow([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
  }
}
