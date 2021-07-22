import 'dart:convert';
import 'package:bexindia/Helper/config.dart';
import 'package:bexindia/Models/ProductsModel.dart';
import 'package:bexindia/Provider/AllProductProvider.dart';
import 'package:bexindia/Screens/ProductScreen/DetailPage.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AvailableProductCard.dart';
class AvailaleProductList extends StatefulWidget {
  const AvailaleProductList({Key key}) : super(key: key);

  @override
  _AvailaleProductListState createState() => _AvailaleProductListState();
}

class _AvailaleProductListState extends State<AvailaleProductList> {
  List<ProductModel> list;
  String productid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AllProductProvider>(builder:(context, productProvider, child) {
      if (productProvider.count > 0) {
        return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: productProvider.count,
            itemBuilder: (context, index) {
              //productid = productProvider.items[index].sId;
              return  GestureDetector(

                onTap: (){
                  Navigator.pushNamed(context, "/prodetail",arguments: new ProductArguments(
                      sId:productProvider.items[index].sId,
                      name: productProvider.items[index].name,
                      code:productProvider.items[index].code ,
                      description: productProvider.items[index].description,
                      sellingPrice: productProvider.items[index].sellingPrice,
                      mrp: productProvider.items[index].mrp,
                      featuredImage: productProvider.items[index].featuredImage,
                      unit: productProvider.items[index].unit,
                      category:productProvider.items[index].category
                  ));
                },
                child: AvailableProCard(
                  rating: 4.0,
                  image: productProvider.items[index].featuredImage,
                  price: productProvider.items[index].sellingPrice,
                  mrp: productProvider.items[index].mrp,
                  weight: productProvider.items[index].unit,
                  name: productProvider.items[index].name,


                ),
              );
            }
        );
      }else{
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
                child: CircularProgressIndicator(
                    backgroundColor: Colors.blue,
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        Colors.green[100]))),
          ],
        );
      }
    }, );
  }
  void fetchData() async{
    //args = ModalRoute.of(context).settings.arguments;
    // print(args.category);
    String url = Config.BASE_URL + "/inventory/allproducts/available";

    final response = await http.get(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },);
    list = (json.decode(response.body) as List).map((data)=>new ProductModel.fromJson(data)).toList();
    Provider.of<AllProductProvider>(context,listen: false).setProducts(list);
    print(response.body);
  }
}
