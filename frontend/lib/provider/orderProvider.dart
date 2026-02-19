import 'package:frontend/model/order.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderProvider extends StateNotifier<List<Order>>{
  OrderProvider():super([]);

  void setOrder(List<Order> order){
    state = [...order];
  }

}

final orderProvider = StateNotifierProvider<OrderProvider,List<Order>>((ref)=>OrderProvider());
