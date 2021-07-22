import 'dart:convert';

import 'package:farmboxapp/Constraints.dart';
import 'package:farmboxapp/Helper/config.dart';
import 'package:farmboxapp/Models/Orders.dart';
import 'package:farmboxapp/Models/UserModel.dart';
import 'package:farmboxapp/Provider/OrderProvider.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'OrderDetails.dart';


class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<OrderModel> list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      _fetchData();
    });
  }

  @override

  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(15),

        child:
    Consumer<OrderProvider>(
      builder: (context, orderProvider, child) {
        if (orderProvider.orderCount > 0) {
          return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: orderProvider.orderCount,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/order-detail',
                            arguments:
                            OrderDetailArguments(
                                cart: orderProvider.orders[index].cart,
                                paymentDone: orderProvider.orders[index].paymentDone,
                                sId: orderProvider.orders[index].sId,
                                orderId: orderProvider.orders[index].orderId,
                                orderType: orderProvider.orders[index].orderType,
                                user: orderProvider.orders[index].user,
                                status: orderProvider.orders[index].status,
                                created: orderProvider.orders[index].created,
                                total: orderProvider.orders[index].total,
                                address: orderProvider.orders[index].address,
                                statusHistory: orderProvider.orders[index].statusHistory


                            ));
                      },
                      child: Container(

                          decoration: BoxDecoration(color: Colors.white,
                            boxShadow: [
                                  BoxShadow(
                                  offset: Offset(0, 0),
                                     blurRadius: 3,
                                   color: Colors.grey[400],
                                   ),
                             ],
                          ),
                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Text(
                                        orderProvider.orders[index].orderId,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                    ),

                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Text(
                                      DateFormat('dd-MM-yyyy').format(
                                          DateTime.parse(
                                              orderProvider.orders[index].created)),
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Expanded(
                                        child: orderProvider.orders[index].status ==
                                            "order placed" ?
                                        Text(
                                            orderProvider.orders[index].status,

                                            textAlign: TextAlign.right,
                                            style: TextStyle(color: PrimaryColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,


                                            ))
                                            : orderProvider.orders[index].status ==
                                            "Cancelled" ?Text(
                                            orderProvider.orders[index].status.toUpperCase(),

                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600))
                                            : orderProvider.orders[index].status ==
                                            "Delivered" ?Text(
                                            orderProvider.orders[index].status.toUpperCase(),

                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600)):Text('')
                                    )
                                  ],
                                ),
                                //.split("T")[0]
                                Divider(),
                                Text(
                                  "ITEMS",
                                  style: TextStyle(
                                      color: Colors.black,fontSize: 12),
                                  textAlign: TextAlign.start,

                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(orderProvider.orders[index].cart,

                                  style: TextStyle(
                                      color: Colors.black54,fontSize: 13),
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(height: 15,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    orderProvider.orders[index].orderType ==
                                        1
                                        ? Text(
                                      "Cash On Delivery",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green[800]),
                                    )
                                        : orderProvider.orders[index]
                                        .paymentDone ==
                                        true
                                        ? Text(
                                      "Payment Completed",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green[800]),
                                    )
                                        : Text(
                                      "Payment Failed",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.red),
                                    ),
                                    Expanded(
                                        child: Text(
                                          "Total : ₹ " +
                                              orderProvider.orders[index].total,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(fontSize: 15,

                                              fontWeight: FontWeight.w600),
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),

                              ],
                            ),
                          )),
                    ),
                    SizedBox(height: 10,)
                  ],
                );

              });
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.green,
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Colors.green[100]))),
            ],
          );
        }
      },
    ));
  }

  Future<void> _fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    String userDetails = prefs.getString("USER");
    Userdetails user = Userdetails.fromJson(json.decode(userDetails));

    String url = Config.BASE_URL + "/inventory/orders/user/" + user.user.sId;
    final response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': user.token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(user.user.sId);
    list = (json.decode(response.body) as List)
        .map((data) => new OrderModel.fromJson(data))
        .toList();
    Provider.of<OrderProvider>(context, listen: false).setOrders(list);
  }
}
