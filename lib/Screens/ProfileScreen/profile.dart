
import 'dart:convert';

import 'package:farmboxapp/Models/UserModel.dart';
import 'package:farmboxapp/Screens/About&Terms&Condition/AboutUs.dart';
import 'package:farmboxapp/Screens/About&Terms&Condition/TermsConditions.dart';

import 'package:farmboxapp/Constraints.dart';
import 'package:farmboxapp/Screens/CheckoutScreen/ShippingAddress.dart';
import 'package:farmboxapp/Screens/Favorite_Screen/FavoriteList.dart';


import 'package:farmboxapp/Screens/HelpLivechatandPrivacyScreen/help.dart';
import 'package:farmboxapp/Screens/CheckoutScreen/Components/NewAddress.dart';
import 'package:farmboxapp/Screens/ProfileScreen/AddAddres.dart';
import 'package:farmboxapp/Screens/ProfileScreen/logout.dart';
import 'package:farmboxapp/Screens/ResetPasswordScreen/resetpassword.dart';


import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 50.0),
          child: Text("My Account",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  letterSpacing: 1.5,
                  //wordSpacing: 1.5,
                  fontFamily: 'roboto')),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, "/home");
             // Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
              size: 20,
            )),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 160,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 30, 50, 00),
                    child: Stack(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 45,
                          child: ClipOval(
                            child:

                            Image.asset(
                              'assets/logoo.png',
                              height: 150,
                              width: 150,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        // Positioned(
                        //     bottom: 2,
                        //     right: 1,
                        //     child: Container(
                        //       height: 35,
                        //       width: 35,
                        //       child: Icon(
                        //         Icons.add_a_photo,
                        //         color: Colors.white,
                        //       ),
                        //       decoration: BoxDecoration(
                        //           color: Colors.green,
                        //           borderRadius:
                        //               BorderRadius.all(Radius.circular(20))),
                        //     ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: BackgroundColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Resetpassword()));
                        },
                        child: ListTile(
                          title: Container(
                            transform: Matrix4.translationValues(-25, 0, 0),
                            child: Text("Change Password"),
                          ),
                          leading: Icon(
                            Icons.lock,
                            size: 20,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, "/my-orders");
                        },
                        child: ListTile(
                          title: Container(
                            transform: Matrix4.translationValues(-25, 0, 0),
                            child: Text("Order History"),
                          ),
                          leading: Icon(
                            Icons.settings_backup_restore_outlined,
                            size: 20,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>FavList()));
                        },
                        child: ListTile(
                          title: Container(
                            transform: Matrix4.translationValues(-25, 0, 0),
                            child: Text("Favorites"),
                          ),
                          leading: Icon(
                            Icons.favorite,
                            size: 20,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                         Navigator.push(context,
                             MaterialPageRoute(builder: (context)=>AddAddress()));
                        },
                        child: ListTile(
                          title: Container(
                            transform: Matrix4.translationValues(-25, 0, 0),
                            child: Text("Delivery Address"),
                          ),
                          leading: Icon(
                            Icons.location_on_outlined,
                            size: 20,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>TermsandConditions()));
                        },
                        child: ListTile(
                          title: Container(
                              transform: Matrix4.translationValues(-25, 0, 0),
                              child: Text("Terms & Conditions")),
                          leading: Icon(
                            Icons.book_online_outlined,
                            size: 20,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Help()));
                        },
                        child: ListTile(
                          title: Container(
                            transform: Matrix4.translationValues(-25, 0, 0),
                            child: Text("Help"),
                          ),
                          leading: Icon(
                            Icons.chat,
                            size: 20,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>About()));
                        },
                        child: ListTile(
                          title: Container(
                            transform: Matrix4.translationValues(-25, 0, 0),
                            child: Text("About Us"),
                          ),
                          leading: Icon(
                            Icons.add_business,
                            size: 20,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          showDialog(context: context, builder: (BuildContext context) => AlertLog());
                        },
                        child: ListTile(
                          title: Container(
                            transform: Matrix4.translationValues(-25, 0, 0),
                            child: Text("Logout"),
                          ),
                          leading: Icon(
                            Icons.logout,
                            size: 20,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void fetchInfo() async {
    final prefs = await SharedPreferences.getInstance();
    String userDetails = prefs.getString("USER");
    Userdetails details = Userdetails.fromJson(
        json.decode(userDetails)
    );
    setState(() {
      name = details.user.name;
    });
  }
}
