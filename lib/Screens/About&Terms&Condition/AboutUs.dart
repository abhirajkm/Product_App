
import 'package:flutter/material.dart';

import '../../Constraints.dart';



class About extends StatefulWidget {
  const About({Key key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.black,),
            onPressed: (){
            Navigator.pop(context);
          }),

        title: Padding(
          padding: const EdgeInsets.only(right: 47),
          child:
          Container(
            alignment: Alignment.center,
            child: Text("About Us",

              style: TextStyle(color: Colors.black,
                  letterSpacing: 1.5,fontWeight: FontWeight.bold
              ),
            ),

          ),
        ),

      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Stack(
            children: <Widget>[
              Container(
                height: 105,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: ExactAssetImage(
                        "assets/farmbox.jpg"),
                    fit: BoxFit.contain,
                  ),

                ),
              ),
              // SizedBox(
              //   height: 70,
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 125,left: 15),
                // child: Container(
                //   child: Text("About Us",style:TextStyle(
                //     color: Colors.black,fontWeight: FontWeight.bold,fontSize: 40,
                //     //style: TextStyle(color: Colors.white,
                //     //fontSize: 15,fontWeight: FontWeight.bold
                //   ),
                //     //style: TextStyle(color: Colors.black,fontSize: 17,fontWeight:FontWeight.bold,decoration:TextDecoration.underline),
                //   ),
                // ),
              ),
              SizedBox(
                height: 2,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 5,top:145,right: 10),
                child: Container(
                  margin: EdgeInsets.only(left: 10,right: 10),

                  //alignment: Alignment.topRight,
                  child: Text("We will provide high quality, farm-fresh food, more accessible to all families.",
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

