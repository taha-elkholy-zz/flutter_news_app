import 'package:flutter/material.dart';
import 'package:news_app/jsonplaceholderapis/photos_api.dart';
import 'package:news_app/models/photo.dart';
import 'package:news_app/sharedui/navigation_drawer.dart';
import 'package:news_app/utilities/data_utilities.dart';

class InstagramFeed extends StatefulWidget {
  @override
  _InstagramFeedState createState() => _InstagramFeedState();
}

class _InstagramFeedState extends State<InstagramFeed> {
  var _hashTagStyle = TextStyle(color: Colors.orange.shade900);
  List<int> ids = [];

// get apis from json Placeholder site
  PhotosAPI _photosAPI = PhotosAPI();

  @override
  void initState() {
    super.initState();
    // this should come from api
    ids = [0, 2, 5];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram Feeds'),
        centerTitle: false,
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      drawer: NavigationDrawer(),
      body: ListView.builder(
        padding: EdgeInsets.all(8),
        itemBuilder: (context, position) {
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _drawHeader(position),
                _drawTitle(),
                _drawHashTag(),
                _drawBody(position),
                _drawFooter(),
              ],
            ),
          );
        },
        itemCount: 20,
      ),
    );
  }

  Widget _drawHeader(int position) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: CircleAvatar(
                backgroundImage:
                    ExactAssetImage('assets/images/placeholder_bg.png'),
                radius: 24,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Taha Elkholy',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade900,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Fri, 14-7-2021 . 14.23',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: (ids.contains(position))
                    ? Colors.red
                    : Colors.grey.shade400,
                size: 28,
              ),
              onPressed: () {
                setState(() {
                  if (ids.contains(position)) {
                    ids.remove(position);
                  } else {
                    ids.add(position);
                  }
                });
              },
            ),
            Transform.translate(
              offset: Offset(-10, 0),
              child: Text(
                '25',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade400,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _drawTitle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
      child: Text(
        'Any Text here Can you give me any thing to help please',
        maxLines: 1,
        style:
        TextStyle(color: Colors.grey.shade800, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _drawHashTag() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Wrap(
          // Wrap take all the space and if the screen end it take new line
          children: [
            TextButton(
              onPressed: () {},
              child: Text('#advanced', style: _hashTagStyle),
            ),
            TextButton(
              onPressed: () {},
              child: Text('#anys', style: _hashTagStyle),
            ),
            TextButton(
              onPressed: () {},
              child: Text('#treee', style: _hashTagStyle),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawBody(int position) {
    return FutureBuilder(
        future: _photosAPI.fetchAllPhotos(),
        // ignore: missing_return
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return DataUtilities().connectionError();
              break;
            case ConnectionState.waiting:
              return DataUtilities().loading();
              break;
            case ConnectionState.active:
              return DataUtilities().loading();
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return DataUtilities().error(snapshot.error);
              } else {
                if (snapshot.hasData) {
                  List<Photo> photos = snapshot.data;
                  return SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Image.network(
                      photos[position].url,
                      fit: BoxFit.cover,
                    ),
                  );
                } else {
                  return DataUtilities().noData();
                }
              }
              break;
          }
        });
  }

  Widget _drawFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {},
          child: Text(
            '10 COMMENTS',
            style: _hashTagStyle,
          ),
        ),
        Row(
          children: [
            TextButton(
              onPressed: () {},
              child: Text(
                'SHARE',
                style: _hashTagStyle,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'OPEN',
                style: _hashTagStyle,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
