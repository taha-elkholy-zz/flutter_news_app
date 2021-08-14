import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/api/posts_api.dart';
import 'package:news_app/screens/single_post.dart';
import 'package:news_app/utilities/data_utilities.dart';

import 'package:news_app/models/post.dart';

class WhatsNew extends StatefulWidget {
  @override
  _WhatsNewState createState() => _WhatsNewState();
}

class _WhatsNewState extends State<WhatsNew> {
  PostsAPI postsAPI = PostsAPI();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _drawHeader(),
          _drawTopStories(),
          _drawRecentUpdates(),
        ],
      ),
    );
  }

  Widget _drawHeader() {
    TextStyle _headerTitle = TextStyle(
        color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600);
    TextStyle _headerDescription = TextStyle(
      color: Colors.white,
      fontSize: 18,
    );
    return FutureBuilder(
        future: postsAPI.fetchAllPostsByCategory(),
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
                  Random random = Random();
                  Post post = posts[random.nextInt(posts.length)];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SinglePost(post);
                      }));
                    },
                    child: Container(
                      // must take width and height
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height *
                          .25, // get 25% of screen size height
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(post.featuredImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 48, right: 48),
                              child: Text(
                                post.title,
                                style: _headerTitle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 32, right: 32),
                              child: Text(
                                (post.content.length >= 75)
                                    ? post.content.substring(0, 75)
                                    : post.content,
                                style: _headerDescription,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
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

  Widget _drawTopStories() {
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16),
            child: _drawSectionTitle('Top Stories'),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Card(
              child: FutureBuilder(
                future: postsAPI.fetchAllPostsByCategory(),
                builder: (context, AsyncSnapshot snapshot) {
                  // ensure tht we get the data or not
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      // it's loading
                      return DataUtilities().loading();
                      break;
                    case ConnectionState.active:
                      // also return loading
                      return DataUtilities().loading();
                      break;

                    case ConnectionState.none:
                      // there is a network problem
                      return DataUtilities().connectionError();
                      break;

                    case ConnectionState.done:
                      // Ensure that we have error in returned data or not
                      if (snapshot.error != null) {
                        // we have error, handle it her
                        return DataUtilities().error(snapshot.error);
                      } else {
                        // we not have error in returned data
                        // Ensure that returned data not null
                        if (snapshot.hasData) {
                          //we get data from API, use it her
                          List<Post> posts = snapshot.data;
                          // Ensure that we have at least 3 objects in data
                          if (posts.length >= 3) {
                            // her use the data
                            Post post1 = snapshot.data[0];
                            Post post2 = snapshot.data[1];
                            Post post3 = snapshot.data[2];
                            return Column(
                              children: [
                                _drawSingleRow(post1),
                                _drawDivider(),
                                _drawSingleRow(post2),
                                _drawDivider(),
                                _drawSingleRow(post3),
                              ],
                            );
                          } else {
                            // if the data length less than 3
                            return DataUtilities().noData();
                          }
                        } else {
                          // we have no data returned
                          return DataUtilities().noData();
                        }
                      }
                      break;
                  }
                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        height: 1,
        width: double.infinity,
        color: Colors.grey,
      ),
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
                    child: Image.network(
                      post.featuredImage,
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

  Widget _drawSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.grey.shade700,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );
  }

  Widget _drawRecentUpdatesCard(Color color, Post post) {
    return FutureBuilder(
      future: postsAPI.fetchAllPostsByCategory(),
      builder: (context, AsyncSnapshot snapshot) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SinglePost(post);
            }));
          },
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * .25,
                  child: Image.network(post.featuredImage),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 24, right: 24, top: 2, bottom: 2),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      post.title,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                  child: Text(
                    post.content,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    bottom: 16,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.timer,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        DataUtilities().parsHumanDate(post.dateWritten),
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _drawRecentUpdates() {
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 16,
            ),
            child: _drawSectionTitle('Recent Updates'),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Card(
              child: FutureBuilder(
                future: postsAPI.fetchAllPostsByCategory(),
                builder: (context, AsyncSnapshot snapshot) {
                  // ensure tht we get the data or not
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      // it's loading
                      return DataUtilities().loading();
                      break;
                    case ConnectionState.active:
                      // also return loading
                      return DataUtilities().loading();
                      break;

                    case ConnectionState.none:
                      // there is a network problem
                      return DataUtilities().connectionError();
                      break;

                    case ConnectionState.done:
                      // Ensure that we have error in returned data or not
                      if (snapshot.error != null) {
                        // we have error, handle it her
                        return DataUtilities().error(snapshot.error);
                      } else {
                        // we not have error in returned data
                        // Ensure that returned data not null
                        if (snapshot.hasData) {
                          //we get data from API, use it her
                          List<Post> posts = snapshot.data;
                          // Ensure that we have at least 5 objects in data
                          // use 4 & 5 item for recent updates
                          if (posts.length >= 5) {
                            // her use the data
                            Post post4 = snapshot.data[3];
                            Post post5 = snapshot.data[4];
                            return Column(
                              children: [
                                _drawRecentUpdatesCard(
                                    Colors.red.shade800, post4),
                                _drawRecentUpdatesCard(Colors.teal, post5),
                              ],
                            );
                          } else {
                            // if the data length less than 3
                            return DataUtilities().noData();
                          }
                        } else {
                          // we have no data returned
                          return DataUtilities().noData();
                        }
                      }
                      break;
                  }
                  return Container();
                },
              ),
            ),
          ),
          SizedBox(
            width: 1,
            height: 48,
          )
        ],
      ),
    );
  }
}
