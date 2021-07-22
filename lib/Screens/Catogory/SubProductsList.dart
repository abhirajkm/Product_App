import 'dart:convert';
import 'package:badges/badges.dart';
import 'package:bexindia/Helper/config.dart';
import 'package:bexindia/Models/ProductsModel.dart';
import 'package:bexindia/Models/UserModel.dart';
import 'package:bexindia/Provider/CartProvider.dart';
import 'package:bexindia/Provider/ProductProvider.dart';
import 'package:bexindia/Screens/ProductScreen/DetailPage.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';


import '../../Constraints.dart';
class SubCategoryList extends StatefulWidget {

  const SubCategoryList({Key key}) : super(key: key);

  @override
  _SubCategoryListState createState() => _SubCategoryListState();
}

class _SubCategoryListState extends State<SubCategoryList> {
  List<ProductModel> list;
  SubCategoryArguments args;
  bool isSearching = false;
  bool _favStatus = false;
  int quantity = 0;
  String productid;
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    args = ModalRoute
        .of(context)
        .settings
        .arguments;
    fetchData();
    final Size size = MediaQuery.of(context).size;
    return Consumer<ProductsProvider>(builder: (context, productProvider, child) {
      return Scaffold(
        backgroundColor: BackgroundColor,
        appBar: AppBar(
          title: !isSearching
              ? Text(args.category,
            style: TextStyle(
                color: Colors.black,
                letterSpacing: 1.5,


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
          backgroundColor:BackgroundColor,
          // backgroundColor: Colors.white,
          elevation: 1,
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
                });
              },
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

            Consumer<CartProvider>(builder: (context, cartProvider, child) {
              return  InkWell(
                onTap: (){
                  Navigator.pushReplacementNamed(context, "/myCart");
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Badge(
                    badgeColor: PrimaryColor,
                    position: BadgePosition.topEnd(top: 2),
                    badgeContent: Text(cartProvider.cartCount.toString(),style: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.w600),),
                    child: Icon(Icons.shopping_cart,color: Colors.black,size: 23,),
                  ),
                ),
              );
            },),
          ],
        ) ,
        body: Container(
          height: size.height,
          margin: EdgeInsets.all(20),
          child: productProvider.count>0?GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 7.0,

                childAspectRatio: 0.70
            ),
            itemCount: productProvider.count,
            // itemBuilder:(context, index) => ListCard(rating: 4.0),
            itemBuilder: (context, index) {

              return GestureDetector(

                  onTap: (){
                Navigator.pushNamed(context, "/prodetail",arguments: new ProductArguments(
                  sId: productProvider.items[index].sId,
                    name: productProvider.items[index].name,
                    code:productProvider.items[index].code ,
                    description: productProvider.items[index].description,
                    sellingPrice: productProvider.items[index].sellingPrice,
                    mrp: productProvider.items[index].mrp,
                    featuredImage: productProvider.items[index].featuredImage,
                    unit: productProvider.items[index].unit,
                    category:productProvider.items[index].category
                ));
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail()));
              },
              child: Container(
                // margin: EdgeInsets.all(10),
                // height: 100,
                width: 160,
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
                child:Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // _favStatus?IconButton(
                        //     icon: Icon(
                        //       Icons.favorite,
                        //       color: Colors.red,
                        //       size: 25,
                        //     ),
                        //
                        //     onPressed: () {
                        //       setState(() {
                        //         _favStatus = !_favStatus;
                        //         removeFavourite(productProvider.items[index].sId);
                        //       });
                        //     }):
                        // IconButton(
                        //     icon: Icon(
                        //       Icons.favorite_border,
                        //       color: Colors.red,
                        //       size: 25,
                        //     ),
                        //
                        //     onPressed: () {
                        //       setState(() {
                        //         _favStatus = !_favStatus;
                        //         addFavourite(productid);
                        //       });
                        //     }),

                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Container(
                            height: 15,
                            width: 30,
                            decoration: BoxDecoration(
                                color: PrimaryColor,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("4.0",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w600
                                  ),),
                                Icon(Icons.star,color: Colors.yellow,size: 11,)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                      //margin: EdgeInsets.only(left:45,top: 20),
                      height: 80,
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
                    Divider(color: PrimaryColor.withOpacity(0.4),),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.only(left: 4,right: 4),
                      child: Center(
                        child: Text(productProvider.items[index].name,
                          style: TextStyle(
                              color: PrimaryColor,



                              fontSize: 12,

                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text("Weight: "+productProvider.items[index].unit,
                      style: TextStyle(
                          color:Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Price: ",
                          style: TextStyle(

                            

                              color: PrimaryColor,
                              fontSize: 11,

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
                              color: PrimaryColor,
                              fontSize: 12,

                              fontWeight: FontWeight.w600
                          ),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     CircleAvatar(
                    //       radius: 8,
                    //       backgroundColor: Colors.green.withOpacity(0.2),
                    //       child:  Text("-",style: TextStyle(
                    //           color: PrimaryColor,
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.bold
                    //       ),),
                    //     ),
                    //     SizedBox(width: 7,),
                    //     Text("1",style: TextStyle(
                    //         color: Colors.black,
                    //         fontSize: 10,
                    //         fontWeight: FontWeight.bold
                    //     ),),
                    //     SizedBox(width: 7,),
                    //     CircleAvatar(
                    //       radius: 8,
                    //       backgroundColor: PrimaryColor,
                    //       child:  Text("+",style: TextStyle(
                    //         color: Colors.white,
                    //         fontSize: 14,
                    //         //fontWeight: FontWeight.bold
                    //       ),),
                    //     ),
                    //
                    //
                    //   ],
                    // )

                  ],
                ),
              ),


              );
            }
          ):Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.blue,
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Colors.green[100]))),
            ],
          )
        ) ,
      );
    },);
  }

  void fetchData() async{
    //args = ModalRoute.of(context).settings.arguments;
    print(args.category);
    String url = Config.BASE_URL + "/inventory/category/"+args.category;

    final response = await http.get(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },);
    list = (json.decode(response.body) as List).map((data)=>new ProductModel.fromJson(data)).toList();
    Provider.of<ProductsProvider>(context,listen: false).setProducts(list);
    print(response.body);
  }

  void isFavourite(productid) async {
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
          productid;
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

  void addFavourite(productid) async {
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
          <String, String>{"product": productid}),
    );
    isFavourite(productid);
    print(jsonEncode(response.body));
  }

  void removeFavourite(productid) async {
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
          <String, String>{"user": user.user.sId, "product": productid}),
    );
    isFavourite(productid);
    print(jsonEncode(response.body));
  }
}

class SubCategoryArguments{
  String category;
  SubCategoryArguments({this.category});
}
