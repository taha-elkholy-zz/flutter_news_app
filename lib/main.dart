import 'package:flutter/material.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/utilities/app_theme.dart';
import 'screens/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  //You only need to call this method if you need the binding to be
  // initialized before calling [runApp].
  WidgetsFlutterBinding.ensureInitialized();

  // SharedPreferences object
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs != null) {
    // seen refer to the onBoarding if opened or not
    bool seen = prefs.getBool('seen') ?? false;
    if (seen == false) {
      // open OnBoarding
      runApp(NewsApp(OnBoarding()));
    } else {
      // open home
      runApp(NewsApp(Home()));
    }
  }
}

class NewsApp extends StatelessWidget {
  final Widget _screen;

  NewsApp(this._screen);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      home: this._screen, // welcome screen in first time open or Home
    );
  }
}
