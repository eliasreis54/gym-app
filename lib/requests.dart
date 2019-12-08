import 'package:http/http.dart' as http;

class Requests {
  Future<http.Response> fetchExercises() {
    return http.get('http://www.mocky.io/v2/5ded1c5433000010002b90b9');
  }
}
