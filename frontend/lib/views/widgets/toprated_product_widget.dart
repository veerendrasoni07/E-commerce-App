import 'package:frontend/controller/product_controller.dart';
import 'package:frontend/provider/toprated_provider.dart';
import 'package:frontend/views/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopratedProductWidget extends ConsumerStatefulWidget {
  const TopratedProductWidget({super.key});

  @override
  ConsumerState<TopratedProductWidget> createState() => _TopratedProductWidgetState();
}

class _TopratedProductWidgetState extends ConsumerState<TopratedProductWidget> {

  void _fetchTopRatedProduct()async{
    final ProductController productController = ProductController();
    final topRatedProducts = await productController.loadTopRatedProduct();
    ref.read(topRatedProvider.notifier).setTopRatedProduct(topRatedProducts);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchTopRatedProduct();
  }

  @override
  Widget build(BuildContext context) {
    final topRatedProducts = ref.watch(topRatedProvider);
    return SizedBox(
      height: 300,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: topRatedProducts.length,
          itemBuilder: (context,index){
            final product = topRatedProducts[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ModernProductTile(product: product),
              ],
            );
          }
      ),
    );
  }
}

