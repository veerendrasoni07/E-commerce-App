import 'package:frontend/controller/product_controller.dart';
import 'package:frontend/model/product.dart';
import 'package:frontend/model/subcategory.dart';
import 'package:frontend/provider/subcategory_product_provider.dart';
import 'package:frontend/utils/utils.dart';
import 'package:frontend/views/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InnerSubcategoryProductScreen extends ConsumerStatefulWidget {
  final SubCategory subCategory;
  const InnerSubcategoryProductScreen({super.key,required this.subCategory});

  @override
  ConsumerState<InnerSubcategoryProductScreen> createState() => _InnerSubcategoryProductScreenState();
}

class _InnerSubcategoryProductScreenState extends ConsumerState<InnerSubcategoryProductScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProductsBySubCategory(widget.subCategory);
  }
  Future<void> fetchProductsBySubCategory(SubCategory subcategory)async{
    try{
      final ProductController productController = ProductController();
      List<Product> products = await productController.loadProductBySubcategory(subcategory.subcategoryName);
      ref.read(subCategoryProductProvider.notifier).setSubCategoryProducts(products);
    }
    catch(e){
      showSnackBar(context, e.toString());
    }
  }




  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth < 600 ? 2 : 4;
    final childAspectRatio = screenWidth < 600 ? 3/5 : 4/5;
    final products = ref.watch(subCategoryProductProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subCategory.subcategoryName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          shrinkWrap: true,
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
              childAspectRatio: childAspectRatio,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8
            ),
            itemBuilder: (context,index){
            final product = products[index];
            return ProductItemWidget(product: product);
            }
        ),
      ),
    );
  }
}

