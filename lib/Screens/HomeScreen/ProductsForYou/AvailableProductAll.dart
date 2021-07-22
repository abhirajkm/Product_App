import 'dart:convert';

import 'package:farmboxapp/Helper/config.dart';
import 'package:farmboxapp/Models/ProductsModel.dart';
import 'package:farmboxapp/Provider/AllProductProvider.dart';
import 'package:farmboxapp/Provider/ProductProvider.dart';

import 'package:farmboxapp/Screens/ProductScreen/DetailPage.dart';
import 'package:farmboxapp/Screens/ShoppingCartScreen/cart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../Constraints.dart';
import 'AvailableProductCard.dart';
class AvailProductAll extends StatefulWidget {
  const AvailProductAll({Key key}) : super(key: key);

  @override
  _AvailProductAllState createState() => _AvailProductAllState();
}

class _AvailProductAllState extends State<AvailProductAll> {
  List<ProductModel> list;
  bool isSearching=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AllProductProvider>(builder: (context, productProvider, child) {
      return Scaffold(
          appBar: AppBar(
            title: !isSearching
                ? Text("Product For You",
              style: TextStyle(
                  color: Colors.black,
                  //letterSpacing: 1.5,
                  fontSize: 20
              ),)
                : Container(
              transform: Matrix4.translationValues(-15, 0, 0),
              child: TextFormField(
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    contentPadding:EdgeInsets.only(left: 15),
                    border:OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black54, ),

                      borderRadius: BorderRadius.circular(15.0),


                    ),
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    hintText: "Search Products",
                    hintStyle: TextStyle(color: Colors.black)),
              ),
            ),

            backgroundColor: Colors.white,
            elevation: 2,
            leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),
                onPressed:(){
                  Navigator.pop(context);
                }),
            actions: [

              isSearching
                  ? IconButton(
                icon: Icon(Icons.cancel,color: Colors.black,),
                onPressed: () {
                  setState(() {
                    this.isSearching = false;
                  });},
              )
                  : IconButton(
                icon: Icon(Icons.search,color: Colors.black,),
                onPressed: () {
                  setState(() {
                    this.isSearching = true;
                  });
                },
              ),
              /*IconButton(icon: Icon(Icons.search,color: Colors.black,),
                onPressed: (){
              setState(() {
                this.isSearching = !this.isSearching;
              });
                 // Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchItems()));
                }),*/

              IconButton(icon: Icon(Icons.shopping_cart,color: Colors.black,),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
                  })
            ],
          ) ,
          body: Container(
            margin: EdgeInsets.all(10),
            child: GridView.builder(
              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 2,
                  crossAxisSpacing:1
              ),
              itemCount: productProvider.count,
              itemBuilder: (context, index) => GestureDetector(
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
                 // Navigator.push(context, MaterialPageRoute(builder: (context)=>HotDealDetail()));
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 200,
                  width: 150,
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
                      //           bottomRight: Radius.circular(6),
                      //           topLeft: Radius.circular(6),
                      //           // topRight: Radius.circular(6)
                      //         )
                      //     ),
                      //     child: Center(
                      //       child: Text("5%off",style: TextStyle(
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
                                    image:NetworkImage(productProvider.items[index].featuredImage),
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
                            child: Text(productProvider.items[index].unit,style: TextStyle(
                                color: Colors.white,
                                fontSize:10,
                                fontWeight: FontWeight.w600
                            ),),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 125),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(productProvider.items[index].name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600
                                ),),
                            ),
                            //SizedBox(height: 4,),

                            SizedBox(height: 6,),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Price: ",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600
                                    ),),
                                  Text("₹ "+productProvider.items[index].mrp.toString(),
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        decoration: TextDecoration.lineThrough,
                                        fontWeight: FontWeight.w600
                                    ),),
                                  SizedBox(width: 3,),
                                  Text(productProvider.items[index].sellingPrice.toString(),
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,

                                        fontWeight: FontWeight.w600
                                    ),),
                                ],
                              ),
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
                )),
            ),
          )
      );
    },);
  }
  // void fetchData() async{
  //   //args = ModalRoute.of(context).settings.arguments;
  //  // print(args.category);
  //   String url = Config.BASE_URL + "/inventory/allproducts/available";
  //
  //   final response = await http.get(url,
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },);
  //   list = (json.decode(response.body) as List).map((data)=>new ProductModel.fromJson(data)).toList();
  //   Provider.of<AllProductProvider>(context,listen: false).setProducts(list);
  //   print(response.body);
  // }

}
