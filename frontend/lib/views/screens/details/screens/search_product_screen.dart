import 'package:frontend/controller/product_controller.dart';
import 'package:frontend/model/product.dart';
import 'package:frontend/views/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({super.key});

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextEditingController searchController = TextEditingController();
  List<Product> searchedProducts = [];

  Future<void> searchProduct(String query)async{
    try{
      final ProductController productController = ProductController();
      List<Product> products = await productController.searchProduct(query);
      setState(() {
        searchedProducts = products;
      });
    }catch(e){
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth < 600 ? 2 : 4;
    final childAspectRatio = screenWidth < 600 ? 3/4.5 : 4/5;
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: "Search Here...",
            filled: true,
            fillColor: Colors.grey.shade400,
            contentPadding: EdgeInsets.all(10),
            hintStyle: TextStyle(color: Colors.black),
            prefixIcon: Icon(Icons.camera_alt, color: Colors.black),
            suffixIcon: InkWell(onTap:()=>searchProduct(searchController.text.trim()),child: Icon(Icons.search, color: Colors.black)),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black, width: 2), // optional: make it thicker on focus
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white),
            ),
            enabled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black, width: 2), // optional: make it thicker on focus
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          style: TextStyle(color: Colors.black), // make typed text white too
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                  childAspectRatio: childAspectRatio,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8
                ),
                shrinkWrap: true,
                itemCount: searchedProducts.length,
                itemBuilder: (context,index){
                  final product = searchedProducts[index];
                  return ProductItemWidget(
                      product: product
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}

