import 'package:flutter/material.dart';
import 'package:news_app/sharedui/navigation_drawer.dart';
class FaceBookFeeds extends StatefulWidget {
  @override
  _FaceBookFeedsState createState() => _FaceBookFeedsState();
}

class _FaceBookFeedsState extends State<FaceBookFeeds> {

  var _hashTagStyle = TextStyle(color: Colors.orange.shade900);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Facebook Feeds'),
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
                _drawHeader(),
                _drawTitle(),
                _drawHashTag(),
                _drawBody(),
                _drawFooter(),
              ],
            ),
          );
        },
        itemCount: 20,
      ),
    );
  }

  Widget _drawHeader() {
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
                color: Colors.grey.shade400,
                size: 28,
              ),
              onPressed: () {},
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

  Widget _drawBody() {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.25,
      child: Image(
        image: ExactAssetImage('assets/images/placeholder_bg.png'),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _drawFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(onPressed: (){}, child: Text('10 COMMENTS',style: _hashTagStyle,),),

        Row(
          children: [
            TextButton(onPressed: (){}, child: Text('SHARE',style: _hashTagStyle,),),
            TextButton(onPressed: (){}, child: Text('OPEN',style: _hashTagStyle,),),
          ],
        ),
      ],
    );
  }
}
