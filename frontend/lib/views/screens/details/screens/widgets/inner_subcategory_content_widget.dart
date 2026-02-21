import 'package:frontend/controller/product_controller.dart';
import 'package:frontend/controller/subcategory_controller.dart';
import 'package:frontend/model/catergory.dart';
import 'package:frontend/model/product.dart';
import 'package:frontend/model/subcategory.dart';
import 'package:frontend/provider/inner_popular_product_provider.dart';
import 'package:frontend/provider/subcategory_provider.dart';
import 'package:frontend/views/screens/details/screens/widgets/inner_banner_widget.dart';
import 'package:frontend/views/screens/details/screens/widgets/inner_header_widget.dart';
import 'package:frontend/views/screens/details/screens/widgets/inner_subcategory_product_screen.dart';
import 'package:frontend/views/screens/details/screens/widgets/inner_subcategory_tile.dart';
import 'package:frontend/views/widgets/product_item_widget.dart';
import 'package:frontend/views/widgets/reuseable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../search_product_screen.dart';

class InnerSubcategoryContentWidget extends ConsumerStatefulWidget {
  final Category category;
  const InnerSubcategoryContentWidget({super.key, required this.category});

  @override
  ConsumerState<InnerSubcategoryContentWidget> createState() => _InnerCategoryScreenState();
}

class _InnerCategoryScreenState extends ConsumerState<InnerSubcategoryContentWidget> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchSubCategory();
    _fetchProduct();
  }

  TextEditingController controller = TextEditingController();

  Future<void> _fetchProduct()async{
    final ProductController productController = ProductController();
    List<Product> products = await productController.loadProductByCategory(widget.category.name);
    ref.read(innerPopularProductProvider.notifier).setProducts(products);
  }
  Future<void> _fetchSubCategory()async{
    final SubcategoryController subcategoryController = SubcategoryController();
    List<SubCategory> subcategories = await subcategoryController.loadSubCategory(widget.category.name);
    ref.read(subCategoryProvider.notifier).setSubCategory(subcategories);
  }
  @override
  Widget build(BuildContext context) {
    final subcategories = ref.watch(subCategoryProvider);
    final products = ref.watch(innerPopularProductProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0f4c81),
        toolbarHeight:80,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(28),)
          ,),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white),
        ) ,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: InnerBannerWidget(image: widget.category.banner),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                    GridView.builder(
                        shrinkWrap: true,
                        itemCount: subcategories.length,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 3,
                          crossAxisSpacing: 2,
                        ),
                        itemBuilder: (context, index) {
                          final subcategory = subcategories[index];
                          return InkWell(
                            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>InnerSubcategoryProductScreen(subCategory: subcategory))),
                            child: InnerSubCategoryTile(
                              image: subcategory.image,
                              title: subcategory.subcategoryName,
                            ),
                          );
                        },
                      )

              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  ReuseableTextWidget(title: "Popular Product", subtitle: 'view all',onTap: (){},),

                          SizedBox(
                            height: MediaQuery.of(context).size.height*0.35,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: products.length,
                                itemBuilder: (context,index){
                                  final product = products[index];
                                  return ModernProductTile(product: product);
                                }
                            ),
                          ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}

