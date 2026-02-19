
import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/model/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider extends StateNotifier<Map<String,Cart>>{

  CartProvider():super({}){
    _loadCartItems();
  }

  // creating a private method to load the saved data from the shared preferences
  Future<void> _loadCartItems()async{
    // first making instance of shared preference to get the data
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    // now we will store the data in variable
    final cartJson = await preferences.getString('cart_item');
    // checking that cartJson is not null, meaning there is saved data to load
    if(cartJson!=null){
      // now we are converting the json string into map of dynamic data so that dart can understand
      final Map<String,dynamic> cartMap = jsonDecode(cartJson);
      // now converting the map of dynamic data into map of cart object so that we can use it in our app
      final Map<String,Cart> cartItems = cartMap.map((key,value)=>MapEntry(key, Cart.fromJson(value)));
      // now we are updating the state with the loaded data.
      state = cartItems;
    }
  }

  // creating an private method to save the cart items or data in shared preference
  Future<void> _saveCartItems()async{
    // making the instance of shared preferences to save the data
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    // we have to encode the state data in json string so that we can store it on shared preferences
    final cartJson = jsonEncode(state);
    // now we have to store the cartJson in shared preferences
    await preferences.setString('cart_item', cartJson);
  }


  void addToCart({
    required String productName,
    required int productPrice,
    required String category,
    required String vendorId,
    required List<String> images,
    required String productId,
    required String description,
    required int productQuantity,
    required int quantity,
    required String fullname,
}){

    // if the product is already present in the cart.
    if(state.containsKey(productId)){
      state = {
        ...state,
        productId: Cart(
            productName: state[productId]!.productName,
            productPrice: state[productId]!.productPrice,
            category: state[productId]!.category,
            vendorId: state[productId]!.vendorId,
            images: state[productId]!.images,
            productId: state[productId]!.productId,
            description: state[productId]!.description,
            productQuantity: state[productId]!.productQuantity,
            quantity: state[productId]!.quantity + 1,
            fullname: state[productId]!.fullname,
        )
      };
      _saveCartItems();


    }
    // if the product is not present in the cart.
    else{
      state ={
        ...state,
        productId : Cart(
            productName: productName,
            productPrice: productPrice,
            category: category,
            vendorId: vendorId,
            images: images,
            productId: productId,
            description: description,
            productQuantity: productQuantity,
            quantity: 1,
            fullname: fullname
        )
      };
      _saveCartItems();
    }
  }


  // method to increment the product quantity in the cart.
  void incrementQuantity(String productId){
    if(state.containsKey(productId)){
      state[productId]!.quantity++;
      // notify listener that state has changed
      state = {...state};
    }
  }

  // method to decrement the product quantity in the cart.
  void decrementQuantity(String productId,context){
    if(state.containsKey(productId)){
      if(state[productId]!.quantity>0){
        state[productId]!.quantity--;
        // notify listener that state has changed
        state = {...state};
        _saveCartItems();
      }
      else{
        final snackBar = SnackBar(
          elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
                title: "Warning!",
                message: "You can't remove more items",
                contentType: ContentType.failure
            ));
        ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);
      }
    }
  }

  // method to remove product from the carts.
  void removeProduct(String productId){
    state.remove(productId);
    // notify listener that state has changed.
    state = {...state};
    _saveCartItems();
  }

  // method for calculating total amount of the cart.
  double calculateTotalAmount(){
    double totalAmount = 0.0;
    state.forEach((productId, cartItem){
      totalAmount += cartItem.quantity * cartItem.productPrice;
    });
    return totalAmount;
  }


  // clear the cart

  void clearCart (){
    state = {};
    // notify the listeners that state has changed
    state ={...state};
    _saveCartItems();
  }

  Map<String,Cart> get getCartItems => state;

}

final cartProvider = StateNotifierProvider<CartProvider,Map<String,Cart>>((ref)=>CartProvider());