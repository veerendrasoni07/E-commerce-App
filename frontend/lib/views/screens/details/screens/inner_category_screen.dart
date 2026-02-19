import 'package:frontend/model/catergory.dart';
import 'package:frontend/views/nav_screen/acc_screen.dart';
import 'package:frontend/views/nav_screen/cart_screen.dart';
import 'package:frontend/views/nav_screen/category_screen.dart';
import 'package:frontend/views/nav_screen/fav_screen.dart';
import 'package:frontend/views/nav_screen/store_screen.dart';
import 'package:frontend/views/screens/details/screens/widgets/inner_subcategory_content_widget.dart';
import 'package:flutter/material.dart';

class InnerCategoryScreen extends StatefulWidget {
  final Category category;
  InnerCategoryScreen({super.key, required this.category});

  @override
  State<InnerCategoryScreen> createState() => _InnerCategoryScreenState();
}

class _InnerCategoryScreenState extends State<InnerCategoryScreen> {

  int _selectedpage = 0;
  

  @override
  Widget build(BuildContext context) {

    List<Widget> pages = [
    InnerSubcategoryContentWidget(category: widget.category,),
    FavScreen(),
    CategoryScreen(),
    StoreScreen(),
    CartScreen(),
    AccScreen(),
  ];

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
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "Store"),
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

