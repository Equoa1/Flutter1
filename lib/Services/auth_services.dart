import 'dart:convert';

import 'package:flutterapp/Services/globals.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  static Future<http.Response> register(
      String matricula, String name, String email, String password) async {
    Map data = {
      "matricula": matricula,
      "name": name,
      "email": email,
      "password": password,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseURL + 'auth/register');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> login(String matricula, String password) async {
    Map data = {
      "matricula": matricula,
      "password": password,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseURL + 'auth/login');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    return response;
  }
}
