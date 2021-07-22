
import 'package:farmboxapp/Constraints.dart';
import 'package:farmboxapp/Helper/config.dart';
import 'package:farmboxapp/Models/CartModel.dart';
import 'package:farmboxapp/Models/UserModel.dart';
import 'package:farmboxapp/Provider/CartProvider.dart';
import 'package:farmboxapp/Screens/BottomNavigation.dart';
import 'package:farmboxapp/Screens/PaymentScreen/paymentsuccess.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


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
      "image" : "data:image/png;base64,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",
      'name': 'Farm Box',
      'description': 'Purchase Product',
      'external': {
        'wallets': ['paytm']
      },
      'theme': {
        "color": "#05A21C"
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
