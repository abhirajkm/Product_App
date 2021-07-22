import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:bexindia/Helper/config.dart';
import 'package:bexindia/Models/ProductsModel.dart';
import 'package:bexindia/Provider/CartProvider.dart';
import 'package:bexindia/Provider/ProductProvider.dart';

import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:provider/provider.dart';


import '../../Constraints.dart';
import '../BottomNavigation.dart';
import 'SearchList.dart';
class Search extends StatefulWidget {
  const Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isSearching = false;
  void initState() {
    // TODO: implement initState
    super.initState();
    _clearData();
    _fetchData();
  }
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
          children: <Widget>[
      Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5),
      // It will cover 20% of our total height
      height: size.height * 0.20,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: 36 + kDefaultPadding,
            ),
            height: size.height * 0.5 - 27,
            decoration: BoxDecoration(
              color: PrimaryColor,
              // borderRadius: BorderRadius.only(
              //   bottomLeft: Radius.circular(36),
              //   bottomRight: Radius.circular(36),
              // ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>FirstScreen()));
                  },
                      icon: Icon(Icons.arrow_back,color: Colors.white,)
                  ),
                  Text(
                    'Behindia',
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  IconButton(onPressed: (){
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>FavoriteList()));
                  },
                      icon: Icon(Icons.favorite_rounded,color: Colors.white,)),
                  Consumer<CartProvider>(builder: (context, cartProvider, child) {
                    return  InkWell(
                      onTap: (){
                        Navigator.pushReplacementNamed(context, "/myCart");
                      },
                      child: Badge(
                        badgeColor: Colors.orangeAccent,
                        position: BadgePosition.topEnd(top: -15),
                        badgeContent: Text(cartProvider.cartCount.toString(),style: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.bold),),
                        child: Icon(Icons.shopping_cart,color: Colors.white,size: 23,),
                      ),
                    );
                  },),

                  //Spacer(),
                  //Image.asset("assets/images/logo.png")
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: PrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {

                },
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(

                       onChanged: (String value) {
                              setSearchText(value);
                             },
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: PrimaryColor.withOpacity(0.5),
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          // surffix isn't working properly  with SVG
                          // thats why we use row
                          // suffixIcon: SvgPicture.asset("assets/icons/search.svg"),
                        ),
                      ),
                    ),
                    SvgPicture.asset("assets/search.svg"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
      Expanded(child: SearchList())
          ],
        ),  );
  }

  Future<void> _fetchData() async {
    String url = Config.BASE_URL + "/inventory/allproducts/available";
    final response = await http.get(url);
    List<ProductModel> list = (json.decode(response.body) as List)
        .map((data) => new ProductModel.fromJson(data))
        .toList();
    Provider.of<ProductsProvider>(context, listen: false).setProducts(list);

  }

  Future<void> _clearData() async {
    Provider.of<ProductsProvider>(context, listen: false).setSearchText("");
  }

  void setSearchText(String value) {
    Provider.of<ProductsProvider>(context, listen: false).setSearchText(value);
  }
}
