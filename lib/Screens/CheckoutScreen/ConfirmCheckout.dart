
import 'package:bexindia/Helper/config.dart';
import 'package:bexindia/Models/CartModel.dart';
import 'package:bexindia/Models/UserModel.dart';
import 'package:bexindia/Provider/CartProvider.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Constraints.dart';


class ConfirmCheckout extends StatefulWidget {
  @override
  _ConfirmCheckoutState createState() => _ConfirmCheckoutState();
}

class _ConfirmCheckoutState extends State<ConfirmCheckout> {
  String name = "", phone = "", userId = "", items = "", total = "", token = "";
  String userAddress, userLocation;
  String orderId="";
  static const platform = const MethodChannel("razorpay_flutter");
  Razorpay _razorpay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAddress();
    getUser();
    //fetchOrderId();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),
            onPressed: (){
              Navigator.pop(context);
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
            }),
        backgroundColor:Colors.white,
        elevation: 0,
        title:Text("Payment",style: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
            color: Colors.black
        )),
      ),
      body: SingleChildScrollView(
        child: Consumer<CartProvider>(builder: (context, cartProvider, child) {
          return Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.grey[300], spreadRadius: 2, blurRadius: 5)
                  ], color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                          child: Image.asset(
                            'assets/images/pay.png',
                            width: 100,
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "YOUR BILL",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(child: Text("Sub Total")),
                          Expanded(
                              child: Text(
                                  "Rs. " + (cartProvider.total).toString())),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      // Row(
                      //   children: <Widget>[
                      //     Expanded(child: Text("GST 15%")),
                      //     Expanded(
                      //         child:
                      //         Text("Rs. " + (cartProvider.gst).toString())),
                      //   ],
                      // ),

                      Row(
                        children: <Widget>[
                          Expanded(child: Text("Delivery Charges")),
                          Expanded(
                              child: Text("Rs. " +
                                  (cartProvider.deliveryCharge).toString())),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Divider(),
                      Row(
                        children: <Widget>[
                          Expanded(child: Text("Total Payable")),
                          Expanded(
                              child: Text("Rs. " +
                                  (cartProvider.grandTotal).toString())),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: RaisedButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Text(
                      "PAY ON DELIVERY",
                      style: TextStyle(
                          color: PrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        letterSpacing: 1.0
                      ),
                    ),
                    onPressed: () {
                      createOrder();
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: RaisedButton(
                    color:  PrimaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Text(
                      "PAY NOW",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          letterSpacing: 1.0),
                    ),
                    onPressed: () {
                      cardPayment();

                      makeProPurchase(double.parse(cartProvider.grandTotal.toString()));

                      // makeProPurchase(double.parse(cartProvider.grandTotal.toString()));

                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  void getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String userDetails = prefs.getString("USER");
    Userdetails user = Userdetails.fromJson(json.decode(userDetails));
    setState(() {
      name = user.user.name;
      phone = user.user.phone;
      userId = user.user.sId;
      token = user.token;
    });
  }

  void createOrder() async {

    String itms = "";
    int total = 0;
    int totalMrp = 0;
    double grandTotal = 0;
    //String items="";
    Map<String, dynamic> address = jsonDecode(userAddress);
    // String latitude = (jsonDecode(userLocation)['latitude']).toString();
    // String longitude = (jsonDecode(userLocation)['longitude']).toString();
     // List<CartModel> items =
     //    Provider.of<CartProvider>(context, listen: false).items;
    grandTotal = Provider.of<CartProvider>(context, listen: false).grandTotal;
    // final map =
    // items.asMap().map((key, value) => MapEntry(key, value)).values.toList();

    List<CartModel> items = Provider.of<CartProvider>(context,listen: false).items;
    for(int i=0;i< items.length;i++){
      //itms = "_id: "+ items[i].sId+","+ " name: "+items[i].name+ " qty: "+items[i].quantity.toString()+" mrp: "+items[i].mrp.toString();
      itms += items[i].name + " " + " x " + " " + items[i].quantity.toString() + " = " +(int.parse(items[i].mrp.toString()) * int.parse(items[i].quantity.toString())).toString() +",\n" ;
     total += (int.parse(items[i].sellingPrice.toString())* int.parse(items[i].quantity.toString()));
     print(itms);
   }
    final prefs = await SharedPreferences.getInstance();
    String userDetails = prefs.getString("USER");
    Userdetails user = Userdetails.fromJson(json.decode(userDetails));
    var url = Uri.parse(Config.BASE_URL + '/inventory/orders');

    print(" userAddress");
    final http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': user.token
      },
      body: jsonEncode(<String, dynamic>{
        "orderType": 1,
        "user" : userId,
        "cart" : itms,
        "address" : address,
        "status": "order placed",
        "total" : grandTotal.toString(),
       // "lat": latitude,
       // "lon": longitude
      }),
    );
    print(jsonEncode(response.body));
    Provider.of<CartProvider>(context,listen: false).flushCart();
    Navigator.pushNamedAndRemoveUntil(context, '/Payment-Success', (r) => false);

  }


  void cardPayment() async {

    String itms = "";
    int total = 0;
    int totalMrp = 0;
    double grandTotal = 0;
    //String items="";
    Map<String, dynamic> address = jsonDecode(userAddress);
    // String latitude = (jsonDecode(userLocation)['latitude']).toString();
    // String longitude = (jsonDecode(userLocation)['longitude']).toString();
    // List<CartModel> items =
    //    Provider.of<CartProvider>(context, listen: false).items;
    grandTotal = Provider.of<CartProvider>(context, listen: false).grandTotal;
    // final map =
    // items.asMap().map((key, value) => MapEntry(key, value)).values.toList();

    List<CartModel> items = Provider.of<CartProvider>(context,listen: false).items;
    for(int i=0;i< items.length;i++){
      //itms = "_id: "+ items[i].sId+","+ " name: "+items[i].name+ " qty: "+items[i].quantity.toString()+" mrp: "+items[i].mrp.toString();
      itms += items[i].name + " " + " x " + " " + items[i].quantity.toString() + " = " +(int.parse(items[i].mrp.toString()) * int.parse(items[i].quantity.toString())).toString() +",\n" ;
      total += (int.parse(items[i].sellingPrice.toString())* int.parse(items[i].quantity.toString()));
      print(itms);
    }
    final prefs = await SharedPreferences.getInstance();
    String userDetails = prefs.getString("USER");
    Userdetails user = Userdetails.fromJson(json.decode(userDetails));
    String orderId;
    var url = Uri.parse(Config.BASE_URL + '/inventory/orders');

    print(" userAddress");
    final http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': user.token
      },
      body: jsonEncode(<String, dynamic>{
         "orderType":0,
        "user" : userId,
        "cart" : itms,
        "address" : address,
        "status": "order placed",
        "total" : grandTotal.toString(),
        //"lat": latitude,
        // "lon": longitude
      }),
    );
    print(jsonEncode(response.body));
    Provider.of<CartProvider>(context,listen: false).flushCart();
    var responseJson = json.decode(response.body);
    orderId =responseJson['orderId'];

      {
        final prefs = await SharedPreferences.getInstance();
        String userDetails = prefs.getString("USER");
        Userdetails user = Userdetails.fromJson(json.decode(userDetails));
        String url = Config.BASE_URL + "/inventory/payment/status/" + orderId;

        final http.Response response = await http.put(
          url,
          headers: <String, String>{
            'Authorization': user.token,
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{"paymentDone":true}),
        );

      }


  }






  void paymentOnline() async{
    final prefs = await SharedPreferences.getInstance();
    String userDetails = prefs.getString("USER");
    Userdetails user = Userdetails.fromJson(json.decode(userDetails));
    String url = Config.BASE_URL + "/inventory/payment/status/" +orderId;

    final http.Response response = await http.put(
      url,
      headers: <String, String>{
        'Authorization': user.token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{"paymentDone":true}),
    );
    Navigator.pushNamedAndRemoveUntil(context, '/Payment-Success', (r) => false);
  }



  void makeProPurchase(double n) async {

    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount':n*100 ,
      "image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbkA8woKtZXzTvXx1EXeNjJhpUWJYe-zMORg&usqp=CAU",
      'name': 'Bex India',
      'description': 'Purchase Product',
      'external': {
        'wallets': ['paytm']
      },
      'theme': {
        "color": "#2980b9"
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    paymentOnline();
    // if payment is success - Handle rest of the tasks here

  }

  void _handlePaymentError(PaymentFailureResponse response) {

  }

  void _handleExternalWallet(ExternalWalletResponse response) {

  }

  void getAddress() async {
    final prefs = await SharedPreferences.getInstance();
    userAddress = prefs.getString("ADDRESS");
    userLocation = prefs.getString("LOCATION");

    print("location" + userLocation);
  }

}
