import 'package:frontend/model/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopRatedProvider  extends StateNotifier<List<Product>>{
   TopRatedProvider():super([]);

   void setTopRatedProduct(List<Product> product){
     state = product;
   }


}
final topRatedProvider = StateNotifierProvider<TopRatedProvider,List<Product>>((ref)=>TopRatedProvider());
