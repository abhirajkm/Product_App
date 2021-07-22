import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:farmboxapp/Constraints.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class OtpWidget extends StatefulWidget {
  final String phoneNumber;
  OtpWidget(this.phoneNumber);
  @override
  _OtpWidgetState createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {
  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double appWidth = MediaQuery.of(context).size.width;
    double appHeight = MediaQuery.of(context).size.height;
    double boxappheight = appHeight * .05;
    return Form(
      key: formKey,
      child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 8.0, horizontal: 30),
          child: PinCodeTextField(
            textInputType: TextInputType.number,
            textStyle: TextStyle(color: Colors.white,fontWeight:FontWeight.w900,fontSize: 18),
            length: 4,
            obsecureText: false,
            animationType: AnimationType.fade,
            validator: (v) {
              if (v.length < 3) {
                return "I'm from validator";
              } else {
                return null;
              }
            },
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,

              fieldHeight: 60,
              fieldWidth: 60,
              activeColor: PrimaryColor,
              activeFillColor:PrimaryColor,
              inactiveColor: Colors.grey[300],
              inactiveFillColor: Colors.grey[300],
              selectedFillColor: Colors.grey[300],
              selectedColor: Colors.grey[300],

            ),

            backgroundColor: Colors.white10,
            enableActiveFill: true,
            autoDisposeControllers: false,
            errorAnimationController: errorController,
            controller: textEditingController,
            onCompleted: (v) {
              print("Completed");
            },
            onChanged: (value) {
              print(value);
              setState(() {
                currentText = value;
              });
            },
          )),
    );
  }
}
