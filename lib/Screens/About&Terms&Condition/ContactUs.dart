import '../../Constraints.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
class Contactus extends StatelessWidget {
  const Contactus({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(6),bottomRight: Radius.circular(6)),
                  image: DecorationImage(
                    image:AssetImage("assets/images/logo.jpg",),fit: BoxFit.cover,)
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/4,
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,

              leading: IconButton(icon:Icon(Icons.arrow_back,color: PrimaryColor,), onPressed: (){
                Navigator.pop(context);
              }),
            ),
            Positioned(
              child:
              Container(
                child: Stack(
                  children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.only(top: 155,left: 160),
                      child: Container(
                        child: Text("Contact Us",style: GoogleFonts.roboto(
                          color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,decoration:TextDecoration.underline,

                        ),
                          //style: TextStyle(color: Colors.black,fontSize: 17,fontWeight:FontWeight.bold,decoration:TextDecoration.underline),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 45,top:215,right: 25),
                      child: Container(

                        child: Text("FARMBOX PVT LTD",
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.roboto(
                              color: Colors.black,fontSize: 17,textStyle: TextStyle(
                              wordSpacing: 2,height: 1.4,fontWeight: FontWeight.bold,
                          )
                          ),),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 45,right: 10,top: 250),

                      //alignment: Alignment.topRight,
                      child: Text("Surabhi Building, XXXIX/145/456",
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.roboto(
                            color: Colors.black,fontSize: 17,textStyle: TextStyle(
                            wordSpacing: 2,height: 1.4
                        )
                        ),),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 45,right: 10,top: 285),

                      //alignment: Alignment.topRight,
                      child: Text("2nd floor, Beach Road",
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.roboto(
                            color: Colors.black,fontSize: 17,textStyle: TextStyle(
                            wordSpacing: 2,height: 1.4
                        )
                        ),),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 45,right: 10,top: 320),

                      //alignment: Alignment.topRight,
                      child: Text("Alappuzha-688501",
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.roboto(
                            color: Colors.black,fontSize: 17,textStyle: TextStyle(
                            wordSpacing: 2,height: 1.4
                        )
                          //style: TextStyle(color: Colors.white,
                          //fontSize: 15,fontWeight: FontWeight.bold
                        ),),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 45,right: 10,top: 355),

                      //alignment: Alignment.topRight,
                      child: Text("GSTIN/UIN: 32ABDCS1698K1Z3",
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.roboto(
                            color: Colors.black,fontSize: 17,textStyle: TextStyle(
                            wordSpacing: 2,height: 1.4
                        )
                          //style: TextStyle(color: Colors.white,
                          //fontSize: 15,fontWeight: FontWeight.bold
                        ),),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 45,right: 10,top: 390),

                      //alignment: Alignment.topRight,
                      child: Text("Phone: +91 8921443434",
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.roboto(
                            color: Colors.black,fontSize: 17,textStyle: TextStyle(
                            wordSpacing: 2,height: 1.4,fontWeight: FontWeight.bold
                        )
                          //style: TextStyle(color: Colors.white,
                          //fontSize: 15,fontWeight: FontWeight.bold
                        ),),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 45,right: 10,top: 425),

                      //alignment: Alignment.topRight,
                      child: Text("Email: customercare@farmbox.com",
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.roboto(
                            color: Colors.black,fontSize: 17,textStyle: TextStyle(
                            wordSpacing: 2,height: 1.4,fontWeight: FontWeight.bold
                        )
                          //style: TextStyle(color: Colors.white,
                          //fontSize: 15,fontWeight: FontWeight.bold
                        ),),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );






  }
}
