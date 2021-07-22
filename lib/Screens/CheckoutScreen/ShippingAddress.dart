import 'dart:convert';

import 'package:bexindia/Helper/config.dart';
import 'package:bexindia/Models/UserModel.dart';
import 'package:bexindia/Provider/CartProvider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Constraints.dart';

class ShippingAddress extends StatefulWidget {
  @override
  _ShippingAddressState createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  TextEditingController name= TextEditingController();
  TextEditingController address1= TextEditingController();
  TextEditingController address2= TextEditingController();
  TextEditingController landmark= TextEditingController();
  TextEditingController phone= TextEditingController();
  TextEditingController pincode= TextEditingController();

  final GlobalKey _formGlobalKey=GlobalKey();

  String countryCode ="+91",token = "", userId="";
  bool args;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),
            onPressed: (){
              Navigator.pop(context);
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
            }),
        backgroundColor:Colors.white,
        elevation: 0,
        title:Text("My Address",style: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
            color: Colors.black
        )),
      ),
      body: Consumer<CartProvider>(builder: (context, cartProvider, child) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formGlobalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                TextFormField(
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  controller: name,
                  decoration: InputDecoration(

                    hintText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    hintStyle:
                    TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: Icon(
                      Icons.supervised_user_circle,
                      color: PrimaryColor,
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Require';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.black,

                  controller: address1,

                  decoration: InputDecoration(
                    hintText: "Address, Line 1",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)
                    ),
                    hintStyle:
                    TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: Icon(
                      Icons.location_pin,
                      color: PrimaryColor,
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Require';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.black,

                  controller: address2,

                  decoration: InputDecoration(
                    hintText: "Address, Line 2",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)
                    ),
                    hintStyle:
                    TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: Icon(
                      Icons.location_pin,
                      color: PrimaryColor,
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Require';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        style: TextStyle(color: Colors.black),
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.phone,
                        controller: new TextEditingController(text: countryCode),
                        decoration: InputDecoration(

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                          prefixIcon: Icon(
                            CupertinoIcons.globe,
                            color: PrimaryColor,
                          ),
                        ),
                      ),
                      flex: 2,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        cursorColor: Colors.black,
                        controller: phone,
                        decoration: InputDecoration(
                          hintText: "Phone Number",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                          prefixIcon: Icon(
                            Icons.phone_iphone,
                            color: PrimaryColor,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10)
                        ],
                        validator: (value) {
                          if (value == null || value.length!=10) {
                            return 'Enter valid phone number';
                          }
                          return null;
                        },
                      ),
                      flex: 4,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.black,

                  controller: landmark,
                  decoration: InputDecoration(
                    hintText: "Landmark",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)
                      ),
                    hintStyle:
                    TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: Icon(
                      Icons.location_on,
                      color: PrimaryColor,
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Require';
                  //   }
                  //   return null;
                  // },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.black,

                  controller: pincode,
                  decoration: InputDecoration(
                    hintText: "Pincode",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)
                    ),
                    hintStyle:
                    TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: Icon(
                      Icons.pin_drop,
                      color: PrimaryColor,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6)
                  ],
                  validator: (value) {
                    if (value == null || value.length!=6) {
                      return 'Enter valid Pin Code';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: RaisedButton(
                    child: Text(
                      "SAVE ADDRESS",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.0),
                    ),
                    color: PrimaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(30))),
                    onPressed: () {
                      final FormState form = _formGlobalKey.currentState;
                      if(form.validate()){
                        addAddress();
                        //Navigator.push(context,MaterialPageRoute(builder: (context)=>SignIn()));
                      }

                    },
                  ),
                ),
              ],
            ),
          ),
        );

      }),
    );
  }
  void getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String userDetails = prefs.getString("USER");
    print(userDetails);
    Userdetails user = Userdetails.fromJson(json.decode(userDetails));
    setState(() {
      userId = user.user.sId;
      token = user.token;
    });
  }


  void addAddress() async {
    String url = Config.BASE_URL + "/auth/user/address";

    final http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Authorization': token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "name": name.text,
        "address_line1":  address1.text,
        "address_line2": address2.text ,
        "pincode":  pincode.text ,
        "landmark": landmark.text ,
        "phone":  countryCode+phone.text,
        "id": userId,
      }),
    );
    name.clear();
    address1.clear();
    address2.clear();
    pincode.clear();
    landmark.clear();
    phone.clear();


    Navigator.pushNamed(context, "/my-address", arguments: args);

  }

}
