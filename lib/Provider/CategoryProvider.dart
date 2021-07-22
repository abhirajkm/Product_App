import 'package:farmboxapp/Models/CategoryModel.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier{
  List<CategoryModel> _items = [];
  List<CategoryModel> get items{
    return _items;
  }
  int get count{
    return _items.length;
  }
  void setCategory(List<CategoryModel> items){
    _items = items;
    notifyListeners();
  }
}