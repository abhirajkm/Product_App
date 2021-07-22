import 'package:farmboxapp/Constraints.dart';
import 'package:farmboxapp/Screens/BottomNavigation.dart';
import 'package:farmboxapp/Screens/Catogory/CategoryList.dart';
import 'package:farmboxapp/Screens/HomeScreen/HomeScreen.dart';
import 'package:farmboxapp/Screens/ProfileScreen/profile.dart';
import 'package:flutter/material.dart';
class Paymentsuccess extends StatefulWidget {
  const Paymentsuccess({Key key}) : super(key: key);

  @override
  _PaymentsuccessState createState() => _PaymentsuccessState();
}

class _PaymentsuccessState extends State<Paymentsuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      // appBar:  AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //
      //   title: Padding(
      //     padding: const EdgeInsets.only(left:75.0),
      //     child: Text("Payment",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
      //         fontSize: 20,wordSpacing: 1.5,fontFamily:'roboto' )),
      //   ),
      //   leading: GestureDetector(
      //       onTap: (){
      //         Navigator.pop(context);
      //       },
      //       child: Icon(Icons.arrow_back,color:Colors.black,size: 25,)),
      // ),
        //resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          //physics: ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
          child: Container(
            margin: EdgeInsets.all(20),
              child: Center(
                child : Column(
                  children: [
                    SizedBox(height: 50,),
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                          // image: new DecorationImage(
                          //   image: new AssetImage("assets/images/success.png"),
                          //   fit: BoxFit.cover,)

                      ),
                      child: Image.asset("assets/images/success.png"),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.grey[200],
                          )),
                      height: 150,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
                        child: Column(
                          children: [
                          Text('Thank you for your order', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),

                          SizedBox(height: 10,),
                         Text('We will report once delivery is on the way', style: TextStyle(fontSize: 18),textAlign: TextAlign.center,),

                      ],
                    ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: 20,),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              elevation: 0,
                              primary: PrimaryColor.withOpacity(0.2)
                            ),
                            onPressed: () {

                              Navigator.pushNamed(context, "/my-orders");
                             

                            },
                            child: Text(
                              ' Review Order Details'.toUpperCase(),
                              style: TextStyle(
                                color:PrimaryColor,
                                letterSpacing: 1,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,

                   ),
                            ),
                          ),

                        ),
                        SizedBox(height: 20,),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                elevation: 0.2,
                                primary:PrimaryColor
                            ),
                            onPressed: () {

                              Navigator.push(context, MaterialPageRoute(builder: (context)=>FirstScreen()));
              
                            

                            },
                            child: Text(
                              'Back to Home'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,

                              


                              ),
                            ),
                          ),

                        ),

                      ],

                    ),
                  ],
                ),

              )
          ),
        )
    );
  }
}
