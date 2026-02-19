import 'package:frontend/controller/order_controller.dart';
import 'package:frontend/provider/cartProvider.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/views/screens/details/screens/shipping_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_stripe/flutter_stripe.dart' hide Card;

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  String _selectedPaymentMethod = 'cashOnDelivery';
  final OrderController _orderController = OrderController();
  // bool isLoading = false;

  /*
  Future<void> handleStripePaymentIntent(BuildContext context) async {
    final cartData = ref.read(cartProvider);
    final user = ref.read(userProvider);
    if (user == null) {
      showSnackBar(context, "User information is missing");
      return;
    }
    if (cartData.isEmpty) {
      showSnackBar(context, "Cart is empty");
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });
      final totalAmount = cartData.values.fold(
        0.0,
        (sum, item) => sum += (item.productPrice * item.quantity),
      );
      final paymentIntent = await _orderController.createPaymentIntent(
        amount: (totalAmount * 100).toInt(),
        currency: 'usd',
      );
      Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: "Ur-Store",
          paymentIntentClientSecret: paymentIntent['client_secret'],
        ),
      );
      Stripe.instance.presentPaymentSheet();
      for (final item in cartData.entries) {
        _orderController.uploadOrder(
          fullname: item.value.fullname,
          email: user.email,
          state: user.state,
          city: user.city,
          locality: user.locality,
          productName: item.value.productName,
          productId: item.value.productId,
          productQuantity: item.value.productQuantity,
          quantity: item.value.quantity,
          productPrice: item.value.productPrice,
          category: item.value.category,
          image: item.value.images[0],
          buyerId: user.id,
          vendorId: item.value.vendorId,
          processing: true,
          delivered: false,
          context: context,
        );
      }
    } catch (e) {
      showSnackBar(context, "Error occurred:$e");
    } finally {
      isLoading = false;
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    final _cartProvider = ref.read(cartProvider);
    final _orderCart = ref.read(cartProvider.notifier);
    final user = ref.watch(userProvider);
    final isUserLocation =
        user!.city.isNotEmpty && user.state.isNotEmpty && user.locality.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Checkout Screen',
          style: GoogleFonts.marcellusSc(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShippingAddressScreen()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined,
                            color: Colors.blueAccent, size: 50),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isUserLocation
                                ? Text(
                                    'Your Address',
                                    style: GoogleFonts.poppins(
                                        fontSize: 18, fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    'Add Address',
                                    style: GoogleFonts.poppins(
                                        fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                            Text(
                              'State: ${user.state}',
                              style: GoogleFonts.roboto(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'City: ${user.city}',
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.note_alt_outlined,
                          color: Colors.blueAccent, size: 40),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _cartProvider.values.toList().length,
                itemBuilder: (context, index) {
                  final cartItem = _cartProvider.values.toList()[index];
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            cartItem.images[0],
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartItem.productName,
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                cartItem.category,
                                style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Text(
                                'Price',
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Rs ${cartItem.productPrice}',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Text(
                'Select Payment Method',
                style: GoogleFonts.montserrat(
                    fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1.7),
              ),
            ),
            const SizedBox(height: 5),
            /*
            RadioListTile<String>(
              title: Text(
                "Stripe",
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.3,
                ),
              ),
              value: "stripe",
              groupValue: _selectedPaymentMethod,
              onChanged: (String? value) {
                setState(() {
                  _selectedPaymentMethod = value!;
                });
              },
            ),
            */
            RadioListTile<String>(
              title: Text(
                'Cash On Delivery',
                style: GoogleFonts.montserrat(
                    fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.3),
              ),
              value: 'cashOnDelivery',
              groupValue: _selectedPaymentMethod,
              onChanged: (String? value) {
                setState(() {
                  _selectedPaymentMethod = value!;
                });
              },
            ),
          ],
        ),
      ),
      bottomSheet: ref.read(userProvider)!.state == ''
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Please Enter The Shipping Address',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            )
          : InkWell(
              onTap: () async {
                final user = ref.read(userProvider);
                /*
                if (_selectedPaymentMethod == 'stripe') {
                  handleStripePaymentIntent(context);
                  return;
                }
                */
                await Future.forEach(_orderCart.getCartItems.entries, (entry) {
                  var item = entry.value;
                  _orderController.uploadOrder(
                    fullname: user!.fullname,
                    email: user.email,
                    state: user.state,
                    city: user.city,
                    locality: user.locality,
                    productName: item.productName,
                    productId: item.productId,
                    productQuantity: item.productQuantity,
                    quantity: item.quantity,
                    productPrice: item.productPrice,
                    category: item.category,
                    image: item.images[0],
                    buyerId: user.id,
                    vendorId: item.vendorId,
                    processing: true,
                    delivered: false,
                    context: context,
                  );
                });
              },
              child: Container(
                height: 65,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blueAccent),
                child: Center(
                  /*
                  child: _selectedPaymentMethod == 'stripe'
                      ? Text(
                          "Pay Now",
                          style: GoogleFonts.montserrat(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          "Place Order",
                          style: GoogleFonts.montserrat(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                  */
                  child: Text(
                    'Place Order',
                    style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
    );
  }
}
