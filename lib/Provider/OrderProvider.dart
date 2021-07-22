
import 'package:farmboxapp/Models/CartModel.dart';
import 'package:farmboxapp/Models/Orders.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OrderProvider extends ChangeNotifier{
  // List<CartModel> _cart = [];
  // List<CartModel> get cartItems{
  //   return _cart;
  // }

  List<OrderModel> _order =[];
  List<OrderModel> get orders{
    return _order;
  }
  int get orderCount{
    return _order.length;
  }
  void setOrders(List<OrderModel> orders){
    _order = orders;
    notifyListeners();
  }



}

