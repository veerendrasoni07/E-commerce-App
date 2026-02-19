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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 20),
        child: InnerHeaderWidget(onTap: (){},controller:controller ,),
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
            ReuseableTextWidget(title: "Popular Product", subtitle: 'view all'),

                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: products.length,
                          itemBuilder: (context,index){
                            final product = products[index];
                            return ProductItemWidget(product: product);
                          }
                      ),
                    )

          ],
        ),
      ),
    );
  }
}

