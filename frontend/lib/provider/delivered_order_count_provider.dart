
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/controller/order_controller.dart';

class DeliverdOrderCountProvider extends StateNotifier<int>{
  DeliverdOrderCountProvider():super(0);

  void fetchDeliveredOrderCount(String buyerId,context)async{
    // order controller
    final OrderController orderController = OrderController();
    // fetch all the delivered product count from the order controller class.
    int count = await orderController.countDeliveredOrder(buyerId: buyerId,context: context);
    // set the count to the state.
    state = count;
  }

  int get deliveredCount => state;

}

final deliverdOrderCountProvider = StateNotifierProvider<DeliverdOrderCountProvider,int>((ref)=>DeliverdOrderCountProvider());
