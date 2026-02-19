import 'dart:convert';
import 'package:frontend/global_variables.dart';
import 'package:frontend/model/subcategory.dart';

import 'package:http/http.dart' as http;

class SubcategoryController {
  Future<List<SubCategory>> loadSubCategory(String categoryName) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/category/$categoryName/subcategory'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<SubCategory> subcategory =
            data
                .map((subcategory) => SubCategory.fromJson(subcategory))
                .toList();
        return subcategory;
      } else {
        throw Exception("Failed to fetch subcategory");
      }
    } catch (e) {
      throw Exception("Failed to load subcategory!");
    }
  }
}
