import 'package:http/http.dart' as http;
import 'package:news_app/models/category.dart';
import 'dart:convert';
import 'package:news_app/utilities/api_utilities.dart';
class CategoriesAPI{

  Future<List<Category>> fetchAllCategories() async{
    List<Category> categories = [];
    var allCategoriesApi = baseUrl + categoriesUrl + key ;
    var response = await http.get(Uri.parse(allCategoriesApi));

    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      for(var item in jsonData){
        categories.add(Category(item['id'].toString(), item['title'].toString()));
      }
    }
    for(Category category in categories){
      print(category.id + ' ' + category.title);
    }
    return categories;
}
}