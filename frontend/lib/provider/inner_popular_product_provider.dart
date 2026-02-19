import 'package:frontend/model/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InnerPopularProductProvider extends StateNotifier<List<Product>>{
  InnerPopularProductProvider():super([]);


  void setProducts (List<Product> products){
    state = products;
  }

}

final innerPopularProductProvider = StateNotifierProvider<InnerPopularProductProvider,List<Product>>((ref)=>InnerPopularProductProvider());
