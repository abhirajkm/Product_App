import 'dart:convert';

import 'package:farmboxapp/Constraints.dart';
import 'package:farmboxapp/Helper/PrefsHelper.dart';
import 'package:farmboxapp/Helper/config.dart';
import 'package:farmboxapp/Models/UserModel.dart';
import 'package:farmboxapp/Screens/LoginScreen/signin.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
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
      appBar: AppBar(

        backgroundColor: Colors.transparent,
        elevation: 0,

        title: Padding(
          padding: const EdgeInsets.only(left:60.0),
          child: Text("Sign Up",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
              fontSize: 25,letterSpacing: 1.5,fontFamily:'roboto' )),
        ),
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,color:Colors.black,size: 25,)),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(25, 25,35 ,00),
              //   child: Stack(
              //     children: <Widget>[
              //       Center(
              //         child: CircleAvatar(
              //           radius: 46,
              //           child: ClipOval(child: Image.asset('assets/logoo.png', height: 150, width: 150, fit: BoxFit.cover,),),
              //         ),
              //       ),
              //       // Positioned(bottom: 0, right: 90 ,child: Container(
              //       //   height: 35, width: 35,
              //       //   child: Icon(Icons.add_a_photo, color: Colors.white,size: 20,),
              //       //   decoration: BoxDecoration(
              //       //       color: PrimaryColor,
              //       //       borderRadius: BorderRadius.all(Radius.circular(20))
              //       //   ),
              //       // ))
              //     ],
              //   ),
              // ),
              Container(
                margin: EdgeInsets.all(20),
                child: Form(
                  key: _formGlobalKey,
                    child: Column(
                      children: [
                      SizedBox(height: 40,),
                       TextFormField(
                         onChanged: (String value) {
                           name = value;
                         },
                         controller: _name,
                        focusNode: _nameFocusNode,
                        //showCursor: false,
                        //style: TextStyle(height: 2.8),
                           decoration: InputDecoration(
                           enabledBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(30),
                           borderSide: BorderSide(color: Colors.grey),
                        ),

                         hintText: "Full Name",
                         prefixIcon: Icon(Icons.account_circle,color:PrimaryColor,size: 20,),
                         focusedBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(30),
                             borderSide:BorderSide(color: Colors.grey,) ),
                          ),
                         keyboardType: TextInputType.text,

                         //validator: (value)
                         // {
                         //   if (value == null || value.isEmpty) {
                         //     return 'Enter your name';
                         //   }
                         //   return null;
                         // },
                        ),
                        SizedBox(height: 18,),
                        TextFormField(
                          onChanged: (String value) {
                            email = value;
                          },
                           controller: _email,
                           focusNode: _emailFocusNode,
                           //style: TextStyle(height: 3.2),
                           decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.grey,),
                            ),
                             hintText: "Email",
                             prefixIcon: Icon(Icons.email,color:PrimaryColor,size: 20,),
                             focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:BorderSide(color: Colors.grey,) ),),
                          keyboardType: TextInputType.text,
                          validator: (value) => EmailValidator.validate(value) ? null : "Please enter a valid email",
                        ),
                          SizedBox(height: 18,),
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
                              SizedBox(width: 10,),
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
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                      hintText: "Phone",
                                      prefixIcon: Icon(Icons.phone,color:PrimaryColor,size: 20,),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide:BorderSide(color: Colors.grey,) ),),

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
                              )
                            ],
                          ),
                          SizedBox(height: 18,),
                          TextFormField(
                            onChanged: (String value) {
                              address = value;
                            },
                            controller: _address,
                           focusNode: _addressFocusNode,
                           //showCursor: false,
                           //style: TextStyle(height: 3.2),
                           decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(color: Colors.grey),
                                 ),
                                   hintText: "Address",
                                    prefixIcon: Icon(Icons.home,color:PrimaryColor,size: 20,),

                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide:BorderSide(color: Colors.grey,) ),),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter your address';
                              }
                              return null;
                            },
                              ),
                          SizedBox(height: 18,),
                          TextFormField(
                            onChanged: (String value) {
                              password = value;
                            },
                            controller: _password,
                            focusNode: _passwordFocusNode,
                            //obscureText: true,
                            //showCursor: false,
                            //style: TextStyle(height: 3.2),
                             decoration: InputDecoration(
                                 enabledBorder: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(color: Colors.grey),
                                   ),
                                  hintText: "Password",
                                   prefixIcon: Icon(Icons.lock,color:PrimaryColor,size: 20,),
                                   suffixIcon: IconButton(
                                       onPressed: (){
                                         setState(() {
                                         _secureText=!_secureText;
                                       });
                                         },
                                       icon: Icon(_secureText?Icons.visibility_off:Icons.remove_red_eye,
                                         size: _secureText?20:22,

                                         color: _secureText?Colors.green:PrimaryColor,


                                       )),
                                        focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                         borderSide:BorderSide(color: Colors.grey,) ),),
                            obscureText: _secureText,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter a password';
                              }
                              return null;
                            },
                          ),
                    //     SizedBox(height: 18,),
                    //     TextFormField(
                    //       controller: _confirmpass,
                    //         focusNode: _confirmPassFocusNode,
                    //         //obscureText: true,
                    //         //showCursor: false,
                    //         //style: TextStyle(height: 3.2),
                    //         decoration: InputDecoration(
                    //
                    //              hintText: "Confirm Password",
                    //            prefixIcon: Icon(Icons.lock,color:PrimaryColor,size: 20,),
                    //           suffixIcon: IconButton(
                    //               icon: Icon(_confirmSecure?Icons.visibility_off:Icons.remove_red_eye,
                    //                 size: _confirmSecure?20:22,
                    //
                    //                 color: _confirmSecure?Colors.green:PrimaryColor,
                    //
                    //               ),
                    //             onPressed: (){
                    //               setState(() {
                    //                 _confirmSecure=!_confirmSecure;
                    //               });
                    //             },
                    //           ),
                    //           enabledBorder: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(30),
                    //             borderSide: BorderSide(color: Colors.grey),
                    //           ),
                    //           focusedBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(30),
                    //            borderSide:BorderSide(color: Colors.grey,) ),),
                    //       obscureText: _confirmSecure,
                    //       keyboardType: TextInputType.text,
                    //         validator: (value){
                    //           if(value.isEmpty)
                    //             return 'Confirm Your Password';
                    //           if(value != _password.text)
                    //             return 'Your Password Not Matching';
                    //           return null;
                    //         }
                    // ),
                        SizedBox(height: 25,),
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
                        'Sign Up'.toUpperCase(),
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
        ]
      ),
    )
    )
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
      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
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
