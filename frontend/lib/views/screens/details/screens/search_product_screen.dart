import 'package:frontend/controller/product_controller.dart';
import 'package:frontend/model/product.dart';
import 'package:frontend/views/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    const backgroundColor = Color(0xffeaeaea);
    return Scaffold(
      backgroundColor:backgroundColor,
        appBar:  AppBar(
          backgroundColor: Color(0xff0f4c81),
      toolbarHeight:80,
      leading: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.white,)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(28),)
        ,),
          title: TextField(
            controller: searchController,
            textInputAction: TextInputAction.search,
            onSubmitted: (value){
              if(value.isNotEmpty) {
                searchProduct(value);
              }
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
                  if(searchController.text.isNotEmpty) {
                    searchProduct(searchController.text);
                  }
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
          AnimatedSwitcher(
                duration: Duration(milliseconds: 350),
                child: searchedProducts.isEmpty ? Center(child: Text("No Products Found",style: GoogleFonts.montserrat(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey),),): Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                        mainAxisExtent: MediaQuery.of(context).size.height * 0.35,
                          mainAxisSpacing: 4,
                        crossAxisSpacing: 4
                      ),
                      shrinkWrap: true,
                      itemCount: searchedProducts.length,
                      itemBuilder: (context,index){
                        final product = searchedProducts[index];
                        return ModernProductTile(product: product);
                      }
                  ),
                ),
              ),
            
          ]
        ),
      ),
    );
  }
}

