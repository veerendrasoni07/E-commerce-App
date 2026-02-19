import 'dart:convert';


import 'package:frontend/model/catergory.dart';
import 'package:http/http.dart' as http;

import '../global_variables.dart';


class CategoryController{
  // load the uploaded category
  Future<List<Category>> loadCategory() async {
    try {
      // send an http request to fetch banners...
      http.Response response = await http.get(
        Uri.parse('$uri/api/categories'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );


      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Category> category =
        data.map((category) => Category.fromJson(category)).toList();
        return category;
      } else {
        throw Exception("Failed to load category!");
      }
    } catch (e) {
      throw Exception("Failed to loading category!");
    }
  }
}