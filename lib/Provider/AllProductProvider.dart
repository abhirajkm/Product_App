import 'dart:convert';

import 'package:bexindia/Models/ProductsModel.dart';
import 'package:flutter/material.dart';


class AllProductProvider extends ChangeNotifier{
  String _searchText = "";
  List<ProductModel> _items = [];
  List<ProductModel> get items{
    return _items;
  }
  List<ProductModel> get filteredItems{
    List<ProductModel> list = [];
    for(int i=0;i < _items.length;i++){
      if(_searchText.length>2 && _items[i].name.toUpperCase().contains(_searchText.toUpperCase())){
        list.add(_items[i]);
      }
    }
    print(jsonEncode(list));
    return list;
  }
  String get searchtext{
    return _searchText;
  }


  int get count{
    return _items.length;
  }
  void setProducts(List<ProductModel> items){
    _items = items;
    notifyListeners();
  }

  void setSearchText(String text){
    _searchText = text;
    print(_searchText);
    notifyListeners();
  }
}