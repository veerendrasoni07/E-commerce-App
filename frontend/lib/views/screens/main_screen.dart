import 'package:frontend/views/nav_screen/cart_screen.dart';
import 'package:frontend/views/nav_screen/category_screen.dart';
import 'package:frontend/views/nav_screen/demo_home_screen.dart';
import 'package:frontend/views/nav_screen/fav_screen.dart';
import 'package:frontend/views/nav_screen/store_screen.dart';
import 'package:flutter/material.dart';


import '../nav_screen/acc_screen.dart';
import '../nav_screen/home_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedpage = 0;
  List<Widget> pages = [
    HomeScreen(),
    FavScreen(),
    CategoryScreen(),
    CartScreen(),
    AccScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedpage],

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedpage,
        onTap: (value) {
          setState(() {
            _selectedpage = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favourite",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Category",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_rounded),
            label: "Account",
          ),
        ],
      ),
    );
  }
}

