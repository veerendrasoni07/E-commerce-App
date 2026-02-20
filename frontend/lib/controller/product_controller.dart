import 'dart:convert';

import 'package:frontend/model/product.dart';

import 'package:http/http.dart' as http;

import '../global_variables.dart';
class ProductController{

  Future<List<Product>> loadProduct() async{

    try{
      http.Response response = await http.get(Uri.parse('$uri/api/popular-product'),headers: <String,String>{"Content-Type":"application/json; charset=UTF-8"});

      if(response.statusCode == 200){
        print(response.body);
        List<dynamic> data = jsonDecode(response.body);
        List<Product> product = data.map((product)=> Product.fromJson(product)).toList();
        return product;
      }
      else{
        throw Exception("Failed to load product!");
      }

    }
    catch(e){
      print("Error : $e");
      throw Exception("Error occurred while loading product!");
    }

  }

  // load product by category

  Future<List<Product>> loadProductByCategory(String categoryName) async{
    try{
      http.Response response = await http.get(Uri.parse('$uri/api/product-by-category/$categoryName'),headers: <String,String>{
        'Content-Type':'application/json; charset=UTF-8'
      });
      print(response.body);
      if(response.statusCode == 200){
        List<dynamic> data = jsonDecode(response.body);
        List<Product> product = data.map((product)=>Product.fromJson(product)).toList();
        return product;
      }
      else if (response.statusCode == 404) {
        // Instead of throwing error, just return empty list
        return [];
      }
      else{
        throw Exception("Failed to load product");
      }
    }
    catch(e){
      print("Error : $e");
      throw Exception("Error occurred while loading product!");
    }
  }

  // method to load product by subcategory via subcategoryName
  Future<List<Product>> loadProductBySubcategory(String subcategoryName)async{
    try{
      http.Response response = await http.get(
          Uri.parse('$uri/api/product-by-subcategory/$subcategoryName'),
          headers: <String,String>{'Content-Type':'application/json; charset=UTF-8'}
      );

      if(response.statusCode == 200){
        List<dynamic> data = jsonDecode(response.body);
        List<Product> products = data.map((product)=>Product.fromJson(product)).toList();
        return products;
      }
      else{
        return [];
      }
    }
    catch(e){
      throw Exception("Failed to load product");
    }
  }

  // method to fetch similar product
  Future<List<Product>> loadSimilarProduct(String productId) async{
    try{
      http.Response response = await http.get(Uri.parse('$uri/api/similar-product-by-subcategory/$productId'),headers: <String,String>{
        'Content-Type':'application/json; charset=UTF-8'
      });
      print(response.body);
      if(response.statusCode == 200){
        List<dynamic> data = jsonDecode(response.body);
        List<Product> product = data.map((product)=>Product.fromJson(product)).toList();
        return product;
      }
      else if (response.statusCode == 404) {
        // Instead of throwing error, just return empty list
        return [];
      }
      else{
        throw Exception("Failed to load product");
      }
    }
    catch(e){
      print("Error : $e");
      throw Exception("Error occurred while loading product!");
    }
  }

  // load top rated product (not working right now)
  Future<List<Product>> loadTopRatedProduct() async{
    try{
      http.Response response = await http.get(Uri.parse('$uri/api/top-rated-products'),headers: <String,String>{
        'Content-Type':'application/json; charset=UTF-8'
      });
      if(response.statusCode == 200){
        List<dynamic> data = jsonDecode(response.body);
        List<Product> products = data.map((product)=>Product.fromJson(product)).toList();
        return products;
      }
      else if (response.statusCode == 404) {
        // Instead of throwing error, just return empty list
        return [];
      }
      else{
        throw Exception("Failed to load product");
      }
    }
    catch(e){
      print("Error : $e");
      throw Exception("Error occurred while loading product!");
    }
  }

  Future<List<Product>> searchProduct(String query) async{
    try{
      http.Response response = await http.get(Uri.parse('$uri/api/search-products?query=$query'),headers: <String,String>{
        'Content-Type':'application/json; charset=UTF-8'
      });
      if(response.statusCode == 200){
        List<dynamic> data = jsonDecode(response.body);
        List<Product> product = data.map((product)=>Product.fromJson(product)).toList();
        return product;
      }
      else if (response.statusCode == 404) {
        // Instead of throwing error, just return empty list
        return [];
      }
      else{
        throw Exception("Failed to Search product");
      }
    }
    catch(e){
      print("Error : $e");
      throw Exception("Error occurred while Searching product!");
    }
  }

}
