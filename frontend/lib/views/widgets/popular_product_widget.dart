import 'package:frontend/controller/product_controller.dart';
import 'package:frontend/provider/productProvider.dart';
import 'package:frontend/views/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class PopularProductWidget extends ConsumerStatefulWidget {
  const PopularProductWidget({super.key});

  @override
  ConsumerState<PopularProductWidget> createState() => _PopularProductWidgetState();
}

class _PopularProductWidgetState extends ConsumerState<PopularProductWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchProducts();
  }

  void _fetchProducts()async{
    final ProductController productController = ProductController();
    final products = await productController.loadProduct();
    ref.read(productProvider.notifier).setProduct(products);
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productProvider);
    return SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: products.length,
                  itemBuilder: (context,index){
                      final product = products[index];
                      return Column(
                        children: [
                          ProductItemWidget(product: product),
                        ],
                      );
                  }
              ),
            );

  }
}

