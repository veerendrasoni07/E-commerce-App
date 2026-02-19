import 'package:frontend/model/subcategory.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubCategoryProvider extends StateNotifier<List<SubCategory>>{
  SubCategoryProvider():super([]);


  void setSubCategory(List<SubCategory> subCategories){
    state = subCategories;
  }

}
final subCategoryProvider = StateNotifierProvider<SubCategoryProvider,List<SubCategory>>((ref)=>SubCategoryProvider());
