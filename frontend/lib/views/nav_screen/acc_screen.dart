import 'package:frontend/controller/auth_controller.dart';
import 'package:frontend/provider/cartProvider.dart';
import 'package:frontend/provider/delivered_order_count_provider.dart';
import 'package:frontend/provider/favourite.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/views/widgets/order_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class AccScreen extends ConsumerWidget {
  AccScreen({super.key});
  final AuthService authController = AuthService();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userProvider)!;
    final cartData = ref.read(cartProvider);
    final favouriteData = ref.read(favouriteProvider);
    final size = MediaQuery.of(context).size;
    final AuthService authService = AuthService();
    String totalCart = cartData.length.toString();
    String totalFavourite = favouriteData.length.toString();
    // fetch the delivered order count when the widget rebuilds
    ref.read(deliverdOrderCountProvider.notifier).fetchDeliveredOrderCount(user.id, context);
    // watch the deliverOrderProvider to reactively rebuild when the state changes.
    final deliveredOrderCount = ref.watch(deliverdOrderCountProvider.notifier);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Background with curved image
                Container(
                  height: 350,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(80),
                      bottomRight: Radius.circular(80),
                    ),
                    image: DecorationImage(
                      image: AssetImage("assets/images/profile_background.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),

                      CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.white,
                        child: Text(
                          user.fullname[0],
                          style: GoogleFonts.montserrat(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Text(
                        user.fullname,
                        style: GoogleFonts.montserrat(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.email,
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                        ),

                      ),
                    ],
                  ),
                ),
                // Profile picture - overlaps background
                // White floating card

              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black12,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      // Icons Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:  [
                          _ProfileIcon(icon: Icons.shopping_cart, label: 'Cart',value:totalCart ,color: Colors.blueAccent,),
                          _ProfileIcon(icon: Icons.favorite_rounded, label: 'Favourite',value:totalFavourite,color: Colors.pink,),
                          _ProfileIcon(icon: Icons.done_all, label: 'Completed',value:  deliveredOrderCount.deliveredCount.toString(),color: Colors.green,),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Profile Info Rows
                      ListTile(
                        leading: Icon(Icons.auto_graph),
                        title: Text("Track you Order"),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderScreenWidget()));
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.history),
                        title: Text("History"),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderScreenWidget()));
                        },
                      ),

                      ListTile(
                        leading: Icon(Icons.logout),
                        title: Text("Logout"),
                        onTap: (){
                          authService.signOut(context, ref);
                        },
                      ),

                      const SizedBox(height: 20),

                      // Edit Profile Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Edit Profile',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
            ),

            const SizedBox(height: 600), // For scroll space
          ],
        ),
      ),
    );
  }
}

class _ProfileIcon extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;
  const _ProfileIcon({required this.icon, required this.label,required this.value,required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          radius: 25,
          child: Icon(icon, color:color),
        ),
        const SizedBox(height: 5),
        Text(value,style: GoogleFonts.montserrat(fontSize: 12,fontWeight: FontWeight.bold),),
        Text(label, style: GoogleFonts.montserrat(fontSize: 12,fontWeight: FontWeight.bold),),
      ],
    );
  }
}


