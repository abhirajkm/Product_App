
import 'package:flutter/material.dart';
class Privacy extends StatefulWidget {
  const Privacy({Key key}) : super(key: key);

  @override
  _PrivacyState createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          //physics: ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
          child: Container(
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.all(Radius.circular(15))
                 ),
              child: Center(
                child : Column(
                  children: [
                    AppBar(
                      toolbarHeight: 40,
                      backgroundColor: Colors.transparent,
                      elevation: 0,

                      title: Padding(
                        padding: const EdgeInsets.only(left:64.0),
                        child: Text("Privacy Policy",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
                            fontSize: 20,wordSpacing: 1.5,fontFamily:'roboto' )),
                      ),

                      leading: GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back,color:Colors.black,size: 25,)),
                      actions: <Widget>[
                        Padding(padding: EdgeInsets.only(right: 25.0),
                            child:GestureDetector(
                              onTap:(){},
                                child: Icon(Icons.search,color:Colors.black,size: 25,)),
                            ),

                      ],

                    ),
                    SizedBox(height: 15,),
                    Container(
                      decoration: BoxDecoration(color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.grey[200],
                          )),
                      width: 340,

                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(11, 32, 10, 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(

                                    radius: 10,

                                    child: Text("01")

                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 21),
                                  child: Text('Product Terms & Conditions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                ),

                              ],
                            ),
                            SizedBox(height: 10,),

                            Text('We will report once delivery is on the way,We will report once delivery is on the wayWe will report once delivery is on the way,We will report once delivery is on the way', style: TextStyle(fontSize: 20,),),

                            SizedBox(height: 10,),
                            Row(
                              children: [
                                CircleAvatar(

                                    radius: 10,

                                    child: Text("02")

                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 21),
                                  child: Text('Product Refund Policy', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                ),

                              ],
                            ),
                            SizedBox(height: 10,),
                            Text('We will report once delivery is on the way,We will report once delivery is on the wayWe will report once delivery is on the way,We will report once delivery is on the way', style: TextStyle(fontSize: 20,),),
                            SizedBox(height: 10,),
                            Row(
                              children: [

                                CircleAvatar(

                                    radius: 10,

                                    child: Text("03")

                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 21),
                                  child: Text('Product Delivery', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                ),

                              ],
                            ),
                            SizedBox(height: 10,),
                            Text('We will report once delivery is on the way,We will report once delivery is on the wayWe will report once delivery is on the way,We will report once delivery is on the way', style: TextStyle(fontSize: 20,),),


                            SizedBox(height: 10,),
                            Row(
                              children: [
                                CircleAvatar(

                                    radius: 10,

                                    child: Text("04")

                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 21),
                                  child: Text('24/7 Hours online support', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                ),

                              ],
                            ),
                            SizedBox(height: 10,),
                            Text('We will report once delivery is on the way,We will report once delivery is on the wayWe will report once delivery is on the way,We will report once delivery is on the way', style: TextStyle(fontSize: 20,),),

                            SizedBox(height: 10,),
                            Row(
                              children: [
                                CircleAvatar(

                                    radius: 10,

                                    child: Text("05")

                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 21),
                                  child: Text('Return Policy', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                ),

                              ],
                            ),

                            SizedBox(height: 10,),
                            Text('We will report once delivery is on the way,We will report once delivery is on the wayWe will report once delivery is on the way,We will report once delivery is on the way', style: TextStyle(fontSize: 20,),),
                            SizedBox(height: 10,),


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
}
