import 'dart:convert';

import 'package:bexindia/Helper/PrefsHelper.dart';
import 'package:bexindia/Helper/config.dart';
import 'package:bexindia/Models/UserModel.dart';
import 'package:bexindia/Screens/LoginScreen/signin.dart';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

import '../../Constraints.dart';
class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {


  TextEditingController _name=TextEditingController();
  TextEditingController _password=TextEditingController();
  TextEditingController _phone=TextEditingController();
  TextEditingController _email=TextEditingController();
  TextEditingController _address=TextEditingController();
  TextEditingController _confirmpass=TextEditingController();


  String phone = "", password = "",name= "",email = "",address="";
  ProgressDialog progressDialog;
  String countryCode="+91";

  bool _secureText = true;
  bool _confirmSecure=true;

  final GlobalKey _formGlobalKey=GlobalKey();

  FocusNode _nameFocusNode, _passwordFocusNode,_phoneFocusNode,_emailFocusNode,_addressFocusNode,_confirmPassFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameFocusNode=FocusNode();
    _passwordFocusNode=FocusNode();
    _phoneFocusNode=FocusNode();
    _addressFocusNode=FocusNode();
    _confirmPassFocusNode=FocusNode();
    _emailFocusNode=FocusNode();


  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameFocusNode=FocusNode();
    _passwordFocusNode=FocusNode();
    _addressFocusNode=FocusNode();
    _confirmPassFocusNode=FocusNode();
    _phoneFocusNode=FocusNode();
    _emailFocusNode=FocusNode();

  }
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
    return Scaffold(
      backgroundColor: BackgroundColor,
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: BackgroundColor,
      //   shadowColor: Colors.black87,
      //   title:
      // ),


      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              // Container(
              //   height: 220,
              //   decoration: BoxDecoration(
              //     //color: PrimaryColor.withOpacity(0.90),
              //       borderRadius: BorderRadius.only(
              //           bottomRight: Radius.circular(80),
              //           bottomLeft: Radius.circular(80)
              //       ),
              //       image: DecorationImage(
              //           image:AssetImage("assets/cake3.jpg"),fit: BoxFit.cover )
              //   ),
              // ),
              // Container(
              //   height: 220,
              //   decoration: BoxDecoration(
              //       color: PrimaryColor.withOpacity(0.60),
              //       borderRadius: BorderRadius.only(
              //           bottomRight: Radius.circular(80),
              //           bottomLeft: Radius.circular(80)
              //       )
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 100,right: 20,top: 20),
              //   child: Text("Daya's Cakes \n         & \n    Cookies",
              //     style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 20,
              //         fontWeight: FontWeight.w600
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top:100),
                child: Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(20),
                  height: 600,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 3,
                        color: Colors.white12,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        child: Form(
                          key: _formGlobalKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 0,
                              ),
                              Center(
                                child: Text("SignUp ",textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Colors.black,
                                      //letterSpacing: 1.5,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700
                                  ),),
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              TextFormField(
                                onChanged: (String value) {
                                  name = value;
                                },
                                controller: _name,
                                focusNode: _nameFocusNode,
                                //showCursor: false,
                                //style: TextStyle(height: 2.8),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                  //fillColor: Colors.white,
                                  filled: true,


                                  hintText: "Full Name",
                                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                                  prefixIcon: Icon(Icons.account_circle,color:PrimaryColor,size: 18,),

                                ),
                                keyboardType: TextInputType.text,

                                validator: (value)
                                {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter your name';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 15,),
                              TextFormField(
                                onChanged: (String value) {
                                  email = value;
                                },
                                controller: _email,
                                focusNode: _emailFocusNode,
                                //style: TextStyle(height: 3.2),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                  //fillColor: Colors.white,
                                  filled: true,
                                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                                  hintText: "Email",
                                  prefixIcon: Icon(Icons.email,color:PrimaryColor,size: 18,),
                                ),
                                keyboardType: TextInputType.text,
                                validator: (value) => EmailValidator.validate(value) ? null : "Please enter a valid email",
                              ),
                              SizedBox(height: 15,),
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
                                        //fillColor: Colors.white,
                                        filled: true,
                                        hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                                        prefixIcon: Icon(
                                          CupertinoIcons.globe,
                                          color: PrimaryColor,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                    flex: 3,
                                  ),
                                  SizedBox(width: 7,),
                                  Expanded(
                                    child:TextFormField(
                                      onChanged: (String value) {
                                        phone = value;
                                      },
                                      controller: _phone,
                                      focusNode: _phoneFocusNode,
                                      // showCursor: false,
                                      //style: TextStyle(height: 3.2),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: BorderSide.none,
                                        ),
                                        //fillColor: Colors.white,
                                        filled: true,
                                        hintText: "Phone",
                                        hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                                        prefixIcon: Icon(Icons.phone,color:PrimaryColor,size: 20,),
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
                                    flex: 5,
                                  )
                                ],
                              ),
                              SizedBox(height: 15,),
                              TextFormField(
                                onChanged: (String value) {
                                  password = value;
                                },
                                controller: _password,
                                focusNode: _passwordFocusNode,
                                //showCursor: false,
                                //style: TextStyle(height: 3.2),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                  //fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                                  prefixIcon: Icon(Icons.lock,color:PrimaryColor,size: 20,),
                                  suffixIcon: IconButton(
                                      onPressed: (){
                                        setState(() {
                                          _secureText=!_secureText;
                                        });
                                      },
                                      icon: Icon(_secureText?Icons.visibility_off:Icons.remove_red_eye,
                                        size: _secureText?18:18,

                                        color: _secureText?PrimaryColor:PrimaryColor,


                                      )),

                                ),
                                obscureText: _secureText,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter a password';
                                  }
                                  return null;
                                },
                              ),

                              SizedBox(height: 15,),
                              SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    final FormState form = _formGlobalKey.currentState;
                                    if(form.validate()){
                                      SignUp();
                                      //Navigator.push(context,MaterialPageRoute(builder: (context)=>SignIn()));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: PrimaryColor,
                                    // onPrimary: Colors.yellow,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),

                                  ),
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      color: BackgroundColor,
                                      letterSpacing: 1.0,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,

                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                bottom: 60,
                left: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text("Already have an account?  ",style: TextStyle(fontSize:13),),
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
                        },
                        child: Text("Sign In now!",style: TextStyle(color:PrimaryColor,fontWeight: FontWeight.w600),))
                  ],
                ),
              )


            ],
          ),
        ),

      ),
    );
  }
  void SignUp() async {
    progressDialog.show();
    print(Config.BASE_URL);
    final http.Response response = await http.post(
      Config.BASE_URL + '/auth/user/signup',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"name":name,"phone": phone, "password": password,"email":email,"address":address}),
    );
    progressDialog.hide();
    bool success = Userdetails.fromJson(jsonDecode(response.body)).success;
    if (success) {
      print(jsonEncode(response.body));
      PrefsHelper.setUser(response.body);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("You have Successfully registered"),
              content: Text("Please login"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Login"),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
                    //Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
      //Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Already have an account"),
              content: Text("Please login"),
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