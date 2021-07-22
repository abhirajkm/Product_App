import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:farmboxapp/Helper/config.dart';
import 'package:farmboxapp/Models/CategoryModel.dart';
import 'package:farmboxapp/Models/ProductsModel.dart';
import 'package:farmboxapp/Models/UserModel.dart';
import 'package:farmboxapp/Provider/CartProvider.dart';
import 'package:farmboxapp/Provider/CategoryProvider.dart';
import 'package:farmboxapp/Screens/Catogory/SubProductsList.dart';
import 'package:farmboxapp/Screens/ProductScreen/DetailPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Constraints.dart';


class AllSnacks extends StatefulWidget {
  const AllSnacks({Key key}) : super(key: key);

  @override
  _AllSnacksState createState() => _AllSnacksState();
}

class _AllSnacksState extends State<AllSnacks> {

  List<ProductModel> list;
  bool args;
  Future favFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favFuture =_fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        elevation: 1,
        title: Padding(
          padding: const EdgeInsets.only(left: 50.0),
          child: Text("Biscuits",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  letterSpacing: 1.5,
                  //wordSpacing: 1.5,
                  fontFamily: 'roboto')),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, "/home");
              // Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 24,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Consumer<CartProvider>(builder: (context, cartProvider, child) {
              return  InkWell(
                onTap: (){
                  Navigator.pushReplacementNamed(context, "/myCart");
                },
                child: Badge(
                  badgeColor:PrimaryColor,
                  position: BadgePosition.topEnd(top: 2),
                  badgeContent: Text(cartProvider.cartCount.toString(),style: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.bold),),
                  child: Icon(Icons.shopping_cart,color: Colors.black,size: 23,),
                ),
              );
            },),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: FutureBuilder(
          builder: (context, productSnap) {
            if (productSnap.connectionState == ConnectionState.none &&
                productSnap.hasData == null) {
              return Container(color: Colors.red,);
            }
            return productSnap.data != null
                ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 3.0,

                    childAspectRatio: 0.85

                ),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: productSnap.data.length,
                itemBuilder: (context, index) {
                  ProductModel product =productSnap.data[index];
                  //productid = productProvider.items[index].sId;
                  return  GestureDetector(

                    onTap: (){
                      Navigator.pushNamed(context, "/prodetail",arguments: new ProductArguments(
                          sId:product.sId,
                          name: product.name,
                          code:product.code ,
                          description: product.description,
                          sellingPrice: product.sellingPrice,
                          mrp: product.mrp,
                          featuredImage: product.featuredImage,
                          unit: product.unit,
                          category:product.category
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),

                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 0),
                            blurRadius: 3,
                            color: Colors.grey[400],
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          // Positioned(
                          //   left: 0,
                          //   child: Container(
                          //     height: 20,
                          //     width: 40,
                          //     decoration: BoxDecoration(
                          //         color: Colors.redAccent,
                          //         borderRadius: BorderRadius.only(
                          //             bottomRight: Radius.circular(6),
                          //             topLeft: Radius.circular(6),
                          //            // topRight: Radius.circular(6)
                          //         )
                          //     ),
                          //     child: Center(
                          //       child: Text(offer,style: TextStyle(
                          //           color: Colors.white,
                          //           fontSize:10,
                          //           fontWeight: FontWeight.bold
                          //       ),),
                          //     ),
                          //   ),
                          // ),
                          Positioned(
                            top: 0,
                            child: Center(
                              child: Container(
                                margin: EdgeInsets.only(left:25,top: 30),
                                height: 90,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    //borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image:NetworkImage(product.featuredImage),
                                        fit: BoxFit.contain
                                    )
                                ),

                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 120),
                            child: Divider(color: PrimaryColor.withOpacity(0.4),),
                          ),
                          Positioned(
                            right: 0,
                            child: Container(
                              height: 15,
                              width: 35,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(6),
                                      topLeft: Radius.circular(3),
                                      topRight: Radius.circular(6)
                                  )
                              ),
                              child: Center(
                                child: Text(product.unit,style: TextStyle(
                                    color: Colors.white,
                                    fontSize:10,
                                    fontWeight: FontWeight.bold
                                ),),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 130),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(product.name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold
                                    ),),
                                ),
                                //SizedBox(height: 4,),

                                SizedBox(height: 6,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Price: ",
                                      style: TextStyle(
                                          color: PrimaryColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold
                                      ),),
                                    Text("₹ "+product.mrp.toString(),
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          decoration: TextDecoration.lineThrough,
                                          fontWeight: FontWeight.bold
                                      ),),
                                    SizedBox(width: 3,),
                                    Text(product.sellingPrice.toString(),
                                      style: TextStyle(
                                          color: PrimaryColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold
                                      ),),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   crossAxisAlignment: CrossAxisAlignment.center,
                                //   children: [
                                //     Container(
                                //         height:20,
                                //         decoration:BoxDecoration(
                                //             shape: BoxShape.circle,
                                //             color: Colors.green.shade50
                                //         ),
                                //         child: IconButton(icon: Icon(Icons.remove,size: 10,color: Colors.green,), onPressed:(){})
                                //     ),
                                //     //SizedBox(width: 3,),
                                //     Text("1",style: TextStyle(
                                //         color: Colors.black,
                                //         fontSize: 5,
                                //         fontWeight: FontWeight.bold
                                //     ),),
                                //    // SizedBox(width: 3,),
                                //     Container(
                                //         height:20,
                                //         //width: 30,
                                //         decoration:BoxDecoration(
                                //            shape: BoxShape.circle,
                                //
                                //             color: Colors.green
                                //         ),
                                //         child: Center(child: IconButton(icon: Icon(Icons.add,size: 7,color: Colors.white,), onPressed:(){}))
                                //     ),
                                //     //SizedBox(width: 5,),
                                //     Container(
                                //
                                //       height: 20,
                                //
                                //       decoration: BoxDecoration(
                                //           color: Colors.green.withOpacity(0.1),
                                //           borderRadius: BorderRadius.circular(8)
                                //       ),
                                //       child: Padding(
                                //         padding: const EdgeInsets.all(5.0),
                                //         child: Row(
                                //
                                //           children: [
                                //             Icon(Icons.add_shopping_cart,color: Colors.green,size: 10,),
                                //             SizedBox(width: 5,),
                                //             Text("Add to Cart",
                                //               style: TextStyle(
                                //                   color: Colors.green,
                                //                   fontSize: 8,
                                //                   fontWeight: FontWeight.bold
                                //               ),)
                                //           ],
                                //         ),
                                //       ),
                                //     )
                                //
                                //
                                //   ],
                                // )
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),


                  );
                }
            )
                : Container();
          },
          future: favFuture,
        ),
      ),
    );


  }
// void fetchData() async {
//   List<CategoryModel>list;
//   final http.Response response = await http.get(
//     Config.BASE_URL + '/inventory/allcategories',
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//   );
//   list = (json.decode(response.body) as List)
//       .map((data) => new CategoryModel.fromJson(data))
//       .toList();
//   print(jsonEncode(response.body));
//   Provider.of<CategoryProvider>(context, listen: false).setCategory(list);
//
// }


  Future<void> _fetchData() async {

    String url = Config.BASE_URL + "/inventory/category/Snacks";
    final response = await http.get(
      url,
    );

    setState(() {
      list = (json.decode(response.body) as List)
          .map((data) => new ProductModel.fromJson(data))
          .toList();
    });

    return list;
  }
}
