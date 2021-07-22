import 'dart:convert';


import 'package:bexindia/Models/ProductsModel.dart';
import 'package:bexindia/Models/UserModel.dart';
import 'package:bexindia/Provider/CartProvider.dart';



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Constraints.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'Components/NewAddress.dart';


class ReviewOrder extends StatefulWidget {
  const ReviewOrder({Key key}) : super(key: key);

  @override
  _ReviewOrderState createState() => _ReviewOrderState();
}

class _ReviewOrderState extends State<ReviewOrder> {

  int _selected;
  String addressid="",address="";
  List<ProductModel>list;
 String amount ;
  String name="",phone="",userId="";
  CheckoutArg pro;

  @override
  void initState() {
    super.initState();
    //createOrder();

    _selected = 0;

  }
  @override
  Widget build(BuildContext context) {
    pro = ModalRoute.of(context).settings.arguments;
    //return Consumer<UserDataProvider>(builder:(context,userProvider,child){
    return Scaffold(
        backgroundColor: BackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
         // shadowColor: Colors.black45,
          toolbarHeight: 50,
          elevation: 1,
          title: Padding(
            padding: const EdgeInsets.only(left:75.0),
            child: Text("Checkout",
              style: TextStyle(color: Colors.black,
                fontSize: 20,letterSpacing: 1.5 ),),
          ),
          leading: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back,color:Colors.black,size: 25,)),
        ),

        body: Consumer<CartProvider>(builder: (context, cartProvider, child) {
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Container(
                    height:350,
                    child: ListView.builder(
                      shrinkWrap: true,

                      itemCount: cartProvider.cartCount,
                      itemBuilder: (context, index) {
                        amount=cartProvider.items[index].total.toString();
                        return Container(
                          margin: EdgeInsets.all(4),
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(

                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(cartProvider.items[index].name,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    // fontWeight: FontWeight.bold
                                  )),
                              Text(cartProvider.items[index].quantity.toString(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    // fontWeight: FontWeight.bold
                                  )),
                              Text("*",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    //fontWeight: FontWeight.bold
                                  )),
                              Text("₹"+cartProvider.items[index].sellingPrice.toString(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    //fontWeight: FontWeight.bold
                                  )),
                            ],
                          ),
                        );
                      },),
                  ),
                  Divider(thickness: 0,color: Colors.black,),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Grand Total",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w600
                            )),
                        Text(cartProvider.cartCount.toString(),
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w600
                            )),
                        Text("*",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w600
                            )),
                        Text("₹" + cartProvider.total.toString(),
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w600
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: 60,),

                  SizedBox(height: 10,),

                  SizedBox(height: 10,),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)
                            ),
                            primary: PrimaryColor
                        ),
                        onPressed: (){
                        // makeProPurchase(int.parse(cartProvider.total.toString()));
                          //getProDetails();
                         // createOrder();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyAddress()));
                        },
                        child: Text("Checkout".toUpperCase(),
                          style: TextStyle(
                              fontSize: 18,


                              letterSpacing: 1.0,

                              color: Colors.white,
                              fontWeight: FontWeight.w600
                          ),)),
                  )
                ],
              ),
            ),
          );
        },)
    );
  }
  // Future getProDetails() async {
  //   final http.Response response = await http.get(
  //       Config.BASE_URL + '/inventory/product/'+pro.id,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       });
  //   list = (json.decode(response.body) as List)
  //       .map((data) => new ProductModel.fromJson(data))
  //       .toList();
  //   print(json.decode(response.body));
  // }

  void getUser() async{
    final prefs = await SharedPreferences.getInstance();
    String userDetails = prefs.getString("USER");
    print(userDetails);
    Userdetails user = Userdetails.fromJson(json.decode(userDetails));
    setState(() {
      name = user.user.name;
      phone = user.user.phone;
      userId = user.user.sId;
    });

  }


  // void createOrder() async{
  //
  //   String itms = "";
  //   int total = 0;
  //   int totalMrp = 0;
  //   double grandTotal = 0;
  //     //String items="";
  //   List<CartModel> items =
  //       Provider.of<CartProvider>(context, listen: false).items;
  //   grandTotal = Provider.of<CartProvider>(context, listen: false).grandTotal;
  //   final map =
  //   items.asMap().map((key, value) => MapEntry(key, value)).values.toString();
  //
  //   final prefs = await SharedPreferences.getInstance();
  //   String userDetails = prefs.getString("USER");
  //   Userdetails user = Userdetails.fromJson(json.decode(userDetails));
  //   var url = Uri.parse(Config.BASE_URL + '/inventory/orders');
  //   final http.Response response = await http.post(
  //     url,
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Authorization': user.token
  //     },
  //     body: jsonEncode(<String, dynamic>{
  //       "user" : userId,
  //       "items" : map,
  //       "address" : address,
  //       "total" : grandTotal.toString()
  //     }),
  //   );
  //   print(jsonEncode(response.body));
  //   Provider.of<CartProvider>(context,listen: false).flushCart();
  //   //Navigator.pushNamed(context, '/all-orders');
  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryGrid()));
  // }

}



class CheckoutArg {
  String id,price,name;
  CheckoutArg({
    this.id,this.price,this.name
  });
}
