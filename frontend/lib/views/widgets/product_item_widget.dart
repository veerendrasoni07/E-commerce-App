import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:frontend/model/product.dart';
import 'package:frontend/provider/cartProvider.dart';
import 'package:frontend/provider/favourite.dart';
import 'package:frontend/utils/utils.dart';
import 'package:frontend/views/screens/details/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';


class ModernProductTile extends ConsumerWidget {
  final Product product ;
  const ModernProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _cartProvider = ref.watch(cartProvider.notifier);
    final favouriteState = ref.watch(favouriteProvider);
    final favouriteNotifier = ref.read(favouriteProvider.notifier);

    final isInWishList = favouriteState.containsKey(product.id);
    return  InkWell(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>ProductDetailsScreen(product: product)));
      },
      child: Card(
        elevation: 3,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(product.images[0],
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      )
                  ),
                  Positioned(
                      top: 10,
                      right: 5,
                      child: InkWell(
                          onTap: (){
                           if(isInWishList){
                             favouriteNotifier.removeFavouriteProduct(product.id);
                             showSnackBar(context, "Removed From The Wishlist");
                           }
                           else{
                             favouriteNotifier.addToFavourite(
                                 productName: product.productName,
                                 productPrice: product.productPrice,
                                 category: product.category,
                                 vendorId: product.vendorId,
                                 images: product.images,
                                 productId: product.id,
                                 description: product.description,
                                 productQuantity: product.productQuantity,
                                 fullname: product.fullname,
                                 subcategory: product.subcategory,
                                 popular: product.popular,
                                 recommend: product.recommend,
                                 totalrating: product.totalrating,
                                 averagerating: product.averagerating
                             );
                             showSnackBar(context, "Added To Wishlist");
                           }

                          },
                          child:isInWishList
                              ? Icon(Icons.favorite, color: Colors.pink)
                              : Icon(Icons.favorite_border_outlined, color: Colors.black87),
                      )
                  ),
                  Positioned(
                      bottom: 10,
                      right: 5,
                      child: InkWell(
                          onTap: (){
                            _cartProvider.addToCart(
                                productName: product.productName,
                                productPrice: product.productPrice,
                                category:product.category,
                                vendorId: product.vendorId,
                                images: product.images,
                                productId: product.id,
                                description: product.description,
                                productQuantity: product.productQuantity,
                                quantity: 1,
                                fullname: product.fullname
                            );
                            final snackBar = SnackBar(
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                    title: "Congratulations!",
                                    message: "Successfully Added to Cart",
                                    contentType: ContentType.success
                                ));
                            ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);

                          },
                          child: Icon(Icons.shopping_cart_outlined,color: Colors.black87,)
                      )
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Text(
                      product.productName,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  product.averagerating.toString() == '0.0' ? SizedBox() : Row(
                    children: [
                      Icon(Icons.star,color: Colors.amber,),
                      Text(product.averagerating.toStringAsFixed(1),style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black87),),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Text("\u{20B9}${product.productPrice}",style: GoogleFonts.roboto(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black87),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(product.category,style: GoogleFonts.roboto(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey.shade600),),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}

