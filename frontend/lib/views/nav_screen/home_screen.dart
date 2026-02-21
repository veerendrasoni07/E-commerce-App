import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/views/screens/details/screens/search_product_screen.dart';
import 'package:frontend/views/widgets/banner_widget.dart';
import 'package:frontend/views/widgets/category_widget.dart';
import 'package:frontend/views/widgets/popular_product_widget.dart';
import 'package:frontend/views/widgets/reuseable_text_widget.dart';
import 'package:frontend/views/widgets/toprated_product_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const backgroundColor = Color(0xfff4f6fb);
    const headerColor = Color(0xff0f4c81);
    final topSafeArea = MediaQuery.of(context).padding.top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: headerColor,
        systemNavigationBarColor: headerColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: CustomScrollView(
          // physics: const BouncingScrollPhysics(),
          slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.fromLTRB(16, topSafeArea + 10, 16, 22),
              decoration: const BoxDecoration(
                color: Color(0xff1f6aa5),
                // gradient: LinearGradient(
                //   colors: [Color(0xff0f4c81), Color(0xff1f6aa5)],
                //   begin: Alignment.topLeft,
                //   end: Alignment.bottomRight,
                // ),
                // borderRadius: BorderRadius.only(
                //   bottomLeft: Radius.circular(28),
                //   bottomRight: Radius.circular(28),
                // ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Deliver to Home',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      _HeaderIconButton(
                        icon: Icons.notifications_none_rounded,
                        onTap: () {},
                      ),
                      const SizedBox(width: 10),
                      _HeaderIconButton(
                        icon: Icons.shopping_bag_outlined,
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
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
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SearchBarHeaderDelegate(
              topInset: topSafeArea,
              backgroundColor: Color(0xff1f6aa5),
              child: Container(
                color: Color(0xff1f6aa5),
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color:  Color(0xff1f6aa5),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: TextField(
                    readOnly: true,
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchProductScreen()));
                    },
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: 'Search products, brands and categories',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 14,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Container(
                        margin: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Color(0xff1f6aa5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                      suffixIcon:const Icon(
                        Icons.search_rounded,
                        color: Color(0xff1f6aa5)
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 6)),
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
                onTap: (){},
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
                onTap: (){},
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
      ),
    );
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
