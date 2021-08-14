import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/models/post.dart';

class SinglePost extends StatefulWidget {
  final Post post;

  SinglePost(this.post);

  @override
  _SinglePostState createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            floating: true,
            pinned: true,
            title: Text(widget.post.title.toString()),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.post.featuredImage),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, position) {
                if (position == 0) {
                  return _drawPostDetails();
                } else if (position == 1) {
                  return _drawSectionTitle('Comments');
                } else if (position >= 2 && position < 24) {
                  return _comments();
                } else {
                  return _commentTextEntry();
                }
              },
              childCount: 25,
            ),
          )
        ],
      ),
    );
  }

  Color getRandomColor() {
    List colors = [
      Colors.red,
      Colors.green,
      Colors.yellow,
      Colors.blue,
      Colors.lightGreen
    ];
    Random random = new Random();
    return colors[random.nextInt(colors.length)];
  }

  Widget _drawPostDetails() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(
        widget.post.content,
        style: TextStyle(fontSize: 18, letterSpacing: 1.2, height: 1.22),
      ),
    );
  }

  Widget _comments() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage:
                    ExactAssetImage('assets/images/placeholder_bg.png'),
              ),
              SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Taha Elkholy'),
                  Text('1 hour'),
                ],
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'Any Text Comment Her With My Wife in Canada Any Text Comment Her With My Wife in CanadaAny Text Comment Her With My Wife in Canada Any Text Comment Her With My Wife in Canada',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _commentTextEntry() {
    return Container(
      color: Color.fromRGBO(241, 245, 247, 1),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 16, left: 16),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Write a Comment her',
                        contentPadding:
                            EdgeInsets.only(left: 16, top: 24, bottom: 32)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  child: Text(
                    'SEND',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {},
                ),
              )
            ],
          ),
          SizedBox(
            height: 8,
          )
        ],
      ),
    );
  }

  Widget _drawSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey.shade700,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }
}
