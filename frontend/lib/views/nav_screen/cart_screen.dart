import 'package:frontend/provider/cartProvider.dart';
import 'package:frontend/provider/orderProvider.dart';
import 'package:frontend/views/screens/details/screens/checkout_screen.dart';
import 'package:frontend/views/screens/main_screen.dart';
import 'package:frontend/views/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/details/screens/search_product_screen.dart';
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
    final order = ref.watch(orderProvider);

    final _cartProvider = ref.read(cartProvider.notifier);
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text("My Cart",style: GoogleFonts.poppins(fontSize: 28,fontWeight: FontWeight.bold),),
          ),
          TextButton(
              onPressed: (){
                _cartProvider.clearCart();
              },
              child: Text('Clear The Cart',style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.red),)
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartData.values.toList().length,
                itemBuilder: (context,index){
                  final cartItem = cartData.values.toList()[index];
                  final isOrder = order.where((element) => element.productId == cartItem.productId);
                  print("Is Orderrrrrr");
                  print(isOrder.isEmpty);
                  return CartWidget(
                    isOrder: isOrder.isNotEmpty,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Total Amount :  ₹${_cartProvider.calculateTotalAmount().toStringAsFixed(2)}",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.bold),),
                Text("Delivery Charges : 0",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.bold),),
              ],
            ),
            InkWell(
              onTap: _cartProvider.calculateTotalAmount() == 0.0 ? null : (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckoutScreen()));
              },
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: _cartProvider.calculateTotalAmount() == 0.0 ? Colors.grey.shade400 : Colors.blueAccent,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Checkout",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),),
                    ),
                    Icon(Icons.arrow_forward,color: Colors.white,)
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

