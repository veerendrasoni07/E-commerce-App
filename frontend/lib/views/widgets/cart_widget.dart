import 'package:frontend/model/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';


class CartWidget extends StatelessWidget {
  final Cart cartItem;
  final bool isOrder;
  void Function()? onDecrement;
  void Function()? onIncrement;
  void Function(BuildContext)? deleteItem;
  CartWidget({super.key,required this.cartItem,required this.onDecrement,required this.onIncrement,required this.deleteItem,required this.isOrder});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.4,
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              flex: 5,
              onPressed: deleteItem,
              icon: Icons.delete,
              label: "Delete" ,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(20),
              autoClose: true,
              spacing:4,
            )
          ]
      ),
      child: Card(
        borderOnForeground: true,
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  cartItem.images[0],
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cartItem.productName,style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.bold),),
                      Text("\u{20B9}${cartItem.productPrice}",style: GoogleFonts.roboto(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black87),),
                      Text(cartItem.category,style: GoogleFonts.roboto(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey.shade600),),
                      Row(
                        children: [
                          IconButton(onPressed: onDecrement, icon: Icon(Icons.remove_circle_outline,color: Colors.black87,)),
                          Text(cartItem.quantity.toString(),style: GoogleFonts.roboto(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black87),),
                          IconButton(onPressed: onIncrement, icon: Icon(Icons.add_circle_outline,color: Colors.black87,)),
                        ],
                      ),
                      if(isOrder)
                        Text("Order Placed",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.green),)

                    ],
                  ),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
}

