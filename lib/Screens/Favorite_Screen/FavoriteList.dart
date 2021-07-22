import 'dart:convert';

import 'package:farmboxapp/Constraints.dart';
import 'package:farmboxapp/Helper/config.dart';
import 'package:farmboxapp/Models/FavoriteModel.dart';
import 'package:farmboxapp/Models/UserModel.dart';
import 'package:farmboxapp/Provider/FavoriteProvider.dart';
import 'package:farmboxapp/Provider/ProductProvider.dart';
import 'package:farmboxapp/Screens/Alert_Box/Dialog_alert.dart';
import 'package:farmboxapp/Screens/ProductScreen/DetailPage.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


class FavoriteList extends StatefulWidget {
  const FavoriteList({Key key}) : super(key: key);

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  Future favFuture;
  String userId="";
  List<Product> list;
  bool isFavorite=true;
  //ProductArguments= productid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //fetchProductData();
    // _fetchData();
    favFuture =_fetchData();
  }


  @override
  Widget build(BuildContext context) {
    //productid = ModalRoute.of(context).settings.arguments;
    final Size size = MediaQuery.of(context).size;
    var rating = 3.0;
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text("Favorite List",
          style: TextStyle(
              color: Colors.black,
              fontSize: 20
          ),),
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            }, icon:Icon(Icons.arrow_back,color: Colors.black,)),
      ),
      body:FutureBuilder(
        builder: (context, favouriteSnap) {
          if (favouriteSnap.connectionState == ConnectionState.none &&
              favouriteSnap.hasData == null) {
            return Container();
          }
          return favouriteSnap.data != null
              ?  ListView.builder(
              shrinkWrap: true,
              itemCount:favouriteSnap.data.length,
              itemBuilder: (context, index) {
                Product favorite = favouriteSnap.data[index];

                return Container(
                  margin: EdgeInsets.only(left: 20,right: 20,top: 20),

                  height: 100,
                  width: size.width*0.90,
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

                            height: 90,
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                                image: DecorationImage(
                                    image:NetworkImage(favorite.featuredImage),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(favorite.name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                ),),
                              SizedBox(height: 2,),
                              Row(
                                children: [
                                  SmoothStarRating(
                                      allowHalfRating: false,
                                      onRated: (v) {
                                      },
                                      starCount: 5,
                                      rating: 5,
                                      size: 18.0,
                                      isReadOnly:false,
                                      filledIconData: Icons.star,
                                      halfFilledIconData: Icons.star_half,
                                      color: Colors.amber,
                                      borderColor: Colors.amber,
                                      spacing:0.0
                                  ),
                                  SizedBox(width: 3,),
                                  Text("4.9",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 11,
                                      // fontWeight: FontWeight.bold
                                    ),),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Text("Weight:"+favorite.unit,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 11,
                                  // fontWeight: FontWeight.bold
                                ),),
                              SizedBox(height: 7,),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.green.withOpacity(0.2),
                                    child:  Text("-",style: TextStyle(
                                        color: PrimaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                    ),),
                                  ),
                                  SizedBox(width: 7,),
                                  Text("1",style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold
                                  ),),
                                  SizedBox(width: 7,),
                                  CircleAvatar(
                                    radius: 10,
                                    backgroundColor: PrimaryColor,
                                    child:  Text("+",style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      //fontWeight: FontWeight.bold
                                    ),),
                                  ),
                                  // SizedBox(width: 50,),
                                  // Text("Price: ₹200",style: TextStyle(
                                  //   color: Colors.red,
                                  //   fontSize: 12,
                                  //   //fontWeight: FontWeight.bold
                                  // ),),

                                ],
                              )
                            ],
                          ),
                          SizedBox(width: 10,),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                //SizedBox(height: 7,),
                                // isFavorite?IconButton(
                                //     onPressed:(){
                                //       setState(() {
                                //         isFavorite=isFavorite;
                                //
                                //       });
                                //     },
                                //     icon: Icon(Icons.favorite_rounded,color: Colors.red,size: 24,)
                                // ):IconButton(
                                //     onPressed:(){
                                //       setState(() {
                                //         isFavorite=!isFavorite;
                                //                 showDialog(context: context, builder: (BuildContext context) =>HistoryAlert(
                                //                   title: "Unfavorite",
                                //                   text: "               Are you sure you want to \n   remove this item from your favorite list?",
                                //                   button: "Unfavorite",
                                //                   press: (){},
                                //
                                //                 ));
                                //
                                //         });
                                //     },
                                //     icon: Icon(Icons.favorite_border_outlined,color: Colors.red,size: 24,)
                                // ),
                                IconButton(icon: isFavorite? Icon(Icons.favorite,
                                  color: Colors.red,size:25,):Icon(Icons.favorite_border_outlined,color: Colors.red,size: 25,),
                                  onPressed: (){
                                    setState(() {
                                      isFavorite=!isFavorite;
                                      showDialog(context: context, builder: (BuildContext context) =>HistoryAlert(
                                        title: "Unfavorite",
                                        text: "               Are you sure you want to \n   remove this item from your favorite list?",
                                        button: "Unfavorite",
                                        press: (){},

                                      ));
                                    });

                                  },
                                ),


                                SizedBox(height: 20,),
                                Text("Price:₹"+favorite.mrp.toString(),style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  //fontWeight: FontWeight.bold
                                ),),
                              ],
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
                );
              }):Container(
            color: Colors.green,
          );
        },
        future: favFuture,
      ),
    );
  }

  void getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String userDetails = prefs.getString("USER");
    print(userDetails);
    Userdetails user = Userdetails.fromJson(json.decode(userDetails));
    setState(() {
      userId = user.user.sId;
    });
  }

  // void fetchProductData() async{
  //     //args = ModalRoute.of(context).settings.arguments;
  //   final prefs = await SharedPreferences.getInstance();
  //   String userDetails = prefs.getString("USER");
  //   Userdetails user = Userdetails.fromJson(json.decode(userDetails));
  //   var url = Uri.parse(Config.BASE_URL + '/user/favourites/'+user.user.sId);
  //   final http.Response response = await http.get(
  //     url,
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Authorization': user.token,
  //     },
  //   );
  //   setState(() {
  //     list = (json.decode(response.body) as List)
  //         .map((data) => new FavoriteModel.fromJson(data))
  //         .toList();
  //     print(jsonEncode(response.body));
  //     //Provider.of<FavoriteProvider>(context, listen: false).setFavorite(list);
  //   });
  //
  //   }
  Future<void> _fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    String userDetails = prefs.getString("USER");
    Userdetails user = Userdetails.fromJson(json.decode(userDetails));
    String url = Config.BASE_URL + "/user/favourites/" + user.user.sId;
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': user.token
      },
    );

    var responseJson = json.decode(response.body);
    setState(() {
      list = (responseJson['products']['product'] as List)
          .map((data) => new Product.fromJson(data))
          .toList();

    });


    return list;
  }
}



