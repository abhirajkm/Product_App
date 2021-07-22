import 'package:farmboxapp/Constraints.dart';
import 'package:flutter/material.dart';



class TermsandConditions extends StatefulWidget {
  const TermsandConditions({Key key}) : super(key: key);

  @override
  _TermsandConditionsState createState() => _TermsandConditionsState();
}

class _TermsandConditionsState extends State<TermsandConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.black,),
            onPressed: (){
              Navigator.pop(context);
            }),

        title: Padding(
          padding: const EdgeInsets.only(right: 47),
          child: Container(
            alignment: Alignment.center,
            child: Text("Terms & Conditions",

              style: TextStyle(color: Colors.black, letterSpacing: 1.5,fontWeight: FontWeight.bold
              ),
            ),

          ),
        ),

      ),
      body: SingleChildScrollView(
        child: Container(
          margin:EdgeInsets.all(10),
          child: Stack(
            children: <Widget>[

              Container(
                height: 105,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: ExactAssetImage(
                        "assets/logoo.png"),
                    fit: BoxFit.contain,
                  ),

                ),
              ),
              // SizedBox(
              //   height: 70,
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 125,left: 15),
              //   child: Container(
              //     child: Text("Terms & Conditions",style:TextStyle(
              //       color: Colors.black,fontWeight: FontWeight.bold,fontSize: 40,
              //       //style: TextStyle(color: Colors.white,
              //       //fontSize: 15,fontWeight: FontWeight.bold
              //     ),
              //       //style: TextStyle(color: Colors.black,fontSize: 17,fontWeight:FontWeight.bold,decoration:TextDecoration.underline),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 2,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 5,top:145,right: 10),
                child: Container(
                  margin: EdgeInsets.only(left: 10,right: 10),

                  //alignment: Alignment.topRight,
                  child: Text(" We reserve the right to revise these Terms and Conditions from time to time as explained further. Please check periodically for changes. If you do not agree with any of the revised Terms and Conditions please do not order from farmbox.\n\nTo order from farmbox app, you must register with us. This is referred to as \’set up an account\’ throughout our website and literature. However, this is not a credit account; payment will be required upon delivery of goods. This account can be set up by following the instructions on the website.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.black,fontSize: 17,
                        wordSpacing: 2,height: 1.4

                      //style: TextStyle(color: Colors.white,
                      //fontSize: 15,fontWeight: FontWeight.bold
                    ),),

                ),
              ),

            ],
          ),

        ),
      ),

    );
  }
}

