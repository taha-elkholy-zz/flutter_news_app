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
    return CustomScrollView(
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
                return Container(
                  height: 650,
                  color: getRandomColor(),
                );
              } else {
                return Container(
                  height: 250,
                  color: getRandomColor(),
                );
              }
            },
            childCount: 25,
          ),
        )
      ],
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
}
