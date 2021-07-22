import 'dart:convert';


import 'package:bexindia/Helper/config.dart';
import 'package:bexindia/Models/CartModel.dart';
import 'package:bexindia/Models/UserModel.dart';
import 'package:bexindia/Provider/CartProvider.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:badges/badges.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../Constraints.dart';


class ProductDetail extends StatefulWidget {
  const ProductDetail({Key key}) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  var rating = 3.0;

  ProductArguments productid;
  int quantity = 0;

  String image = "", name = "", description = "", price = "", weight = "",featuredImage="",unit="";
  int mrp;
  String userId="";
  bool _favStatus = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ignore: unnecessary_statements

    getUser();
    isFavourite();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
   // getProductDetails();
  }

  @override
  Widget build(BuildContext context) {
    productid = ModalRoute.of(context).settings.arguments;
    //getProductDetails();
    //getDetails();

    final Size size = MediaQuery.of(context).size;
    return Consumer<CartProvider>(builder: (context, cartProvider, child) {
      return Scaffold(
        backgroundColor: BackgroundColor,
        //backgroundColor: Colors.white70,
        appBar: AppBar(
          title: Text(
            "Product Details",
            style: TextStyle(
              color: Colors.black,
                letterSpacing: 1.5
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                onPressed: () {}),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                onTap: (){
                  Navigator.pushReplacementNamed(context, "/myCart");
                },
                child: Badge(
                  badgeColor: PrimaryColor,
                  position: BadgePosition.topEnd(top: 4),
                  badgeContent: Text(
                    cartProvider.cartCount.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                  child: Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                    size: 23,
                  ),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: size.height * 0.90,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
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
                    //   IconButton(
                    //       icon: _favStatus
                    //    ? Icon(Icons.favorite_outlined,
                    //   color: Colors.red)
                    //    : Icon(Icons.favorite_outline_sharp,
                    //     color: Colors.red,
                    //    ),
                    //   iconSize: 30,
                    //    onPressed: () {
                    //     _favStatus == !_favStatus
                    //        ? removeFavourite()
                    //       : addFavourite();
                    //      },
                    // ),

                      _favStatus?IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 25,
                          ),

                          onPressed: () {
                            setState(() {
                              _favStatus = !_favStatus;
                              removeFavourite();
                            });
                          }):
                      IconButton(
                          icon: Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                            size: 25,
                          ),

                          onPressed: () {
                            setState(() {
                              _favStatus = !_favStatus;
                              addFavourite();
                            });
                          }),
                      Positioned(
                        top: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.only(left: 0, top: 30),
                              height: 230,
                              width: 250,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                // image: DecorationImage(
                                //   image:NetworkImage(image),)
                              ),
                              child: Image.network(
                                productid.featuredImage,
                              fit: BoxFit.contain,),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: Container(
                          height: 20,
                          width: 50,
                          decoration: BoxDecoration(
                              color: PrimaryColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                //topLeft: Radius.circular(5),
                                topRight: Radius.circular(10),
                              )),
                          child: Center(
                            child: Text(
                              productid.unit,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 280,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  productid.name,
                                  style: TextStyle(

                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Center(
                                child: SmoothStarRating(
                                    allowHalfRating: false,
                                    onRated: (v) {},
                                    starCount: 5,
                                    rating: rating,
                                    size: 25.0,
                                    isReadOnly: false,
                                    filledIconData: Icons.star,
                                    halfFilledIconData: Icons.star_half,
                                    color: Colors.amber,
                                    borderColor: Colors.amber,
                                    spacing: 0.0),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                //height: 90,
                                width: 300,
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        productid.description,textAlign: TextAlign.justify,
                                        maxLines: 6,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,


                                            //letterSpacing: 1.5
                                            height: 1.2),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Center(
                                child: Text("MRP: ₹"+productid.mrp.toString(),
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      decoration: TextDecoration.lineThrough,
                                     // fontWeight: FontWeight.bold
                                  ),),
                              ),
                              SizedBox(height:10,),
                              Center(
                                child: Text("Offer Price: ₹"+productid.sellingPrice.toString(),
                                  style: TextStyle(
                                      color: PrimaryColor,
                                      fontSize: 16,

                                      fontWeight: FontWeight.w600
                                  ),),
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Container(
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:PrimaryColor.withOpacity(0.09)),
                                              child: IconButton(
                                                  icon: Icon(
                                                    Icons.remove,
                                                    size: 17,
                                                    color: PrimaryColor,
                                                  ),
                                                  onPressed: (){
                                                    removeItem();
                                                  })),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            quantity.toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Container(
                                              height: 30,
                                              //width: 30,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: PrimaryColor),
                                              child: Center(
                                                  child: IconButton(
                                                      icon: Icon(
                                                        Icons.add,
                                                        size: 17,
                                                        color: Colors.white,
                                                      ),
                                                      onPressed: (){
                                                        addQty();
                                                      }))),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 130,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        primary: PrimaryColor
                                      ),
                                        onPressed: (){

                                        setState(() {
                                          addItem();
                                        });

                                          },

                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(Icons.add_shopping_cart,size: 15,color: Colors.white,),

                                            Text("Add to Cart",
                                              style:TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15
                                              ) ,)
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Padding(
                //   padding: const EdgeInsets.all(10.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         "Recommended Product",
                //         style: TextStyle(
                //             color: Colors.black,
                //             fontSize: 18,
                //             fontWeight: FontWeight.bold),
                //       ),
                //       InkWell(
                //         onTap: () {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (context) => RecViewAll()));
                //         },
                //         child: Text(
                //           "View All",
                //           style: TextStyle(
                //               color: Colors.red,
                //               fontSize: 18,
                //               fontWeight: FontWeight.bold),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 230, child: RecommendedGrid())
              ],
            ),
          ),
        ),
      );
    },);
  }
  void addItem()  {

      setState(() {
      if (quantity==0){
        final scaffold = ScaffoldMessenger.of(context);
        scaffold.showSnackBar(
          SnackBar(
            content: Container(
              //color: Colors.redAccent.shade100,
                height: 40,
                child: Text('Select Quantity',style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20
                ),)),
            //action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),

          ),
        );

      }
     else{
        CartModel item = new CartModel(
          name: productid.name,
          code: productid.code,
          sId: productid.sId,
          unit: productid.unit,
          featuredImage: productid.featuredImage,
          description: productid.description,
          mrp: productid.mrp,
          sellingPrice: productid.sellingPrice,
          quantity: quantity,
          category: productid.category,

          // total: (double.parse(args.price) * quantity).toString()
        );
        Provider.of<CartProvider>(context, listen: false).addToCart(item);

        quantity=0;


      }

    });
  }


  void addQty() {
    setState(() {
      quantity += 1;
      Provider.of<CartProvider>(context,listen: false).addQuantity(productid.sId);
    });
  }

  void removeItem() {
    setState(() {
      if (quantity != 0) {
        quantity -= 1;

        Provider.of<CartProvider>(context,listen: false).reduceQuantity(productid.sId);

      }
    });
  }

  void isFavourite() async {
    final prefs = await SharedPreferences.getInstance();
    String userDetails = prefs.getString("USER");
    if(userDetails == null || userDetails == "") {
    }
    else{
      Userdetails user = Userdetails.fromJson(json.decode(userDetails));
      String url = Config.BASE_URL +
          "/user/favourite/product/" +
          user.user.sId +
          "&" +
          productid.sId;
      final http.Response response = await http.get(
        url,
        headers: <String, String>{
          'Authorization': user.token,
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var responseJson = json.decode(response.body);
      quantity= 0;
      setState(() {

        _favStatus = responseJson['success'];
      });}
  }

  void addFavourite() async {
    final prefs = await SharedPreferences.getInstance();
    String userDetails = prefs.getString("USER");
    Userdetails user = Userdetails.fromJson(json.decode(userDetails));
    String url = Config.BASE_URL + "/user/favourites";
    final http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Authorization': user.token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{"product": productid.sId}),
    );
    isFavourite();
    print(jsonEncode(response.body));
  }

  void removeFavourite() async {
    final prefs = await SharedPreferences.getInstance();
    String userDetails = prefs.getString("USER");
    Userdetails user = Userdetails.fromJson(json.decode(userDetails));
    String url = Config.BASE_URL + "/user/favourites";
    final http.Response response = await http.put(
      url,
      headers: <String, String>{
        'Authorization': user.token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{"user": user.user.sId, "product": productid.sId}),
    );
    isFavourite();
    print(jsonEncode(response.body));
  }

  void getUser() async{
    final prefs = await SharedPreferences.getInstance();
    String userDetails = prefs.getString("USER");
    //print(userDetails);
    Userdetails user = Userdetails.fromJson(json.decode(userDetails));
    setState(() {
      name = user.user.name;
      userId = user.user.sId;
    });

  }


  // void getProductDetails() async {
  //   final http.Response response = await http.get(
  //       Config.BASE_URL + '/inventory/product/' + productid.id,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       });
  //   print(json.decode(response.body).toString());
  //   setState(() {
  //     productid.name = json.decode(response.body)["name"];
  //     productid.featuredImage = json.decode(response.body)["featured_image"];
  //     productid.mrp = json.decode(response.body)["mrp"];
  //     productid.description = json.decode(response.body)["description"];
  //     productid.unit = json.decode(response.body)["unit"];
  //   });
  // }


}

class ProductArguments {
  bool featured;
  String sId;
  String name;
  String code;
  String unit;
  String featuredImage;
  String category;
  int mrp;
  int sellingPrice;
  int quantity;
  String total;
  String description;

  ProductArguments(
      {this.featured,
        this.sId,
        this.name,
        this.code,
        this.unit,
        this.featuredImage,
        this.category,
        this.mrp,
        this.sellingPrice,
        this.quantity,
        this.total,
        this.description});

}
