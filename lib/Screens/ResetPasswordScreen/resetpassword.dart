import 'dart:convert';
import 'package:farmboxapp/Helper/config.dart';
import 'package:farmboxapp/Models/UserModel.dart';
import 'package:farmboxapp/Screens/LoginScreen/signin.dart';
import 'package:flutter/material.dart';
import 'package:farmboxapp/Constraints.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Resetpassword extends StatefulWidget {
  const Resetpassword({Key key}) : super(key: key);

  @override
  _ResetpasswordState createState() => _ResetpasswordState();
}

class _ResetpasswordState extends State<Resetpassword> {
  String id = "";
  String phone="";
  String newpassword = "";
  @override
  void initState() {
    fetchAccountInfo();
    super.initState();
    _passwordFocusNode=FocusNode();
    _confirmPassFocusNode=FocusNode();

  }
  TextEditingController _oldpass=TextEditingController();
  TextEditingController _password=TextEditingController();
  TextEditingController _confirmpass=TextEditingController();
  String oldpass="",newpass="";
      //confirmpass='';

  //bool isHiddenPassword=true;

  final GlobalKey _formGlobalKey=GlobalKey();
  bool _oldText=true;
  bool _secureText = true;
  bool _confirmSecure=true;
  FocusNode _passwordFocusNode,_confirmPassFocusNode,_oldpassFocusNode;

  @override
  // void initState() {
  //   // TODO: implement initState
  //   fetchAccountInfo();
  //   super.initState();
  //
  //   //_passwordFocusNode=FocusNode();
  //
  //
  //  // _confirmPassFocusNode=FocusNode();
  //
  //
  //
  // }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _oldpassFocusNode=FocusNode();
    _passwordFocusNode=FocusNode();

    _confirmPassFocusNode=FocusNode();



  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //toolbarHeight: 30,
        backgroundColor: Colors.white,
        elevation: 0.3,

        title: Text("Change Password",
            style: TextStyle(color: Colors.black,
              fontWeight: FontWeight.bold,
            fontSize: 20,letterSpacing: 1.5, )),
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,color:Colors.black,size: 25,)),
      ),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          //physics: ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
          child: Container(
             margin: EdgeInsets.all(10),

              child: Center(
                child : Column(
                  children: [

                    // Container(
                    //   height: MediaQuery.of(context).size.height / 2,
                    //   //height: 340,
                    //   decoration: BoxDecoration(
                    //       image: new DecorationImage(
                    //         image: new AssetImage("assets/images/farm6.jpg"),
                    //         fit: BoxFit.fill,)
                    //
                    //   ),
                    // ),
                    SizedBox(height: 50,),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Form(
                        key: _formGlobalKey,
                        child: Column(
                          children: [


                            TextFormField(
                              onChanged: (String value) {

                                oldpass= value;
                              },
                              controller: _oldpass,
                              focusNode: _oldpassFocusNode,
                              obscureText: _oldText,
                              showCursor: true,
                              style: TextStyle(height: 1),
                              decoration: InputDecoration(

                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(30),
                                ),

                                hintText: "Old Password",
                                prefixIcon: Icon(Icons.lock,color:Colors.green),
                                suffixIcon: IconButton(
                                  icon: Icon(_oldText?Icons.visibility_off:Icons.remove_red_eye,
                                    size: _oldText?20:22,
                                    color: _oldText?Colors.green:PrimaryColor,
                                  ),
                                  onPressed: (){
                                    setState(() {
                                      _oldText=!_oldText;
                                    });
                                  },
                                ),
                                // InkWell(
                                //   onTap: _togglePasswordView,
                                //     child: Icon(Icons.visibility,color:Colors.green)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:BorderSide(color: Colors.grey,) ),

                              ),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter your old password';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20,),
                            TextFormField(
                              onChanged: (String value) {

                                newpass= value;
                              },
                              obscureText: _secureText,
                              controller: _password,
                              focusNode: _passwordFocusNode,
                              showCursor: true,
                              style: TextStyle(height: 1),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),

                                hintText: "New Password",
                                prefixIcon: Icon(Icons.lock,color:Colors.green),
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
                                // InkWell(
                                //     onTap: _togglePasswordView,
                                //     child: Icon(Icons.visibility,color:Colors.green)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:BorderSide(color: Colors.grey,) ),

                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter a new password';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20,),
                            TextFormField(
                                onChanged: (String value) {
                                  newpassword = value;
                                },
                              controller: _confirmpass,
                             focusNode: _confirmPassFocusNode,
                              obscureText: _confirmSecure,
                              showCursor: true,
                              style: TextStyle(height: 1),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),

                                hintText: "Confirm Password",
                                prefixIcon: Icon(Icons.lock,color:Colors.green),
                                suffixIcon: IconButton(
                                  icon: Icon(_confirmSecure?Icons.visibility_off:Icons.remove_red_eye,
                                    size: _confirmSecure?20:22,
                                    color: _confirmSecure?Colors.green:PrimaryColor,
                                  ),
                                  onPressed: (){
                                    setState(() {
                                      _confirmSecure=!_confirmSecure;
                                    });
                                  },
                                ),
                                // InkWell(
                                //     onTap: _togglePasswordView,
                                //     child: Icon(Icons.visibility,color:Colors.green)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:BorderSide(color: Colors.grey,) ),

                              ),
                                keyboardType: TextInputType.text,
                                validator: (value){
                                  if(value.isEmpty)
                                    return 'Confirm Your Password';
                                  if(value != _password.text)
                                    return 'Your Password Not Matching';
                                  return null;
                                }
                            ),
                            SizedBox(height: 50,),
                            SizedBox(
                              height: 50,
                              width: 350,
                              child: RaisedButton(

                                onPressed: () {
                                  final FormState form = _formGlobalKey.currentState;
                                  if(form.validate()){
                                    reset();
                                    //Navigator.push(context,MaterialPageRoute(builder: (context)=>SignIn()));
                                  }


                                },
                                padding: EdgeInsets.all(10.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                color:PrimaryColor,
                                child: Text(
                                  'Save Now!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'OpenSans',
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

              )
          ),
        )
    );
  }
  // void _togglePasswordView()
  // {
  //   // if(isHiddenPassword==true){
  //   //   isHiddenPassword=false;
  //   // }
  //   // else
  //   //   {
  //   //     isHiddenPassword=true;
  //   //   }
  //
  //   setState(() {
  //     isHiddenPassword=!isHiddenPassword;
  //   });
  // }
  void reset() async {
    print(Config.BASE_URL);
    final http.Response response = await http.post(
      Config.BASE_URL + '/auth/user/resetpassword',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"phone":phone,"password": newpassword}),
    );
    bool success = Userdetails.fromJson(jsonDecode(response.body)).success;
    if (success) {
      print(jsonEncode(response.body));
      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Failed"),
              content: Text("Password is not changed"),
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


  void fetchAccountInfo() async {
    final prefs = await SharedPreferences.getInstance();
    String userDetails = prefs.getString("USER");
    Userdetails details = Userdetails.fromJson(
        json.decode(userDetails)
    );
    setState(() {
      //name = details.user.name;

      id= details.user.sId;
      phone=details.user.phone;

    });
  }

}



