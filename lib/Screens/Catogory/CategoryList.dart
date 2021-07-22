import 'dart:convert';
import 'package:badges/badges.dart';
import 'package:farmboxapp/Helper/config.dart';
import 'package:farmboxapp/Models/CategoryModel.dart';
import 'package:farmboxapp/Provider/CartProvider.dart';
import 'package:farmboxapp/Provider/CategoryProvider.dart';
import 'package:farmboxapp/Screens/Catogory/SubProductsList.dart';
import 'package:farmboxapp/Screens/Catogory/CategoryCard.dart';
import 'package:farmboxapp/Screens/ProductScreen/DetailPage.dart';
import 'package:farmboxapp/Screens/Searchitems/search.dart';
import 'package:farmboxapp/Screens/ShoppingCartScreen/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../Constraints.dart';
class CategoryGrid extends StatefulWidget {
  const CategoryGrid({Key key}) : super(key: key);

  @override
  _CategoryGridState createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {
  bool isSearching = false;
  @override
  void initState() {
    super.initState();
    //fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(builder: (context, categoryProvider, child) {
      return Scaffold(
          backgroundColor:BackgroundColor,
          appBar: AppBar(

            title:
                 Text('Category',
                   style: TextStyle(
                     color: Colors.black,
                     letterSpacing: 1.5
                   ),),
            //      Container(
            //   transform: Matrix4.translationValues(-15, 0, 0),
            //   child: TextFormField(
            //     enabled: false,
            //     style: TextStyle(color: Colors.black),
            //     decoration: InputDecoration(
            //         contentPadding:EdgeInsets.only(left: 15),
            //         border:OutlineInputBorder(
            //           borderSide: const BorderSide(color: Colors.black54, ),
            //
            //           borderRadius: BorderRadius.circular(30.0),
            //
            //
            //         ),
            //         suffixIcon: InkWell(onTap: () {
            //           Navigator.pushNamed(context, '/search',);
            //         },
            //           child: Icon(
            //             Icons.search,
            //             color: Colors.black,
            //           ),
            //         ),
            //         hintText: "Search Products",
            //         hintStyle: TextStyle(color: Colors.black)),
            //   ),
            // ),
            backgroundColor:Colors.white,
            //backgroundColor: Colors.white,
            elevation: 2,
            leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),
                onPressed:(){
                  //Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, "/home");
                }),
            actions: [

             // isSearching
              //     ? IconButton(
              //   icon: Icon(Icons.cancel,color: Colors.black,),
              //   onPressed: () {
              //     setState(() {
              //       this.isSearching = false;
              //     });
              //   },
              // )
                   IconButton(
                icon: Icon(Icons.search,color: Colors.black,),
                onPressed: () {
                  Navigator.pushNamed(context, '/search',);
                },
              ),
              Consumer<CartProvider>(builder: (context, cartProvider, child) {
                return  Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: InkWell(
                    onTap: (){
                      Navigator.pushReplacementNamed(context, "/myCart");
                    },
                    child: Badge(
                      badgeColor: Colors.green,
                      position: BadgePosition.topEnd(top: 4),
                      badgeContent: Text(cartProvider.cartCount.toString(),style: TextStyle(color: Colors.white,fontSize: 13),),
                      child: Icon(Icons.shopping_cart,color: Colors.black,size: 23,),
                    ),
                  ),
                );
              },),
            ],
          ) ,
          body: Container(
            margin: EdgeInsets.all(20),
            child:categoryProvider.count> 0? GridView.builder(
              itemCount: categoryProvider.count,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,

              ),

              itemBuilder: (context, index){
                String categoryname = categoryProvider.items[index].text;
                return  GestureDetector(
                onTap: (){
                     Navigator.pushNamed(context, "/subCategory",arguments: SubCategoryArguments(category: categoryname));
          //Navigator.push(context, (MaterialPageRoute(builder: (context)=>CatWiseList())));
          },
                   child: SingleCategory(
                    image: categoryProvider.items[index].thumbnail,
                    title: categoryProvider.items[index].text,
               ),
              );
          }):Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.green,
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Colors.green[100]))),
              ],
            )
          )

      );
    });
  }


  void fetchData() async {
    List<CategoryModel>list;
    final http.Response response = await http.get(
      Config.BASE_URL + '/inventory/allcategories',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    list = (json.decode(response.body) as List)
        .map((data) => new CategoryModel.fromJson(data))
        .toList();
    print(jsonEncode(response.body));
    Provider.of<CategoryProvider>(context, listen: false).setCategory(list);

  }



 }

