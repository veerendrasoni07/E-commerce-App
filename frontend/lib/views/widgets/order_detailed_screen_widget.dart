import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:frontend/controller/review_rating_controller.dart';
import 'package:frontend/model/order.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetailedScreenWidget extends StatefulWidget {
  final Order order;
  const OrderDetailedScreenWidget({super.key,required this.order});

  @override
  State<OrderDetailedScreenWidget> createState() => _OrderDetailedScreenWidgetState();
}

class _OrderDetailedScreenWidgetState extends State<OrderDetailedScreenWidget> {

  final ReviewRatingController _reviewRatingController = ReviewRatingController();
  double rating = 0;
  TextEditingController textController = TextEditingController();

  void dialogBox()async{
    showDialog(
        context: context,
        builder: (context){
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RatingBar(
                      filledIcon: Icons.star,
                      filledColor: Colors.amber,
                      emptyIcon: Icons.star_border,
                      emptyColor: Colors.grey,
                      initialRating: 2,
                      maxRating: 5,
                      onRatingChanged: (value){
                        rating = value;
                      }
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    controller:textController ,
                    maxLines: 3,
                    maxLength: 200,
                    decoration: InputDecoration(
                      hintText: "Write a review",
                      hintStyle: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.black87)
                      )
                    ),
                  ),
                  ElevatedButton(onPressed: ()async{
                    await _reviewRatingController.uploadReviewAndRating(
                        buyerId: widget.order.buyerId,
                        email: widget.order.email,
                        fullname: widget.order.fullname,
                        productId: widget.order.productId,
                        rating: rating,
                        review: textController.text,
                        context: context
                    );
                    Navigator.pop(context);
                  }, child: Text("Submit")),
                ],
              ),
            ),
          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    print(widget.order.productId);
    return Scaffold(
      appBar: AppBar(
        title: Text("Order's Detail ",style: GoogleFonts.poppins(fontSize: 24,fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20,bottom: 15),
                  child: Column(
                    children: [
                      SizedBox(
                          height: 150,
                          width: 150,
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                widget.order.image,
                                fit: BoxFit.cover,
                                height: 100,
                                width: 100,
                              ),
                            ),
                          )
                      ),
                      Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                              color: widget.order.delivered == true ? Colors.green : Colors.redAccent,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(
                            child: Text(
                              widget.order.delivered == true ? 'Delivered' :
                              widget.order.processing == true ?
                              'Processing' :
                              'Cancelled',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white
                              ),
                            ),
                          )
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.order.productName,style: GoogleFonts.aBeeZee(fontSize: 18,fontWeight: FontWeight.bold),),
                      Text(widget.order.category,style: GoogleFonts.aBeeZee(fontSize: 18,fontWeight: FontWeight.bold),),
                      Text('₹${widget.order.productPrice}',style: GoogleFonts.aBeeZee(fontSize: 18,fontWeight: FontWeight.bold),),
                    ],
                  ),
                )
              ],
            ),
          ),

          Container(
            height: widget.order.delivered == true ? 210 : 170,
            width: MediaQuery.of(context).size.width,
            margin:EdgeInsets.symmetric(horizontal:15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade600),
              boxShadow: [
                BoxShadow(color: Colors.black87,blurRadius: 4,spreadRadius: 3),
                BoxShadow(color: Colors.white,blurRadius: 10,spreadRadius: 10,),
              ]
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Delivery Address",style: GoogleFonts.roboto(fontSize: 24,fontWeight: FontWeight.bold),),
                  Text('${widget.order.state}, ${widget.order.city}, ${widget.order.locality}' , style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey.shade600,),overflow: TextOverflow.ellipsis,),
                  Text("To: ${widget.order.fullname}",style: GoogleFonts.roboto(fontSize: 24,fontWeight: FontWeight.bold),),
                  Text("Order Id: ${widget.order.id}",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey.shade600,),overflow: TextOverflow.ellipsis),
                  Text("email: ${widget.order.email}",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey.shade600,),overflow: TextOverflow.ellipsis),
                  widget.order.delivered == true ? ElevatedButton(
                      onPressed: ()async{
                        dialogBox();
                      },
                      child: Text("Leave A Review",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                  )
                      : SizedBox()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

