import 'dart:math';

import 'package:flutter/material.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  List<Color> _colorList = [
    Colors.red,
    Colors.teal,
    Colors.brown,
    Colors.indigo,
    Colors.deepOrange,
    Colors.purple,
    Colors.yellow,
    Colors.green,
  ];

  Random _random = Random();

  Color _getRandomColor() {
    var random = _random.nextInt(_colorList.length);
    return _colorList[random];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, position) {
        return Card(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                _authorRow(),
                SizedBox(
                  height: 16,
                ),
                _newsItemRow(),
              ],
            ),
          ),
        );
      },
      itemCount: 20,
    );
  }

  Widget _authorRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          ExactAssetImage('assets/images/placeholder_bg.png'),
                      fit: BoxFit.cover),
                  shape: BoxShape.circle),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Taha Elkholy',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w600),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('15 Min .',
                        style: TextStyle(
                          color: Colors.grey,
                        )),
                    Text('LifeStyle',
                        style: TextStyle(
                            color: _getRandomColor(),
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ],
        ),
        IconButton(
          icon: Icon(
            Icons.bookmark_border,
            color: Colors.grey,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _newsItemRow() {
    return Row(
      children: [
        Container(
          width: 125,
          height: 125,
          margin: EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage('assets/images/placeholder_bg.png'),
                fit: BoxFit.cover),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                'Any thing to show her Any thing to show her ',
                maxLines: 2,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Hi my name is Taha Hi my name is Taha Hi my name is Taha Hi my name is Taha Hi my name is Taha ',
                maxLines: 3,
                style: TextStyle(
                  height: 1.5,
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
