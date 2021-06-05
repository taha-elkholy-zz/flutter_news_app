import 'package:http/http.dart' as http;
 // to convert Json files
import 'dart:convert';

import 'package:news_app/models/author.dart';
import 'package:news_app/utilities/api_utilities.dart';
class AuthorsAPI{

 Future<List<Author>> fetchAllAuthors() async {
   List<Author> authors = [];
   // url for authors
   String allAuthorsApis = baseUrl + authorsUrl + key;
   var response =  await http.get(Uri.parse(allAuthorsApis));

   // check if the response done or not via status code
   // 200 success response
   if(response.statusCode == 200){
     var jsonData = jsonDecode(response.body); // JSON Object
     //var data = jsonData["name of object"];
     for(var item in jsonData){
       authors.add(Author(item['id'].toString(), item['name'].toString(),
           item['email'].toString(), item['username'].toString()));
     }
   }
   return authors;
  }
}