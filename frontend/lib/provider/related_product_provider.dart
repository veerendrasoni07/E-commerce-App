import 'package:frontend/model/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RelatedProductProvider extends StateNotifier<List<Product>>{
  RelatedProductProvider():super([]);


  void setRelatedProduct(List<Product> products){
    state = products;
  }

}

final relatedProductProvider = StateNotifierProvider<RelatedProductProvider,List<Product>>((ref)=>RelatedProductProvider());
