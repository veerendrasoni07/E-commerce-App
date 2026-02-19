import 'dart:convert';

import 'package:frontend/model/favourite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteNotifier extends StateNotifier<Map<String,Favourite>>{
  FavouriteNotifier():super({}){
    _loadFavouriteItem();
  }


  // A private method that load favourite item or data from the shared preferences
  Future<void> _loadFavouriteItem()async{
    // making an instance of shared preference to get the data afterwards
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    // we are fetching the data from the shared preferences
    final favouriteJson = preferences.getString('favourite');
    // checking if the data in not null, meaning there is saved data to load.
    if(favouriteJson!=null){
      // now the data is in json so we have to first convert it into map of dynamic data which dart can understand.
      final Map<String,dynamic> favouriteMap = jsonDecode(favouriteJson);
      // now we have to convert the dynamic map into map of favourite object using the "fromMap" method of factory constructor
      final Map<String,Favourite> favourites = favouriteMap.map((key,value)=>MapEntry(key, Favourite.fromJson(value)));
      // updating the state with the loaded data
      state = favourites;
    }

  }

  //A private method to save the current list of favourite items in shared preferences
    Future<void> _saveFavouriteItem()async{
      // making the instance of shared preferences
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      // if we have to store the data in shared preferences then we need to convert the map into json string , because
      //  shared preferences only store the json string
      final favouriteJson = jsonEncode(state);
      // now store that json string in shared preferences
      await preferences.setString('favourite', favouriteJson);
    }


  void addToFavourite({
    required String productName,
    required int productPrice,
    required String category,
    required String vendorId,
    required List<String> images,
    required String productId,
    required String description,
    required int productQuantity,
    required String fullname
})async {
    state[productId] = Favourite(
        productName: productName,
        productPrice: productPrice,
        category: category,
        vendorId: vendorId,
        images: images,
        productId: productId,
        description: description,
        productQuantity: productQuantity,
        fullname: fullname
    );
    // notify listeners that state has changed
    state = {...state};
    // calling the private method to save the data in shared preference
    _saveFavouriteItem();
  }

  // method to remove the product from the favourites.
  void removeFavouriteProduct(String productId){
    state.remove(productId);
    state = {...state};
    // calling the private method to save the data in shared preference
    _saveFavouriteItem();
  }

  Map<String,Favourite> get getFavouriteItem => state;

}

final favouriteProvider = StateNotifierProvider<FavouriteNotifier,Map<String,Favourite>>((ref)=>FavouriteNotifier());
