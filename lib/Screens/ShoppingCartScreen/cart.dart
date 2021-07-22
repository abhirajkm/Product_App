

import 'package:bexindia/Provider/CartProvider.dart';
import 'package:bexindia/Screens/CheckoutScreen/ReviewOrder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Constraints.dart';
import 'cartcard.dart';


class Cart extends StatelessWidget {
  const Cart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var rating = 3.0;
    return Consumer<CartProvider>(builder: (context, cartProvider, child) {
      return Scaffold(

        appBar: AppBar(
          title: Center(
            child: Text("Shopping Cart",style: TextStyle(
              color: Colors.black,
                letterSpacing: 1.5

            ),),
          ),
          backgroundColor: Colors.white,
          elevation: 2,
          leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),
              onPressed:(){
                Navigator.pushReplacementNamed(context, "/home");
              }),

        ) ,

        body: cartProvider.cartCount>0?Container(
          margin: EdgeInsets.all(20),
          height: size.height,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("SubTotal ("+cartProvider.cartCount.toString()+" items):  ",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black
                    ),),
                  Text("₹"+ cartProvider.total.toString(),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: PrimaryColor
                    ),),
                ],
              ),
              SizedBox(height: 20,),
              Container(
                height: 500,
                child: SizedBox(
                    height:100,child: CartCard()),
              ),
              SizedBox(height: 10,),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    primary: PrimaryColor,
                    //onPrimary: Colors.white
                  ),

                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewOrder()));


                  },


                  child: Text(
                    'Proceed to Pay'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing:1.0,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              //SizedBox(height: 20,),

            ],
          ),
        ):Container(
          margin: EdgeInsets.all(20),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
            //   Container(
            //     height: 300,
            //     //width: 300,
            // decoration: BoxDecoration(
            //     color: Colors.white,
            //     // image: new DecorationImage(
            //     //   image: new AssetImage("assets/images/cartEmpty.png"),
            //     //   fit: BoxFit.cover,)
            //   ),
            //     child: Image.asset("assets/images/cartempty.png"),
            //   ),
              Center(child: Icon(Icons.add_shopping_cart,size: 64,color:PrimaryColor,)),
              SizedBox(height: 20,),
              Center(child: Container(child: Text("YOUR CART IS EMPTY",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,letterSpacing: 1.5 ),))),
              SizedBox(height: 20,),
              Center(child: Container(child: SizedBox( width:200,child: Text("Looks like you haven't made your menu yet",textAlign: TextAlign.center, style: TextStyle(color: Colors.black45),)),),),
              SizedBox(height: 20,),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    primary: PrimaryColor
                  ),
                  onPressed : (){
                  Navigator.pushNamed(context, '/home');
                },

                  child: Text("BROWSE PRODUCTS",
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.0,
                      fontWeight: FontWeight.w600,
                      fontSize: 18

                    ),)),
              )
            ],
          ),
        ),
      );

    },);


  }
}
