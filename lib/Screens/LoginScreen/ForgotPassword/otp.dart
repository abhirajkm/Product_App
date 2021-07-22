import 'package:bexindia/Screens/LoginScreen/ForgotPassword/timer.dart';
import 'package:flutter/material.dart';



import 'otpwidget.dart';
class Otp extends StatefulWidget {
  @override
  _OtpState createState() => _OtpState();
}
class _OtpState extends State<Otp> {
  @override
  Widget build(BuildContext context) {
    double appWidth = MediaQuery.of(context).size.width;
    double appHeight = MediaQuery.of(context).size.height;
    double boxappheight = appHeight * .05;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Verify phone",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        textTheme: Theme.of(context).textTheme,
      ),

      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                SizedBox(height: boxappheight),
                // Text("Phone Verification",
                //     textAlign: TextAlign.center,
                //     style: TextStyle(fontSize: 30.0,
                //       fontWeight: FontWeight.w900,
                //     )
                // ),
                SizedBox(height: boxappheight),
                Text(
                    "We have sent you an SMS with a code to your number",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600,color: Colors.black54)
                ),
                SizedBox(height: boxappheight),
                OtpWidget("+8801376221100"),
                OtpTimer(),
                SizedBox(height: appHeight * .07),
                Text(
                    "Didn't receive code?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600,color: Colors.black54,letterSpacing: 1),
                ),
                SizedBox(height: 8,),
                Text(
                    "Request again",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600,color: Colors.deepOrange,letterSpacing: 1)
                ),
                SizedBox(height: 40,),
                GestureDetector(
                  onTap: () {
                    print("Verified");
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Verify",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.green
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
