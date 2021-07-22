import 'package:farmboxapp/Provider/CartProvider.dart';
import 'package:farmboxapp/Screens/CheckoutScreen/ReviewOrder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../Constraints.dart';

class CartCard extends StatefulWidget {
  const CartCard({Key key,

  }) : super(key: key);


  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Consumer<CartProvider>(
        builder: (context,cartProvider,child){
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: cartProvider.cartCount,
              itemBuilder:(context, index) {
                return Container(
                  margin: EdgeInsets.only(top: 10),

                  height: 100,
                  // width: widget.size.width*0.90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
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
                      Row(
                        children: [
                          //Divider(height: 100,thickness: 6,color: Colors.green,),

                          Container(

                            height: 100,
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                                image: DecorationImage(
                                    image:NetworkImage(cartProvider.items[index].featuredImage),
                                    fit: BoxFit.contain
                                )
                            ),

                          ),
                          SizedBox(width: 10,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(cartProvider.items[index].name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),),
                              SizedBox(height: 5,),
                              Text("Weight: " + cartProvider.items[index].unit,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  // fontWeight: FontWeight.bold
                                ),),
                              SizedBox(height: 7,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Price: ₹"+ ((cartProvider.items[index]
                                  .sellingPrice) *
                                  (cartProvider.items[index].quantity)).toString(),
                                    style: TextStyle(
                                      color: PrimaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600
                                      //fontWeight: FontWeight.bold
                                    ),),
                                  SizedBox(width: 40,),
                                  Container(
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap:(){
                                            Provider.of<CartProvider>(context,listen: false).reduceQuantity(cartProvider.items[index].sId);
                                          },
                                          child: CircleAvatar(
                                            radius: 12,
                                            backgroundColor: Colors.green.withOpacity(0.2),
                                            child:  Text("-",style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold
                                            ),),
                                          ),
                                        ),
                                        SizedBox(width: 7,),
                                        Text(cartProvider.items[index].quantity.toString(),

                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold
                                          ),),
                                        SizedBox(width: 7,),
                                        InkWell(
                                          onTap : (){
                                            Provider.of<CartProvider>(context,listen: false).addQuantity(cartProvider.items[index].sId);
                                          },
                                          child: CircleAvatar(
                                            radius: 12,
                                            backgroundColor: Colors.green,
                                            child:  Text("+",style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              //fontWeight: FontWeight.bold
                                            ),),
                                          ),
                                        ),
                                        // SizedBox(width: 50,),
                                        // Text("Price: ₹200",style: TextStyle(
                                        //   color: Colors.red,
                                        //   fontSize: 12,
                                        //   //fontWeight: FontWeight.bold
                                        // ),),

                                      ],
                                    ),
                                  )
                                ],
                              ),

                            ],
                          ),

                        ],
                      ),

                    ],
                  ),
                );
              }, );


        }
    );
  }
}
