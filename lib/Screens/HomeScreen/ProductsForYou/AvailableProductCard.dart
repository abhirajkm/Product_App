import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../../../Constraints.dart';

class AvailableProCard extends StatelessWidget {
  const AvailableProCard({
    Key key,
    @required this.rating,
    this.price,
    this.name,
    this.mrp,
    this.weight,
    this.image,
    this.offer
  }) : super(key: key);
 final String offer, weight, image, name;
 final int price,mrp;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return  Container(
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
                      image:NetworkImage(image),
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
                  color: PrimaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(6),
                      topLeft: Radius.circular(3),
                      topRight: Radius.circular(6)
                  )
              ),
              child: Center(
                child: Text(weight,style: TextStyle(
                    color: Colors.white,
                    fontSize:10,
                    fontWeight: FontWeight.w600
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
                  child: Text(name,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold
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
                            color: PrimaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600
                        ),),
                      Text("₹ "+mrp.toString(),
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                            fontWeight: FontWeight.w600
                        ),),
                      SizedBox(width: 3,),
                      Text(price.toString(),
                        style: TextStyle(
                            color: PrimaryColor,
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
    );
  }
}
