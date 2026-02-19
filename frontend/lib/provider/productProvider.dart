import 'package:frontend/model/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductProvider extends StateNotifier<List<Product>>{
  ProductProvider():super([]);

  void setProduct(List<Product> products){
    state = products;
  }

}

final productProvider = StateNotifierProvider<ProductProvider,List<Product>>((ref)=>ProductProvider());
