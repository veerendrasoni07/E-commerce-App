import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/details/screens/search_product_screen.dart';
import '../widgets/banner_widget.dart';
import '../widgets/category_widget.dart';
import '../widgets/popular_product_widget.dart';
import '../widgets/reuseable_text_widget.dart';
import '../widgets/toprated_product_widget.dart';

class DemoHomeScreen extends StatefulWidget {
  const DemoHomeScreen({super.key});

  @override
  State<DemoHomeScreen> createState() => _DemoHomeScreenState();
}

class _DemoHomeScreenState extends State<DemoHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100 ,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            toolbarHeight: 50,
            leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu,color: Colors.white,)),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(Icons.shopping_bag_outlined,color: Colors.white,)),
            ],
            expandedHeight: 250,
            centerTitle: true,
            title: Text('E-Commerce App',style: GoogleFonts.openSans(
              color: Colors.white70,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),),
            automaticallyImplyLeading: true,
            backgroundColor: Colors.teal.shade900 ,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                height: 60,
                width: MediaQuery.of(context).size.width *0.85,
                decoration: BoxDecoration(
                    color: Color(0xff0f4c81),
                    borderRadius: BorderRadius.circular(20)
                ),
                child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              // Row(
                              //   children: [
                              //     const Expanded(
                              //       child: Text(
                              //         'Deliver to Home',
                              //         style: TextStyle(
                              //           color: Colors.white70,
                              //           fontSize: 13,
                              //           fontWeight: FontWeight.w500,
                              //         ),
                              //       ),
                              //     ),
                              //     _HeaderIconButton(
                              //       icon: Icons.notifications_none_rounded,
                              //       onTap: () {},
                              //     ),
                              //     const SizedBox(width: 10),
                              //     _HeaderIconButton(
                              //       icon: Icons.shopping_bag_outlined,
                              //       onTap: () {},
                              //     ),
                              //   ],
                              // ),
                              const Text(
                                'Find Your Perfect\nStyle Today',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  height: 1.2,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Top brands, trending products, and deals made for you.',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13.5,
                                  height: 1.4,
                                ),
                              ),
                          Center(
                            child: SizedBox(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width *0.85,
                                  child: TextField(
                                    readOnly: true,
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchProductScreen()));
                                    },
                                    textInputAction: TextInputAction.search,
                                    decoration: InputDecoration(
                                      hintText: 'Search products, brands and categories',
                                      fillColor: Colors.white,
                                      hintStyle: GoogleFonts.lato(
                                        color: Colors.grey.shade500,
                                        fontSize: 10,
                                        height: 2
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide.none
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide.none
                                      ),
                                      filled: true,
                                      prefixIcon: Container(
                                        margin: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: const Color(0xff0f4c81),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: const Icon(
                                          Icons.camera_alt,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                      suffixIcon:const Icon(
                                        Icons.search_rounded,
                                        color: Color(0xff0f4c81),
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                          ),
                            ],
                          ),
                        ),
                      ) ,
                    ),
              ),
            ),
            // flexibleSpace: FlexibleSpaceBar(
            //   background: Container(
            //     height: 60,
            //     width: MediaQuery.of(context).size.width *0.85,
            //     decoration: BoxDecoration(
            //         color: Color(0xff0f4c81),
            //         borderRadius: BorderRadius.circular(16),
            //         boxShadow: [
            //           BoxShadow(
            //               color: Colors.black.withValues(alpha: 0.08),
            //               blurRadius: 10
            //           )
            //         ]
            //     ),
            //     child:SafeArea(
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               'E-Commerce App',
            //               style: GoogleFonts.openSans(
            //                 color: Colors.white70,
            //                 fontSize: 25,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //             Row(
            //               children: [
            //                 const Expanded(
            //                   child: Text(
            //                     'Deliver to Home',
            //                     style: TextStyle(
            //                       color: Colors.white70,
            //                       fontSize: 13,
            //                       fontWeight: FontWeight.w500,
            //                     ),
            //                   ),
            //                 ),
            //                 _HeaderIconButton(
            //                   icon: Icons.notifications_none_rounded,
            //                   onTap: () {},
            //                 ),
            //                 const SizedBox(width: 10),
            //                 _HeaderIconButton(
            //                   icon: Icons.shopping_bag_outlined,
            //                   onTap: () {},
            //                 ),
            //               ],
            //             ),
            //             const Text(
            //               'Find Your Perfect\nStyle Today',
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontSize: 28,
            //                 height: 1.2,
            //                 fontWeight: FontWeight.w700,
            //               ),
            //             ),
            //             const SizedBox(height: 8),
            //             const Text(
            //               'Top brands, trending products, and deals made for you.',
            //               style: TextStyle(
            //                 color: Colors.white70,
            //                 fontSize: 13.5,
            //                 height: 1.4,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ) ,
            //   ),
            //   title: SizedBox(
            //     height: 35,
            //     width: MediaQuery.of(context).size.width *0.55,
            //     child: TextField(
            //       readOnly: true,
            //       onTap: (){
            //         Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchProductScreen()));
            //       },
            //       textInputAction: TextInputAction.search,
            //       decoration: InputDecoration(
            //         hintText: 'Search products, brands and categories',
            //         fillColor: Colors.white,
            //         hintStyle: GoogleFonts.lato(
            //           color: Colors.grey.shade500,
            //           fontSize: 10,
            //           height: 2
            //         ),
            //         enabledBorder: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(20),
            //             borderSide: BorderSide.none
            //         ),
            //         focusedBorder: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(20),
            //             borderSide: BorderSide.none
            //         ),
            //         filled: true,
            //         prefixIcon: Container(
            //           margin: const EdgeInsets.all(6),
            //           decoration: BoxDecoration(
            //             color: const Color(0xff0f4c81),
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //           child: const Icon(
            //             Icons.camera_alt,
            //             size: 14,
            //             color: Colors.white,
            //           ),
            //         ),
            //         suffixIcon:const Icon(
            //           Icons.search_rounded,
            //           color: Color(0xff0f4c81),
            //         ),
            //         border: InputBorder.none,
            //       ),
            //     ),
            //   ),
            //   centerTitle: true,
            // ),
          // ),
          // SliverPersistentHeader(
          //     pinned: true,
          //   delegate: SearchBarHeaderDelegate(child: Container(
          //     color: Colors.white,
          //     padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
          //     child: Container(
          //       height: 60,
          //       decoration: BoxDecoration(
          //         color: Color(0xff0f4c81),
          //         borderRadius: BorderRadius.circular(16),
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.black.withValues(alpha: 0.08),
          //             blurRadius: 10
          //           )
          //         ]
          //       ),
          //       child: Text("data"),
          //     )
          //   ),backgroundColor: Colors.black,topInset: 50)
          // ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 12),
                  child: BannerWidget(),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: Container(
                padding: const EdgeInsets.only(top: 6, bottom: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const CategoryWidget(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: ReuseableTextWidget(
                title: 'Popular Products',
                subtitle: 'See All',
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: const PopularProductWidget(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: ReuseableTextWidget(
                title: 'Top Rated Products',
                subtitle: 'See All',
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: const TopratedProductWidget(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class SearchBarHeaderDelegate extends SliverPersistentHeaderDelegate {
  SearchBarHeaderDelegate({
    required this.child,
    required this.topInset,
    required this.backgroundColor,
});
  final Widget child;
  final double topInset;
  final Color backgroundColor;

  @override
  double get minExtent => topInset + 84;

  @override
  double get maxExtent => topInset + 84;

  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.only(top: topInset),
      child: child,
    );
  }
  @override
  bool shouldRebuild(covariant SearchBarHeaderDelegate oldDelegate) {
    return oldDelegate.child != child ||
        oldDelegate.topInset != topInset ||
        oldDelegate.backgroundColor != backgroundColor;
  }

}

class _SearchBarHeaderDelegate extends SliverPersistentHeaderDelegate {
  _SearchBarHeaderDelegate({
    required this.child,
    required this.topInset,
    required this.backgroundColor,
  });

  final Widget child;
  final double topInset;
  final Color backgroundColor;

  @override
  double get minExtent => topInset + 84;

  @override
  double get maxExtent => topInset + 84;

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.only(top: topInset),
      child: child,
    );

  }
  @override
  bool shouldRebuild(covariant _SearchBarHeaderDelegate oldDelegate) {
    return oldDelegate.child != child ||
        oldDelegate.topInset != topInset ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}


class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.16),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: SizedBox(
          width: 42,
          height: 42,
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}