import 'package:flutter/material.dart';
class Forgotpassword extends StatefulWidget {
  const Forgotpassword({Key key}) : super(key: key);

  @override
  _ForgotpasswordState createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          //physics: ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
          child: Container(
            //color: Colors.green[600],
              child: Center(
                child : Column(
                  children: [

                    AppBar(
                      toolbarHeight: 30,
                      backgroundColor: Colors.transparent,
                      elevation: 0,

                      title: Padding(
                        padding: const EdgeInsets.only(left:60.0),
                        child: Text("Forget Password",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
                            fontSize: 20,wordSpacing: 1.5,fontFamily:'roboto' )),
                      ),
                      leading: GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back,color:Colors.black,size: 25,)
                      ),
                    ),
                    Container(

                      height: 360,
                      decoration: BoxDecoration(
                          image: new DecorationImage(
                            image: new AssetImage("assets/images/farm4.jpg"),
                            fit: BoxFit.fill,)

                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text("we will send OTP to the mobile no you registered to regain your password",textAlign: TextAlign.center,style: TextStyle(fontSize: 20),),
                          SizedBox(height: 30,),
                          TextField(
                            showCursor: false,
                            style: TextStyle(height: 1),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),

                              hintText: "Registered Phone No ",
                              prefixIcon: Icon(Icons.phone,color:Colors.green),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(3),
                                  borderSide:BorderSide(color: Colors.grey,) ),

                            ),
                          ),
                          SizedBox(height: 20,),
                          //Text("OTP send to 892*****15"),
                          SizedBox(height: 20,),
                          SizedBox(
                            height: 50,
                            width: 350,
                            child: RaisedButton(

                              onPressed: () {
                                Navigator.pushNamed(context, '/otp');
                                // showDialog(context: context,
                                //     builder: (BuildContext context) {
                                //       return Resetalert();
                                //     });

                              },
                              padding: EdgeInsets.all(10.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              color: Colors.green[100],
                              child: Text(
                                'Send Now',
                                style: TextStyle(
                                  color: Colors.green,
                                  letterSpacing: 1,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,

                                ),
                              ),
                            ),
                          ),
                        ],

                      ),
                    ),
                  ],
                ),

              )
          ),
        )
    );
  }
}
class Resetalert extends StatelessWidget {
  const Resetalert({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0)
        ),
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 260,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
                child: Column(
                  children: [
                    Text('Password Reset Email Sent', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
                    const Divider(
                      height: 20,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    SizedBox(height: 10,),
                    Text('An Email has been sent to you Follow direction in the email to reset password', style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
                    SizedBox(height: 20,),
                    RaisedButton(onPressed: () {
                      Navigator.of(context).pop();
                    },
                      color: Colors.green,
                      child: Text('OK', style: TextStyle(color: Colors.white),),
                    )
                  ],
                ),
              ),
            ),

          ],
        )
    );
  }
}


