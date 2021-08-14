import 'package:flutter/material.dart';
import 'package:news_app/screens/home_tabs/favorites.dart';
import 'package:news_app/screens/home_tabs/popular.dart';
import 'package:news_app/screens/home_tabs/whats_new.dart';
import 'package:news_app/screens/pages/about.dart';
import 'package:news_app/screens/pages/contact.dart';
import 'package:news_app/screens/pages/help.dart';
import 'package:news_app/screens/pages/settings.dart';
import 'package:news_app/sharedui/navigation_drawer.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

// pop up menu for actions
enum PopUpMenu { HELP, ABOUT, CONTACT, SETTINGS }

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  // dispose the initialized TabController to save memory
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // every screen has it's own appbar so that make one for every screen
      appBar: AppBar(
        title: Text('Explore'),
        centerTitle: false, // because ios default title in  appbar center
        actions: [
          IconButton(
            icon: Icon(
              Icons.search_rounded,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          _popUpMenu(context),
        ],
        bottom: TabBar(
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: "WHAT'S NEW"),
            Tab(text: "POPULAR"),
            Tab(text: "FAVORITES"),
          ],
          controller: _tabController,
        ),
      ),
      drawer: NavigationDrawer(),
      body: Center(
        child: TabBarView(
          controller: _tabController,
          children: [
            WhatsNew(),
            Popular(),
            Favorite(),
          ],
        ),
      ),
    );
  }

  Widget _popUpMenu(BuildContext context) {
    return PopupMenuButton<PopUpMenu>(
      itemBuilder: (context) {
        return [
          PopupMenuItem<PopUpMenu>(
            value: PopUpMenu.ABOUT,
            child: Text('ABOUT'),
          ),
          PopupMenuItem<PopUpMenu>(
            value: PopUpMenu.CONTACT,
            child: Text('CONTACT'),
          ),
          PopupMenuItem<PopUpMenu>(
            value: PopUpMenu.HELP,
            child: Text('HELP'),
          ),
          PopupMenuItem<PopUpMenu>(
            value: PopUpMenu.SETTINGS,
            child: Text('SETTINGS'),
          ),
        ];
      },
      onSelected: (PopUpMenu menu) {
        switch (menu) {
          case PopUpMenu.ABOUT:
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AboutUs();
            }));
            break;
          case PopUpMenu.CONTACT:
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ContactUs();
            }));
            break;
          case PopUpMenu.HELP:
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Help();
            }));
            break;
          case PopUpMenu.SETTINGS:
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Settings();
            }));
            break;
        }
      },
      icon: Icon(Icons.more_vert),
    );
  }
}
