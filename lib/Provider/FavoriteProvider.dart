import 'package:farmboxapp/Models/FavoriteModel.dart';
import 'package:flutter/material.dart';
import 'package:farmboxapp/Models/ProductsModel.dart';


class FavoriteProvider extends ChangeNotifier{
  List<FavoriteModel> _items = [];

  List<FavoriteModel> get items{
    return _items;
  }

  int get count{
    return _items.length;
  }

  void setFavorite(List<FavoriteModel> items){
    _items = items;
    notifyListeners();
  }
}