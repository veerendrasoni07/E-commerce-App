
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/model/catergory.dart';

class CategoryProvider extends StateNotifier<List<Category>>{
  CategoryProvider():super([]);

  void setCategory(List<Category> category) async{
    state = category;
  }

}

final categoryProvider = StateNotifierProvider<CategoryProvider,List<Category>>((ref)=>CategoryProvider());