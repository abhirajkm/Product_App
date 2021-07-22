import 'dart:convert';


// import 'package:buyallfresh/helpers/PrefsHelper.dart';
// import 'package:buyallfresh/widgets/BottomNavigation.dart';
// import 'package:buyallfresh/widgets/LocateMe.dart';
// import 'package:buyallfresh/widgets/NavigationBar.dart';
import 'package:bexindia/Screens/OrdertrackScreen/tracks.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
 import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'locateme.dart';

class Ordertrack extends StatefulWidget {
  const Ordertrack({Key key}) : super(key: key);

  @override
  _OrdertrackState createState() => _OrdertrackState();
}

class _OrdertrackState extends State<Ordertrack> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getAddress();
  }
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 30,
          backgroundColor: Colors.transparent,
          elevation: 0,

          title: Padding(
            padding: const EdgeInsets.only(left:83.0),
            child: Text("Order Track",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
                fontSize: 20,wordSpacing: 1.5,fontFamily:'roboto' )),
          ),
          leading: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back,color:Colors.black,size: 25,)),
        ),
        body: SlidingUpPanel(
          panel: Center(
            child: Container(
              child: trackOrderPage(),



              // padding: EdgeInsets.all(10),
              // child: Column(
              //   children: [
              //     SizedBox(height: 5,),
              //     Icon(Icons.keyboard_arrow_up,color: Colors.green,),
              //     SizedBox(height: 10,),
              //     Text("Order Status",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 21),),
              //     SizedBox(
              //       height: 10,
              //     ),
              //     SizedBox(
              //       height: 20,
              //     ),
              //     SizedBox(
              //       height: 50,
              //       width: double.infinity,
              //       child: RaisedButton(
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(30)),
              //         ),
              //         onPressed: (){
              //           if(address1=="" || pincode == "" || phone == ""){
              //             showDialog(context: context,builder: (BuildContext context){
              //               return AlertDialog(
              //                 title: Text("Empty Delivery Point"),
              //                 content: Text("Please mention your delivery location"),
              //                 actions: <Widget>[
              //                   FlatButton(
              //                     child: Text("close"),
              //                     onPressed: (){
              //                       Navigator.of(context).pop();
              //                     },
              //                   )
              //                 ],
              //               );
              //             });
              //           }else{
              //             saveAddress();
              //             Navigator.pushNamed(context, "/confirm-checkout");
              //           }
              //
              //         },
              //         color: Colors.green,
              //         child: Text("",style: TextStyle(color: Colors.white),),
              //       ),
              //     )
              //   ],
              // ),
            ),
          ),
          body: Container(
            padding: EdgeInsets.only(bottom: 200),
            child: LocateMe(),
          ),
        ));
  }
  void saveAddress() {
    // PrefsHelper.setAddress(jsonEncode({"name" : name,"address1" : address1,"address2" : address2,"phone" : phone,"pincode" : pincode,"landmark":landmark}));
  }

// void getAddress() async{
//   final prefs = await SharedPreferences.getInstance();
//   String userAddress = prefs.getString("ADDRESS");
//   print("ADDRESS" + userAddress);
//   if(userAddress.length!=null){
//     nameController.text = jsonDecode(userAddress)['name'];
//     addr1Controller.text = jsonDecode(userAddress)['address1'];
//     addr2Controller.text = jsonDecode(userAddress)['address1'];
//     landmarkController.text = jsonDecode(userAddress)['landmark'];
//     phoneController.text = jsonDecode(userAddress)['phone'];
//     pincodeController.text = jsonDecode(userAddress)['pincode'];
//     name = jsonDecode(userAddress)['name'];
//     address1 = jsonDecode(userAddress)['address1'];
//     address2 = jsonDecode(userAddress)['address1'];
//     landmark = jsonDecode(userAddress)['landmark'];
//     phone = jsonDecode(userAddress)['phone'];
//     pincode = jsonDecode(userAddress)['pincode'];
//     print("ADDRESS1"+address1);
//   }
// }
}
