import 'package:http/http.dart' as http;
import 'package:news_app/models/post.dart';
import 'dart:convert';
import 'package:news_app/utilities/api_utilities.dart';

class PostsAPI {
  // this method must take a parameter of categoryId
  // but because of my api i neglected it
  Future<List<Post>> fetchAllPostsByCategory() async {
    List<Post> posts = [];
    var apiUrl = baseUrl + postsUrl + key;
    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      for (var item in jsonData) {
        posts.add(Post(
            id: item['id'].toString(),
            title: item['title'].toString(),
            content: item['content'].toString(),
            dateWritten: item['date_written'].toString(),
            featuredImage: item['featured_image'].toString(),
            votesUp: item['votes_up'],
            votesDown: item['votes_down'],
            votersUp: (item['voters_up'] == null)
                ? []
                : jsonDecode(item['voters_up']),
            votersDown: (item['voters_down'] == null)
                ? []
                : jsonDecode(item['voters_down']),
            userId: item['user_id'],
            categoryId: item['category_id']));
      }
    }
    return posts;
  }
}
