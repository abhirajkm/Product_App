import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 2),
            () => {
          navigate()
            //Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()))
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        color: Colors.white,
        child: Center(child : Container(
          height: 200,
          width: 200,
          child : Image.asset('assets/farmbox.jpg',)

          //Text("Farm Box",style: TextStyle(fontSize: 23,fontFamily: 'Pacifico',color: Colors.white),),

        ),

        )));
  }
  navigate()
  async
  {

    final prefs = await SharedPreferences.getInstance();
    String userDetails = prefs.getString("USER");
    print(userDetails);
    if(userDetails == null || userDetails == ""){
      Navigator.pushReplacementNamed(context, "/onboard");
    }else{

      Navigator.pushReplacementNamed(context, "/home");

    }
  }
}
