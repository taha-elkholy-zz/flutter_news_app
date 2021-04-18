import 'package:flutter/material.dart';
import 'package:news_app/sharedui/navigation_drawer.dart';

import 'home_tabs/favorites.dart';
import 'home_tabs/popular.dart';

class HeadLineNews extends StatefulWidget {
  @override
  _HeadLineNewsState createState() => _HeadLineNewsState();
}

class _HeadLineNewsState extends State<HeadLineNews> with SingleTickerProviderStateMixin{

  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // every screen has it's own appbar so that make one for every screen
      appBar: AppBar(
        title: Text('News'),
        centerTitle: false, // because ios default title in  appbar center
        actions: [
          IconButton(
            icon: Icon(
              Icons.search_rounded,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
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
            Favorite(),
            Popular(),
            Favorite(),
          ],
        ),
      ),
    );
  }
}
