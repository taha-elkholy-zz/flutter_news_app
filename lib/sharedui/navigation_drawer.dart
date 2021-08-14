import 'package:flutter/material.dart';
import 'package:news_app/models/nav_menu.dart';
import 'package:news_app/screens/facebook_feed.dart';
import 'package:news_app/screens/headline_news.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/instagram_feed.dart';
import 'package:news_app/screens/pages/login.dart';
import 'package:news_app/screens/twitter_feed.dart';
import 'package:news_app/utilities/app_utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
* Make this NavigationDrawer stateful because we will use it with several stats
*  */
class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  bool isLoggedIn = false;
  SharedPreferences sharedPreferences;
  String email;

  _checkEmail() async {
    sharedPreferences = await SharedPreferences.getInstance();
    email = sharedPreferences.getString('email');
    setState(() {
      if (email == null) {
        isLoggedIn = false;
      } else {
        isLoggedIn = true;
      }
    });
  }

  List<NavMenuItem> _navigationMenuItems = [
    NavMenuItem('Explore', () => Home()),
    NavMenuItem('Headline News', () => HeadLineNews()),
    NavMenuItem('Twitter Feeds', () => TwitterFeed()),
    NavMenuItem('Instagram Feeds', () => InstagramFeed()),
    NavMenuItem('Facebook Feeds', () => FaceBookFeeds()),
    //NavMenuItem('Login', () => Login()),
    // NavMenuItem('Facebook Feeds', () => FaceBookFeeds()),
  ];

  @override
  void initState() {
    super.initState();
    if (isLoggedIn) {
      _navigationMenuItems.add(NavMenuItem('Logout', () => _logout));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (this.mounted) {
      _checkEmail();
    }
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 75, left: 8),
        child: ListView.builder(
          itemBuilder: (context, position) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: ListTile(
                title: Text(
                  _navigationMenuItems[position].title,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 22),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.grey.shade400,
                ),
                onTap: () {
                  Navigator.pop(context); // close the drawer menu
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return _navigationMenuItems[position].destination();
                  }));
                },
              ),
            );
          },
          itemCount: _navigationMenuItems.length,
        ),
      ),
    );
  }

  _logout() {
    if (sharedPreferences != null) {
      sharedPreferences.remove('email');
    }
    return Home();
  }
}
