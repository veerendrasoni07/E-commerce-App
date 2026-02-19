import 'package:frontend/controller/order_controller.dart';
import 'package:frontend/model/order.dart';
import 'package:frontend/provider/orderProvider.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/views/widgets/order_detailed_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderScreenWidget extends ConsumerStatefulWidget {
  const OrderScreenWidget({super.key});

  @override
  ConsumerState<OrderScreenWidget> createState() => _OrderScreenWidgetState();
}

class _OrderScreenWidgetState extends ConsumerState<OrderScreenWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchOrders();
  }
  // function to fetch the order
  Future<void> _fetchOrders()async{
    final user = ref.read(userProvider);
    if(user!=null){
      final OrderController orderController = OrderController();
      try{
        final order = await orderController.loadOrders(buyerId: user.id, context: context);
        ref.read(orderProvider.notifier).setOrder(order);
      }
      catch(e){
        print(e.toString());
      }
    }
  }

  Future<void> deleteOrder(String orderId)async
  {
    final OrderController orderController = OrderController();
    await orderController.deleteOrder(orderId, context);
    setState(() {});
    _fetchOrders();
  }


  void dialogBox(String orderId){
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
                  Text("Are You Really Want To Delete The Order?",style: GoogleFonts.aBeeZee(fontSize: 20,fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(onPressed: () {
                          deleteOrder(orderId);
                          Navigator.pop(context);
                          },
                            child: Text("Yes")
                        ),
                        ElevatedButton(onPressed: ()=>Navigator.pop(context), child: Text("No"))
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(orderProvider);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        leading: IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.arrow_back)),
      ),
      body: orders.isEmpty ? Center(child: Text("No order found"),) :
          ListView.builder(
            itemCount: orders.length,
              itemBuilder: (context,index){
              final Order order = orders[index];
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailedScreenWidget(order: order)));
                  },
                  child: Card(
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
                                          order.image,
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
                                  color: order.delivered == true ? Colors.green : Colors.redAccent,
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                child: Center(
                                  child: Text(
                                   order.delivered == true ? 'Delivered' :
                                       order.processing == true ?
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
                              Text(order.productName,style: GoogleFonts.aBeeZee(fontSize: 18,fontWeight: FontWeight.bold),),
                              Text(order.category,style: GoogleFonts.aBeeZee(fontSize: 18,fontWeight: FontWeight.bold),),
                              Text('₹${order.productPrice}',style: GoogleFonts.aBeeZee(fontSize: 18,fontWeight: FontWeight.bold),),
                              IconButton(
                                  onPressed: (){
                                    dialogBox(order.id);
                                  },
                                  icon: Icon(Icons.delete)
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
          )
    );
  }
}

