import 'package:frontend/model/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubCategoryProductProvider extends StateNotifier<List<Product>>{
  SubCategoryProductProvider():super([]);



  void setSubCategoryProducts(List<Product> products)async{
    state = products;
  }


}

final subCategoryProductProvider = StateNotifierProvider<SubCategoryProductProvider,List<Product>>((ref)=>SubCategoryProductProvider());
