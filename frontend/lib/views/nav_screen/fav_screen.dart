import 'package:frontend/provider/favourite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class FavScreen extends ConsumerStatefulWidget {
  const FavScreen({super.key});

  @override
  ConsumerState<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends ConsumerState<FavScreen> {

  @override
  Widget build(BuildContext context) {
    final favourite = ref.watch(favouriteProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favourite Screen",
          style: GoogleFonts.marcellusSc(
            textStyle: TextStyle(color: Colors.black),
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
            fontSize: 30
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: favourite.length,
          itemBuilder: (context,index){
          final favItem = favourite.values.toList()[index];
            return Slidable(
              endActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    borderRadius: BorderRadius.circular(20),
                    flex: 5,
                    onPressed: (context){
                      ref.read(favouriteProvider.notifier).removeFavouriteProduct(favItem.productId);
                    },
                    icon: Icons.delete,
                    label: "Delete",
                  )
                ],

              ),
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                elevation: 5,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              favItem.images[0],
                              height: 150,
                              width: 150,
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              favItem.productName,
                              style: GoogleFonts.quicksand(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "\u{20B9}${favItem.productPrice}",
                              style: GoogleFonts.quicksand(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              )
                            ),
                            Text(
                              favItem.category,
                              style: GoogleFonts.quicksand(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700
                              )
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}

