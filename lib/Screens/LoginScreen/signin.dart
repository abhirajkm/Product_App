import 'dart:convert';
import 'package:bexindia/Helper/PrefsHelper.dart';
import 'package:bexindia/Helper/config.dart';
import 'package:bexindia/Models/UserModel.dart';
import 'package:bexindia/Screens/RegistrationScreen/register.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;


import '../../Constraints.dart';
import 'ForgotPassword/forgotpassword.dart';



class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String phone = "",
      password = "";
  bool _pass=true;
  String countryCode ="+91";

  ProgressDialog progressDialog;
  @override
  Widget build(BuildContext context) {
    progressDialog = new ProgressDialog(context);
    progressDialog.style(
        message: "validating Your Account. Please wait..!",
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0)
    );
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: BackgroundColor,
        // appBar: AppBar(
        //   elevation: 0,
        //   backgroundColor: BackgroundColor,
        //   shadowColor: Colors.black87,
        //   title:
        // ),


        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40,),
                Center(child: Text("Sign In",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      letterSpacing: 1.5),)),


                SizedBox(height: 50,),
                Container(
                  height: 100,
                 width: 120,
                 decoration: BoxDecoration(
                   //shape: BoxShape.circle,
                   image: DecorationImage(
                       image:AssetImage("assets/farmbox.jpg") ,
                   fit: BoxFit.fill)
                 ),

                 // child: CircleAvatar(
                 //    backgroundImage: AssetImage("assets/images/farmlogo.png",
                 //    ),
                 //    f
                 //    maxRadius: 50,
                 //
                 //  ),
                 //  width: 120,
                 //  decoration: BoxDecoration(
                 //    //shape: BoxShape.circle,
                 //      image: DecorationImage(
                 //          image:AssetImage("assets/images/farmlogo.png") ,
                 //          fit: BoxFit.fill)

                  ),

                 //  ),


                  // child: CircleAvatar(
                  //    backgroundImage: AssetImage("assets/images/farmlogo.png",
                  //    ),
                  //    f
                  //    maxRadius: 50,
                  //
                  //  ),

               // ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    "Login with your Phone Number and Password",
                    style: TextStyle(color: Colors.grey,fontSize: 15),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Column(

                    children: [
                      SizedBox(
                        height: 20,
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
                                    borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),

                                fillColor: Colors.white,
                                filled: true,
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
                            child: TextField(
                              onChanged: (String value) {
                                phone = value;
                              },
                              cursorColor: PrimaryColor,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                              ],
                              keyboardType: TextInputType.numberWithOptions(),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),

                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Phone Number",

                                  prefixIcon: Icon(Icons.phone_android,
                                    color: PrimaryColor,
                                    size: 20,)
                              ),

                              textInputAction: TextInputAction.next,
                            ),
                            flex: 4,
                          ),
                        ],


                      ),


                      SizedBox(height: 15,),

                      TextField(
                        onChanged: (String value) {
                          password = value;
                        },
                        cursorColor: PrimaryColor,
                        obscureText: _pass,
                        keyboardType:TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Password",


                            prefixIcon: Icon(Icons.lock,
                              color:PrimaryColor,
                              size: 20,),
                          suffixIcon: IconButton(
                        icon: Icon(_pass?Icons.visibility_off:Icons.remove_red_eye,
                          size: _pass?20:22,
                          color: _pass?PrimaryColor:PrimaryColor,
                        ),
                        onPressed: (){
                          setState(() {
                            _pass=!_pass;
                          });
                        },
                      ),
                        ),
                        textInputAction: TextInputAction.done,
                      ),
                      SizedBox(height: 15,),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 180),
                      //   child: GestureDetector(
                      //     onTap: (){
                      //       //Navigator.push(context, MaterialPageRoute(builder: (context)=> Forgotpassword()));
                      //     },
                      //     child: Text("Forget Password ?",style: TextStyle(
                      //       fontSize: 13,fontWeight: FontWeight.w500,
                      //       color:PrimaryColor,
                      //       //decoration: TextDecoration.underline
                      //
                      //     ),),
                      //   ),
                      // ),


                      SizedBox(height: 20,),
                      SizedBox(
                        height: 50,
                        width: 325,
                        child: RaisedButton(shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                        ),

                          color:PrimaryColor,

                          onPressed: (){
                            login();
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));
                          },
                          child: Text("Sign In".toUpperCase(),style: TextStyle(
                            fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white,
                            letterSpacing: 1.0,
                          ),),

                        ),
                      ),
                      SizedBox(height: 25),

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //
                      //     SizedBox(
                      //       height: 45,
                      //       width:140,
                      //       child: ElevatedButton(
                      //         style:ElevatedButton.styleFrom(
                      //             shape: RoundedRectangleBorder(
                      //                 borderRadius: BorderRadius.circular(10)
                      //             ),
                      //           primary: Colors.white,
                      //           elevation: 0.5
                      //         ),
                      //         onPressed: (){},
                      //           child: Row(
                      //             children: [
                      //               Icon(Icons.facebook,color: Colors.blue,size: 25,),
                      //               Text(" Facebook",style: TextStyle(
                      //                 fontSize: 15,fontWeight: FontWeight.bold,
                      //               color: Colors.black))
                      //             ],
                      //           ),
                      //       ),
                      //     ),
                      //    // SizedBox(width: 15,),
                      //     SizedBox(
                      //       height: 45,
                      //       width:140,
                      //       child: ElevatedButton(
                      //         style:ElevatedButton.styleFrom(
                      //           shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(10)
                      //           ),
                      //           primary: Colors.white,
                      //           elevation: 0.5
                      //         ),
                      //         onPressed: (){},
                      //         child: Row(
                      //           children: [
                      //             Icon(Icons.g_mobiledata,color: Colors.red,size: 30,),
                      //             Text(" Google",style: TextStyle(
                      //               fontSize: 15,fontWeight: FontWeight.bold,
                      //             color: Colors.black))
                      //           ],
                      //         )
                      //         ,),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text("Don't have an account?  ",style: TextStyle(fontSize:13),),
                          GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
                              },
                              child: Text("Sign up now!",style: TextStyle(color:PrimaryColor,fontWeight: FontWeight.w600),))
                        ],
                      )


                    ],
                  ),


                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

 

  void login() async {
    progressDialog.show();
    print(Config.BASE_URL);
    final http.Response response = await http.post(
      Config.BASE_URL + '/auth/user/signin',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"phone": phone, "password": password}),
    );
    progressDialog.hide();
    bool success =  Userdetails
        .fromJson(jsonDecode(response.body))
        .success;
    if (success) {
      print(jsonEncode(response.body));
      PrefsHelper.setUser(response.body);
      Navigator.pushNamedAndRemoveUntil(context, "/home", (r) => false);
      // if(Userdetails.fromJson(jsonDecode(response.body))){
      //
      // }
      // else{
      //   Navigator.pushNamedAndRemoveUntil(context, "/register", (r) => false);
      // }

      //Navigator.pushNamedAndRemoveUntil(context, "/home", (r) => false);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Account Not Found"),
              content: Text("Please verify"),
              actions: <Widget>[
                FlatButton(
                  child: Text("close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
   }
 }
}



