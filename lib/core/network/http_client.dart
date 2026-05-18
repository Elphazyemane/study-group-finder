import 'package:http/http.dart' as http;

class HttpClient {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  final http.Client client;

  HttpClient() : client = http.Client();

  Map<String, String> get headers => {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      };
}