import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/photo.dart';
import 'package:news_app/utilities/api_utilities.dart';

class PhotosAPI {
  Future<List<Photo>> fetchAllPhotos() async {
    List<Photo> photos = [];
    // url for authors
    String allPhotosApi = base_api + photos_url;
    var response = await http.get(Uri.parse(allPhotosApi));

    // check if the response done or not via status code
    // 200 success response
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body); // JSON Object
      //var data = jsonData["name of object"];
      for (var item in jsonData) {
        photos.add(Photo(
            item['albumId'].toString(),
            item['id'].toString(),
            item['title'].toString(),
            item['url'].toString(),
            item['thumbnailUrl'].toString()));
      }
    }
    return photos;
  }
}
