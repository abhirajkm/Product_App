import 'dart:convert';
import 'dart:ui';


import 'package:badges/badges.dart';
import 'package:farmboxapp/Constraints.dart';
import 'package:farmboxapp/Helper/config.dart';
import 'package:farmboxapp/Models/Orders.dart';
import 'package:farmboxapp/Provider/CartProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetails extends StatefulWidget {
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  OrderDetailArguments args;

  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    args = ModalRoute.of(context).settings.arguments;
    Duration timeDifference =
    DateTime.now().difference(DateTime.parse(args.created));
    return Scaffold(
      backgroundColor: BackgroundColor,
        appBar: AppBar(
          backgroundColor:Colors.white,
          //backgroundColor: Colors.white,
          elevation: 2,
          title: Text("Order Details",
            style:TextStyle(
                color: Colors.black,
                letterSpacing: 1.5
            ) ,),
          leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),
              onPressed:(){
                //Navigator.pop(context);
                Navigator.pop(context);
              }),
          actions: [
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

        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(

                 height: size.height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 3,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20,left: 10,right: 20,bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: [

                            Text("OrderID: ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600
                              ),),
                            Text(args.orderId,
                              style: TextStyle(
                                  color: PrimaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600
                              ),),
                          ],
                        ),
                        SizedBox(height: 10,),

                        Divider(thickness: 7,color: BackgroundColor,),
                        SizedBox(height: 10,),
                        Text("Product Details",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600
                          ),),
                        SizedBox(height: 10,),
                        Text(args.cart,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              //fontWeight: FontWeight.bold
                          ),),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Grand Total",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14, fontWeight: FontWeight.w600),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              "₹ " + args.total,
                              style: TextStyle(

                                  color:PrimaryColor,
                                  fontSize: 12, fontWeight: FontWeight.w600),


                               

                            ),
                          ],
                        ),
                        Divider(thickness: 7,color: BackgroundColor,),
                        Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Shipping Address",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600
                                  ),),
                                SizedBox(height: 10,),
                                Text(
                                  args.address.name.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  (args.address.addressLine1 +
                                      " , " +
                                      args.address.addressLine2)
                                      ,
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  args.address.pincode + " , ",
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  args.address.landmark +
                                      "  ",
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  args.address.phone + " , ",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            )
                        ),
                        SizedBox(height: 10,),
                        Divider(thickness: 8,color: BackgroundColor,),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Payment Status",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold
                              ),),
                            SizedBox(height: 10,),
                            args.orderType == 1
                                ? Text(
                              "Cash On Delivery",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: PrimaryColor),
                            )
                                : args.paymentDone == true
                                ? Text(
                              "Payment Completed",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight:FontWeight.w600,
                                  color:PrimaryColor),
                            )
                                : Text(
                              "Payment Failed",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Divider(thickness: 8,color: BackgroundColor,),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Order Status",
                                //textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600)),
                            Text(args.status,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: PrimaryColor,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Divider(thickness: 8,color: BackgroundColor,),
                        SizedBox(height: 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            args.status != "Cancelled" &&
                                args.status != "DELIVERED"
                                ? Column(
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          Widget cancelButton = TextButton(
                                            child: Text("NO",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color:PrimaryColor)),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          );
                                          Widget continueButton = TextButton(
                                            child: Text(
                                              "YES",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.red),
                                            ),
                                            onPressed: () {
                                              cancelOrder();
                                            },
                                          );
                                          return AlertDialog(
                                            contentPadding:
                                            EdgeInsets.fromLTRB(15, 10, 15, 0),
                                            title: Text(
                                              "ARE YOU SURE ?",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            content: Text(
                                              "You won't be able to continue with the order if cancelled.\nDo you want to cancel your order?",
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                color: Colors.black54,
                                              ),
                                            ),
                                            actions: <Widget>[
                                              cancelButton,
                                              continueButton
                                            ],
                                          );
                                        });
                                  },
                                  child: Container(
                                    decoration:
                                    BoxDecoration(color: Colors.white, boxShadow: [
                                      BoxShadow(color: Colors.black38),
                                    ]),
                                    //padding: EdgeInsets.only(top: 10),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Text(
                                          " Cancel",
                                          style: TextStyle(
                                              color: Colors.red,
                                              letterSpacing: 1.4,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                         SizedBox(width: 230,),
                                        Icon(
                                          Icons.cancel,
                                          color: Colors.red,
                                          size: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            )
                                :SizedBox(height: 3,),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void cancelOrder() async {
    final prefs = await SharedPreferences.getInstance();
    Duration timeDifference =
    DateTime.now().difference(DateTime.parse(args.created));
    String userDetails = prefs.getString("USER");
   // UserModel user = UserModel.fromJson(json.decode(userDetails));
    String url = Config.BASE_URL + "/inventory/status/" + args.orderId;

    final http.Response response = await http.put(
      url,
      headers: <String, String>{
        //'Authorization': user.token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{"status": "Cancelled"}),
    );
    print(args.status);
    // if (args.status != "order placed") {
    //   print("test");
    //   for (int i = 0; i < args.cart.length; i++) {
    //     print(args.cart.length);
    //
    //     final http.Response response = await http.put(
    //       Config.BASE_URL + '/inventory/updatestock/' + args.cart[i].sId,
    //       headers: <String, String>{
    //         'Authorization': user.token,
    //         'Content-Type': 'application/json; charset=UTF-8',
    //       },
    //       body: jsonEncode(<String, dynamic>{
    //         "qty": (args.cart[i].qty),
    //       }),
    //     );
    //   }
    // }
    Navigator.pushNamedAndRemoveUntil(context, "/my-orders", (r) => false);
   // Navigator.pushNamed(context, "/my-orders");
  }
}

class OrderDetailArguments {
  Address address;
  String cart;
  bool paymentDone;
  String sId;
  String orderId;
  int orderType;
  String user;
  String status;
  String created;
  String total;
  List<StatusHistory> statusHistory;

  OrderDetailArguments(
      {this.address,
        this.cart,
        this.paymentDone,
        this.sId,
        this.orderId,
        this.orderType,
        this.user,
        this.status,
        this.statusHistory,
        this.created,
        this.total});
}

double total(_cart) {
  double total = 0;
  for (int i = 0; i < _cart.length; i++) {
    total += (double.parse(_cart[i].sellingPrice.toString()) *
        double.parse(_cart[i].qty.toString()));
  }
  return total;
}
