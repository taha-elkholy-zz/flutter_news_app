import 'package:flutter/material.dart';
import 'package:news_app/api/posts_api.dart';
import 'package:news_app/models/post.dart';
import 'package:news_app/screens/single_post.dart';
import 'package:news_app/utilities/data_utilities.dart';

class Popular extends StatefulWidget {
  @override
  _PopularState createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  PostsAPI _postsAPI = PostsAPI();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _postsAPI.fetchAllPostsByCategory(),
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
                List<Post> posts = snapshot.data;
                return ListView.builder(
                  itemBuilder: (context, position) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 2, bottom: 2),
                      child: Card(
                        child: _drawSingleRow(posts[position]),
                      ),
                    );
                  },
                  itemCount: posts.length,
                );
              } else {
                return DataUtilities().noData();
              }
            }
            break;
        }
      },
    );
  }

  Widget _drawSingleRow(Post post) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SinglePost(post);
        }));
      },
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 125,
                    height: 125,
                    child: Image(
                      image: NetworkImage(post.featuredImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          post.content,
                          maxLines: 2,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(post.title,
                                style: TextStyle(color: Colors.grey)),
                            Row(
                              children: [
                                Icon(
                                  Icons.timer,
                                  color: Colors.grey,
                                ),
                                Text(
                                    DataUtilities()
                                        .parsHumanDate(post.dateWritten),
                                    style: TextStyle(color: Colors.grey)),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
