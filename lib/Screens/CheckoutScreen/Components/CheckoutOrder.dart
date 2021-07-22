import 'dart:convert';
import 'package:farmboxapp/Constraints.dart';
import 'package:farmboxapp/Helper/PrefsHelper.dart';
import 'package:farmboxapp/Screens/OrdertrackScreen/locateme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  String address_line1="",address_line2 = "",landmark="",phone="",pincode="",name="";
  final addr1Controller = TextEditingController();
  final addr2Controller = TextEditingController();
  final phoneController = TextEditingController();
  final pincodeController = TextEditingController();
  final landmarkController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAddress();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),
              onPressed: (){
                Navigator.pop(context);
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
              }),
          backgroundColor:Colors.white,
          elevation: 0,
          title:Text("Checkout",style: TextStyle(
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
              color: Colors.black
          )),
        ),
        body: SlidingUpPanel(
          maxHeight: 585,
          panel: Center(
            child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(height: 5,),
                  Icon(Icons.keyboard_arrow_up,color: Colors.green,),
                  SizedBox(height: 10,),
                  Text("DELIVERY ADDRESS",style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextField(

                      style: TextStyle(color: Colors.black),
                      cursorColor: Colors.black,
                      controller: nameController,
                      onChanged: (String value){
                        setState(() {
                          name = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Full Name",
                        labelText: "Full Name",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                        prefixIcon: Icon(
                          Icons.supervised_user_circle,
                          color: Colors.green[800],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      controller: addr1Controller,
                      onChanged: (String value){
                        setState(() {
                          address_line1 = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Address, Line 1",
                        labelText: "Address Line 1",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        prefixIcon: Icon(
                          Icons.location_pin,
                          color: Colors.green[800],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  SizedBox(
                    height: 50,
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      controller: addr2Controller,
                      onChanged: (String value){
                        setState(() {
                          address_line2 = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Address, Line 2",
                        labelText: "Address, Line 2",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        prefixIcon: Icon(
                          Icons.location_pin,
                          color: Colors.green[800],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      controller: phoneController,
                      onChanged: (String value){
                        setState(() {
                          phone = value;
                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Phone Number",
                        labelText:"Phone Number" ,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: PrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      controller: pincodeController,
                      onChanged: (String value){
                        setState(() {
                          pincode = value;
                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Pincode",
                        labelText:"Pincode" ,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        prefixIcon: Icon(
                          Icons.pin_drop,
                          color: PrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      controller: landmarkController,
                      onChanged: (String value){
                        setState(() {
                          landmark = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Landmark",
                        labelText:"Landmark",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        prefixIcon: Icon(
                          Icons.location_on,
                          color: PrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      onPressed: (){
                        if(address_line1=="" || pincode == "" || phone == ""){
                          showDialog(context: context,builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("Empty Delivery Point"),
                              content: Text("Please mention your delivery location"),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("close"),
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                        }else{
                          saveAddress();
                          Navigator.pushNamed(context, "/confirm-checkout");
                        }

                      },
                      color: PrimaryColor,
                      child: Text("CHECKOUT",style: TextStyle(color: Colors.white,
                          letterSpacing:1.0,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600
                      ),),
                    ),
                  )
                ],
              ),
            ),
          ),
          body: Container(
            padding: EdgeInsets.only(bottom: 200),
            child: LocateMe(),
          ),
        ));
  }

  void saveAddress() {

    PrefsHelper.setAddress(jsonEncode({"name" : name,"address_line1" : address_line1,"address_line2" : address_line2,"phone" : phone,"pincode" : pincode,"landmark":landmark}));
  }

  void getAddress() async{
    final prefs = await SharedPreferences.getInstance();
    String userAddress = prefs.getString("ADDRESS");


    //print("ADDRESS" + userAddress);
    if(userAddress.length!=null){
      nameController.text = jsonDecode(userAddress)['name'];
      addr1Controller.text = jsonDecode(userAddress)['address_line1'];
      addr2Controller.text = jsonDecode(userAddress)['address_line2'];
      landmarkController.text = jsonDecode(userAddress)['landmark'];
      phoneController.text = jsonDecode(userAddress)['phone'];
      pincodeController.text = jsonDecode(userAddress)['pincode'];
      name = jsonDecode(userAddress)['name'];
      address_line1 = jsonDecode(userAddress)['address_line1'];
      address_line2 = jsonDecode(userAddress)['address_line2'];
      landmark = jsonDecode(userAddress)['landmark'];
      phone = jsonDecode(userAddress)['phone'];
      pincode = jsonDecode(userAddress)['pincode'];

    }
  }
}
