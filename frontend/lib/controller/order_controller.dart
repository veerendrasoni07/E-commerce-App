
import 'dart:convert';

import 'package:frontend/global_variables.dart';
import 'package:frontend/model/order.dart';
import 'package:frontend/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class OrderController {

  // place order
  uploadOrder({
    required String fullname,
    required String email,
    required String state,
    required String city,
    required String locality,
    required String productName,
    required String productId,
    required int productQuantity,
    required int quantity,
    required int productPrice,
    required String category,
    required String image,
    required String buyerId,
    required String vendorId,
    required bool processing,
    required bool delivered,
    required context,
  }) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('auth-token');

      Order order = Order(
        id: '',
        fullname: fullname,
        email: email,
        state: state,
        city: city,
        locality: locality,
        productName: productName,
        productId: productId ,
        productQuantity: productQuantity,
        quantity: quantity,
        productPrice: productPrice,
        category: category,
        image: image,
        buyerId: buyerId,
        vendorId: vendorId,
        processing: processing,
        delivered: delivered,
      );

      http.Response response = await http.post(
        Uri.parse('$uri/api/order'),
        body: order.toJson(),
        headers: <String,String>{
          "Content-Type":"application/json; charset=UTF-8",
          'x-auth-token':token!
        }
      );

      httpErrorHandle(response: response, context: context, onSuccess: (){
        showSnackBar(context, "Order placed successfully");
      });

    } catch (e) {
      print(e.toString());
      showSnackBar(context, "Order is not placed");
    }
  }


  // load order

  Future<List<Order>> loadOrders({
    required String buyerId,
    required context
})async{
    try{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('auth-token');
      http.Response response = await http.get(
          Uri.parse('$uri/api/order/$buyerId'),
        headers: <String,String>{
            'Content-Type':'application/json; charset=UTF-8',
            'x-auth-token':token!
        }
      );

      if(response.statusCode==200){
        List<dynamic> data = jsonDecode(response.body);
        List<Order> orders = data.map((order)=>Order.fromJson(order)).toList();
        return orders;
      }
      else{
        throw Exception("Failed to load orders");
      }

    }
    catch(e){
      throw Exception(e.toString());
    }
  }

  // delete order
  Future<void> deleteOrder(String orderId,context) async{
    try{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('auth-token');
      http.Response response = await http.delete(
          Uri.parse('$uri/api/order/delete/$orderId'),
        headers: <String,String>{
            'Content-Type':'application/json; charset=UTF-8',
            'x-auth-token':token!
        }
      );

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: (){
            showSnackBar(
                context, "Order is deleted successfully"
            );
          }
      );
    }
    catch(e){
      print(e);
      showSnackBar(context, e.toString());
    }
  }

  // method for counting the number of product which are delivered
  Future<int> countDeliveredOrder({required String buyerId,required context})async{
    try{
      // first we will get all the order so that then we can count the number of delivered products.
      final List<Order> orders = await loadOrders(buyerId: buyerId, context: context);
      // now we will filter the delivered products and count them.
      int deliveredProducts = orders.where((order)=>order.delivered).length;
      return deliveredProducts;
    }
    catch(e){
      throw Exception("Error during counting delivered products");
    }
  }

  /*
  // route for order payment
  Future<Map<String,dynamic>> createPaymentIntent({
    required int amount,
    required String currency,
  })async{
    try{
      SharedPreferences preferences =await SharedPreferences.getInstance();
      final token = preferences.getString('auth-token');
      http.Response response = await http.post(
          Uri.parse('$uri/api/payment'),
          body: jsonEncode({
            'amount':amount,
            'currency':currency,
          }),
          headers: <String,String>{
            'Content-Type':'application/json; charset=UTF-8',
            'x-auth-token':token!
          }
      );

      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        return data;
      } else{
        return {
          "Something went wrong":response.statusCode
        };
      }
    }catch(e){
      return {
        "Error occurred during payment":e.toString()
      };
    }
  }
  */

}

