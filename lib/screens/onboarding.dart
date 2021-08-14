import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../page_model.dart';
import 'home_screen.dart';

/*
* the first screen the user see
* which appear only in the first time user use the application
* */
class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  // list of PageModels
  List<PageModel> _pages;

  //  using PageViewIndicator plugin
  ValueNotifier<int> _pageViewNotifier = ValueNotifier(0);

  Widget _displayPageIndicators(int length) {
    return PageViewIndicator(
      pageIndexNotifier: _pageViewNotifier,
      length: length,
      normalBuilder: (animationController, index) => Circle(
        size: 8.0,
        color: Colors.grey,
      ),
      highlightedBuilder: (animationController, index) => ScaleTransition(
        scale: CurvedAnimation(
          parent: animationController,
          curve: Curves.ease,
        ),
        child: Circle(
          size: 12.0,
          color: Colors.red.shade800,
        ),
      ),
    );
  }

  void _addPages() {
    _pages = [];
    _pages.add(PageModel(
        'assets/images/bg1.png',
        'Welcome!',
        'Welcome! description Welcome! description Welcome! description Welcome! description Welcome! description ',
        Icons.terrain));
    _pages.add(PageModel(
        'assets/images/bg2.png',
        'Hello!',
        'Hello! description Hello! description Hello! description Hello! description Hello! description ',
        Icons.terrain_outlined));
    _pages.add(PageModel(
        'assets/images/bg3.png',
        'Great!',
        'Great! description Great! description Great! description Great! description Great! description ',
        Icons.terrain_sharp));
    _pages.add(PageModel(
        'assets/images/bg4.png',
        'Good Job!',
        'Good Job description Good Job description Good Job description Good Job description Good Job description ',
        Icons.terrain_rounded));
  }

  @override
  Widget build(BuildContext context) {
    _addPages();
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            itemBuilder: (context, index) {
              // index indicator of the recent page
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage(_pages[index].imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Transform.translate(
                        child: Icon(
                          _pages[index].icon,
                          size: 150,
                          color: Colors.white,
                        ),
                        offset: Offset(0, -100),
                      ),
                      Text(
                        _pages[index].title,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 24, right: 24, top: 18),
                        child: Text(
                          _pages[index].description,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
            itemCount: _pages.length, // number of the pages
            onPageChanged: (index) {
              _pageViewNotifier.value = index;
            },
          ),
          Transform.translate(
            offset: Offset(0, 170),
            child: Align(
              alignment: Alignment.center,
              child: _displayPageIndicators(_pages.length),
            ),
          ),
          Align(
            // use for set the widget in identical space
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red.shade800),
                  ),
                  child: Text(
                    'GET STARTED',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 1),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          _updateSeen();
                          return Home();
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _updateSeen() async {
    // SharedPreferences object
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      await prefs.setBool('seen', true);
    }
  }
}
