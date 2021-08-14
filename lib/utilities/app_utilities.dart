import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isLoggedIn() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool isLoggedIn = sharedPreferences.getBool('is_logged_in');
  if (isLoggedIn == null || isLoggedIn == false) {
    return false;
  }
  return true;
}
