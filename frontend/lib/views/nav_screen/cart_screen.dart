import 'package:frontend/provider/cartProvider.dart';
import 'package:frontend/views/screens/details/screens/checkout_screen.dart';
import 'package:frontend/views/screens/main_screen.dart';
import 'package:frontend/views/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/cart_widget.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {


  @override
  Widget build(BuildContext context) {
    final cartData = ref.watch(cartProvider);
    final _cartProvider = ref.read(cartProvider.notifier);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.15),
          child: HeaderWidget2()
      ),
      body: _cartProvider.getCartItems.isEmpty ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Your cart is empty,\nClick on (Shop Now) to shop.",textAlign: TextAlign.center,style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.bold),),
            TextButton(onPressed: (){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MainScreen()), (route)=>false);
            }, child: Text("Shop Now",style: GoogleFonts.quando(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),)
            )
          ],
        ) ,
      ) : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text("My Cart",style: GoogleFonts.marcellusSc(fontSize: 28,fontWeight: FontWeight.bold),)),
          TextButton(
              onPressed: (){
                _cartProvider.clearCart();
              },
              child: Text('Clear The Cart',style: GoogleFonts.montserrat(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red),)
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartData.values.toList().length,
                itemBuilder: (context,index){
                  final cartItem = cartData.values.toList()[index];
                  return CartWidget(
                      cartItem: cartItem,
                    onDecrement: (){
                      _cartProvider.decrementQuantity(cartItem.productId,context);
                    }  ,
                    onIncrement: (){
                      _cartProvider.incrementQuantity(cartItem.productId);
                    },
                    deleteItem: (context){
                      _cartProvider.removeProduct(cartItem.productId);
                    },
                  );
                }
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        height: 85,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text("Total Amount : ${_cartProvider.calculateTotalAmount().toStringAsFixed(2)}",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.bold),),
                Text("Delivery Charges : 0",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.bold),),
              ],
            ),
            InkWell(
              onTap: _cartProvider.calculateTotalAmount() == 0.0 ? null : (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckoutScreen()));
              },
              child: Container(
                height: 82,
                decoration: BoxDecoration(
                  color: _cartProvider.calculateTotalAmount() == 0.0 ? Colors.grey.shade400 : Colors.blueAccent,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Checkout",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_forward,color: Colors.white,),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

