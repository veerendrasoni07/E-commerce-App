import 'package:frontend/controller/category_controller.dart';
import 'package:frontend/controller/subcategory_controller.dart';
import 'package:frontend/model/catergory.dart';
import 'package:frontend/model/subcategory.dart';
import 'package:frontend/provider/categoryProvider.dart';
import 'package:frontend/provider/subcategory_provider.dart';
import 'package:frontend/views/screens/details/screens/widgets/inner_subcategory_product_screen.dart';
import 'package:frontend/views/screens/details/screens/widgets/inner_subcategory_tile.dart';
import 'package:frontend/views/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/details/screens/search_product_screen.dart';


class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {


  late Future<List<Category>> futureCategory;
  Category? selectedcategory;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCategory();
  }

  Future<void> loadCategory()async{
    CategoryController categoryController = CategoryController();
    List<Category> categories = await categoryController.loadCategory();
    ref.read(categoryProvider.notifier).setCategory(categories);

    // set the default selected category (e.g) "Fashion".
    for(var category in categories){
      if(category.name == "Fashion"){
        setState(() {
          selectedcategory = category;
        });
        // load the subcategories for the default category
        fetchSubCategory(category.name);
      }
    }
  }

  Future<void> fetchSubCategory(String categoryName)async{
    SubcategoryController subcategoryController = SubcategoryController();
    List<SubCategory> subcategories = await subcategoryController.loadSubCategory(categoryName);
    ref.read(subCategoryProvider.notifier).setSubCategory(subcategories);
  }


  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);
    final subcategories = ref.watch(subCategoryProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0f4c81),
        toolbarHeight:80,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(28),)
          ,),
        title: TextField(
         readOnly: true,
          textInputAction: TextInputAction.search,
          onTap: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchProductScreen()));
          },
          decoration: InputDecoration(
            hintText: 'Search products, brands and categories',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none
            ),
            hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 14,
            ),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Container(
              margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xff0f4c81),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.camera_alt,
                size: 20,
                color: Colors.white,
              ),
            ),
            suffixIcon:IconButton(
              onPressed: (){

              },
              icon: const Icon(
                Icons.search_rounded,
                color: Color(0xff0f4c81),
              ),
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.support_agent_rounded,color: Colors.white,))
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // left side screen
          Expanded(
            flex: 2,
            child:
                   ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return ListTile(
                        onTap: () {
                          setState(() {
                            selectedcategory = category;
                          });
                          fetchSubCategory(category.name);
                        },
                        title: Text(
                          category.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color:
                                selectedcategory == category
                                    ? Colors.blueAccent
                                    : Colors.black,
                          ),
                        ),
                      );
                    },
                  )

          ),

          // right side screen
          Expanded(
            flex: 4,
            child:
                selectedcategory != null
                    ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              selectedcategory!.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: NetworkImage(selectedcategory!.banner),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                      
                          subcategories.isNotEmpty
                              ? GridView.builder(
                                shrinkWrap: true,
                                itemCount: subcategories.length,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 4,
                                      crossAxisSpacing: 8,
                                      childAspectRatio: 2/3
                                    ),
                                itemBuilder: (context, index) {
                                  final subcategory = subcategories[index];
                                  return GestureDetector(
                                    onTap: ()=>Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context)=>InnerSubcategoryProductScreen(
                                                subCategory: subcategory
                                            )
                                        )
                                    ),
                                    child: InnerSubCategoryTile(
                                      image: subcategory.image,
                                      title: subcategory.subcategoryName,
                                    ),
                                  );
                                },
                              )
                              : Center(
                                child: Text(
                                  "No Categories are there!",
                                  style: TextStyle(
                                    letterSpacing: 3,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                        ],
                      ),
                    )
                    : Container(),
          ),
        ],
      ),
    );
  }
}

