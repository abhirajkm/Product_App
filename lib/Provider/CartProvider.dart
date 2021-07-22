import 'dart:convert';
import 'package:farmboxapp/Helper/PrefsHelper.dart';
import 'package:farmboxapp/Models/CartModel.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CartProvider extends ChangeNotifier{
  List<CartModel> _cart = [];
  List<CartModel> get items{
    return _cart;
  }
  int deliveryCharge =17;
  int get cartCount{
    return _cart.length;
  }


  double get total{
    double total = 0;
    for(int i=0;i<_cart.length;i++){
      total += (double.parse(_cart[i].sellingPrice.toString()) * double.parse(_cart[i].quantity.toString()));
    }
    return total;
  }

  double get gst{

    return total*.15;
  }
  double get grandTotal {
    double grandTotal = 0;
    if (_cart.length > 0) {
      grandTotal = total + deliveryCharge;
      return grandTotal;
    }
    else {
      return grandTotal;
    }
  }

  int quantity (String id){

    for(int i=0;i<_cart.length;i++){
      if(_cart[i].sId==id){
        return _cart[i].quantity;
      }
    }
    return 0;
  }


  void addToCart(CartModel item){
    if(_cart.length == 0 ){
      _cart.add(item);
    }else{
      if(item.quantity.toString() == "0"){
        deleteItem(item.sId);
      }else{
        addItem(item);
      }
    }
    notifyListeners();
    PrefsHelper.saveCart(jsonEncode(_cart));
  }

  void deleteItem(String sId) {
    for(int i=0;i<_cart.length;i++){
      if(_cart[i].sId == sId){
        _cart.removeAt(i);
      }
    }
    PrefsHelper.saveCart(jsonEncode(_cart));
  }

  void addItem(CartModel item) {
    bool found = false;
    int index = 0;
    for(int i=0;i<_cart.length;i++){
      if(_cart[i].sId == item.sId){
        found = true;
        index = i;
      }
    }
    if(found){
      _cart[index].quantity = item.quantity;
    }else{
      _cart.add(item);
    }
  }



  void addQuantity(String id){
    for(int i=0;i<_cart.length;i++){
      if(_cart[i].sId == id){
        int quantity = int.parse(_cart[i].quantity.toString()) + 1;
        _cart[i].quantity = quantity ;
      }
    }
    notifyListeners();
    PrefsHelper.saveCart(jsonEncode(_cart));
  }

  void reduceQuantity(String id){

    for(int i=0;i<_cart.length;i++){
      if(_cart[i].sId == id){
        int quantity = int.parse(_cart[i].quantity.toString()) - 1;
        if(quantity == 0){
          deleteItem(id);
        }else{
          _cart[i].quantity = quantity;
        }

      }
    }
    notifyListeners();
    PrefsHelper.saveCart(jsonEncode(_cart));
  }

  void hydrateCartFromPrefs() async{
    final prefs = await SharedPreferences.getInstance();
    String cart = prefs.getString("CART");
    print(cart);
    if(cart!=null){
      _cart = (json.decode(cart) as List).map((data)=>new CartModel.fromJson(data)).toList();
      notifyListeners();
    }
  }

  void flushCart() async{
    _cart.removeRange(0, _cart.length);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("CART", "");
  }

}

