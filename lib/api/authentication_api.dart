import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:news_app/utilities/api_utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationAPI {
  Future<bool> login(String email, String password) async {
    Map<String, String> headers = {
      'Accept-Encoding': 'gzip, deflate, br',
      'Connection': 'keep-alive'
    };
    // i'm not have a body in my api
    // Map<String, String> body = {
    //   'email' : email,
    //   'password' : password
    // };
    var response = await http.post(
      Uri.parse(authUrl),
      headers: headers,
    );

    try {
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('email', jsonData['email']);
        return true;
      } else {
        return false;
      }
    } catch (Exception) {
      return false;
    }
  }
}
