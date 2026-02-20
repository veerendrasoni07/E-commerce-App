import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:frontend/controller/product_controller.dart';
import 'package:frontend/model/product.dart';
import 'package:frontend/provider/cartProvider.dart';
import 'package:frontend/provider/favourite.dart';
import 'package:frontend/provider/related_product_provider.dart';
import 'package:frontend/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../widgets/product_item_widget.dart' ;


class ProductDetailsScreen extends ConsumerStatefulWidget {
  final Product product;
  const ProductDetailsScreen({super.key,required this.product});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchRelatedProduct();
  }

  PageController controller = PageController();

  void _fetchRelatedProduct()async{
    final ProductController productController = ProductController();
    final relatedProducts = await productController.loadSimilarProduct(widget.product.id);
    ref.read(relatedProductProvider.notifier).setRelatedProduct(relatedProducts);
  }



  @override
  Widget build(BuildContext context) {
    final cart = ref.read(cartProvider.notifier);
    final cartProviderData = ref.watch(cartProvider);
    final favourite = ref.watch(favouriteProvider.notifier);
    ref.watch(favouriteProvider);
    final isInCart = cartProviderData.containsKey(widget.product.id);
    final isInWishList = favourite.getFavouriteItem.containsKey(widget.product.id);
    final relatedProduct = ref.watch(relatedProductProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details",
          style: GoogleFonts.montserrat(
              textStyle: TextStyle(color: Colors.black),
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
            fontSize: 26
          ),
        ),
        actions: [
          IconButton(
              onPressed: (){
                if(isInWishList){
                  favourite.removeFavouriteProduct(widget.product.id);
                  showSnackBar(context, "Removed From The Wishlist");
                }
                else{
                  favourite.addToFavourite(
                      productName: widget.product.productName,
                      productPrice: widget.product.productPrice,
                      category: widget.product.category,
                      vendorId: widget.product.vendorId,
                      images: widget.product.images,
                      productId: widget.product.id,
                      description: widget.product.description,
                      productQuantity: widget.product.productQuantity,
                      fullname: widget.product.fullname,
                      subcategory: widget.product.subcategory,
                      popular: widget.product.popular,
                      recommend: widget.product.recommend,
                      totalrating: widget.product.totalrating
                      ,averagerating: widget.product.averagerating
                  );
                  showSnackBar(context, "Added To Wishlist");
                }

              },
              icon: favourite.getFavouriteItem.containsKey(widget.product.id) ? Icon(
                Icons.favorite,
                color: Colors.pink,
              ) : Icon(Icons.favorite_border_outlined,color: Colors.black87,)
          ),
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 350,
                  width: 350,
                  decoration: BoxDecoration(),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 100,
                          child: Container(
                            height: 200,
                        width: 350,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent.shade100,
                          borderRadius: BorderRadius.circular(300)
                        ),
                      )),
                      Positioned(
                        top: 0,
                          left: 40,
                          right: 40,
                          child: Container(
                            height: 350,
                            width: 270,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: SizedBox(
                              height: 350,
                              child: PageView.builder(
                                controller: controller,
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.product.images.length,
                                  itemBuilder: (context,index){
                                    return ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.network(widget.product.images[index],fit: BoxFit.cover,));
                                  }
                              ),
                            ),
                          )
                      )
                    ],
                  ),
                ),
              ),
              Center(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: widget.product.images.length,
                  effect: JumpingDotEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    jumpScale: .7,
                    verticalOffset: 15, // 👈 This makes it jump vertically
                    activeDotColor: Colors.blueAccent,
                    dotColor: Colors.grey.shade400,
                  ),
                ),
              ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(widget.product.productName,style: GoogleFonts.montserrat(fontSize: 20,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
                       Text("₹${widget.product.productPrice}",style: GoogleFonts.montserrat(fontSize: 20,fontWeight: FontWeight.bold),),
                     ],
                   ),
                   if(widget.product.totalrating!=0)
                     Padding(
                       padding: const EdgeInsets.only(left: 8.0),
                       child: Row(
                         children: [
                           Icon(Icons.star,color: Colors.amber,),
                           Text(widget.product.averagerating.toStringAsFixed(1),style: GoogleFonts.montserrat(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey.shade600),),
                           Text('(${widget.product.totalrating.toString()})',style: GoogleFonts.montserrat(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey.shade600),)
                         ],
                       ),
                     ),
                   Text(widget.product.category,style: GoogleFonts.quicksand(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey.shade600),),
                   SingleChildScrollView(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text("About",style: GoogleFonts.montserrat(fontSize: 20,fontWeight: FontWeight.bold),),
                           Text(widget.product.description,style: GoogleFonts.quicksand(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey.shade600),)
                         ],
                     ),
                   ),
                   Text("Related Products",style: GoogleFonts.montserrat(fontSize: 20,fontWeight: FontWeight.bold),),
                   if(relatedProduct.isNotEmpty)
                     SizedBox(
                       height: MediaQuery.of(context).size.height * 0.35,
                       child: ListView.builder(
                           scrollDirection: Axis.horizontal,
                           shrinkWrap: true,
                           itemCount: relatedProduct.length,
                           itemBuilder: (context,index){
                             final product = relatedProduct[index];
                             return ModernProductTile(
                                 product: product
                             );
                           }
                       ),
                     ),

                   SizedBox(height: 100,)
                 ],
               ),
             )




            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 20),
        child: InkWell(
          onTap: isInCart ? () {} : (){
            cart.addToCart(
                productName: widget.product.productName,
                productPrice: widget.product.productPrice,
                category: widget.product.category,
                vendorId: widget.product.vendorId,
                images: widget.product.images,
                productId: widget.product.id,
                description: widget.product.description,
                productQuantity: widget.product.productQuantity,
                quantity: 0,
                fullname: widget.product.fullname
            );
            final snackBar = SnackBar(
              elevation: 0,
                backgroundColor: Colors.transparent,
                behavior: SnackBarBehavior.floating,
                content: AwesomeSnackbarContent(
                    title: "Congratulation",
                    message: "Successfully Added To Cart!",
                    contentType: ContentType.success
                ),
            );
            ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: isInCart ? Colors.grey : Colors.blueAccent,
                borderRadius: BorderRadius.circular(20)
            ),
            child:Center(
              child: Text("Add To Cart",style: GoogleFonts.mochiyPopOne(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
            ),
          ),
        ),
      ),
    );
  }
}

