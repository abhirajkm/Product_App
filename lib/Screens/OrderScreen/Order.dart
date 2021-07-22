import 'package:badges/badges.dart';
import 'package:bexindia/Constraints.dart';
import 'package:bexindia/Provider/CartProvider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'MyOrder.dart';

class AllOrders extends StatefulWidget {
  @override
  _AllOrdersState createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:Colors.white,
          //backgroundColor: Colors.white,
          elevation: 2,
          title: Text("My Orders",
            style:TextStyle(
              color: Colors.black,
                letterSpacing: 1.5
            ) ,),
          leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),
              onPressed:(){
                //Navigator.pop(context);
                Navigator.pushReplacementNamed(context, "/home");
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
                    badgeColor: PrimaryColor,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 15,),
              Orders()
            ],
          ),
        ));

  }
}
// Container(
// padding: EdgeInsets.all(10),
// child: Orders(),
// )