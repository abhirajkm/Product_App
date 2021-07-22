import 'package:flutter/material.dart';

class TrackOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: trackOrderPage(),
    );
  }
}
class trackOrderPage extends StatefulWidget {
  @override
  _trackOrderPageState createState() => _trackOrderPageState();
}

class _trackOrderPageState extends State<trackOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back_ios),
      //   ),
      //   title: Text("Track Order", style: TextStyle(
      //       color: Colors.black
      //   ),),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.search),
      //     )
      //   ],
      // ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Order Number 1001",),
            Text("Order confirmed. Ready to pick", style: TextStyle(
                color: Colors.grey,
                fontSize: 16
            ),),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              height: 1,
              color: Colors.grey,
            ),
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 13, top: 50),
                  width: 3,
                  height: 214,
                  color: Colors.grey,
                ),
                Column(
                  children: [
                    statusWidget('confirmed', "Confirmed", true),
                    statusWidget('picked up', "Picked Up", false),
                    //statusWidget('servicesImg', "In Process", false),
                    statusWidget('shipped', "Shipped", false),
                    statusWidget('delivered', "Delivered", false),
                  ],
                )
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              height: 1,
              color: Colors.grey,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        color: Colors.green,
                      )
                  ),
                  child: Text("Cancel Order", style: TextStyle(
                      color: Colors.green
                  ),),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),

                    color: Colors.green,

                  ),
                  child: Text("My Orders", style: TextStyle(
                      color: Colors.white
                  ),),
                ),
              ],
            ),

          ],
        ),
      ),

    );
  }

  Container statusWidget(String img, String status, bool isActive) {
    return Container(
      padding: EdgeInsets.only(top: 12,bottom: 12),
      child: Row(
        children: [
          Container(
            height: 20,
            width: 30,

            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (isActive) ? Colors.green : Colors.white,
                border: Border.all(
                    color: (isActive) ? Colors.transparent : Colors.green,
                    width: 3
                )
            ),
          ),
          SizedBox(width: 50,),
          Column(
            children: [
              Container(
                height: 40,
                width: 40,
                 //child: CircleAvatar(
                //   radius: 14,
                //   child: ClipOval(
                //     child: Image.asset(
                //       'assets/logo2.jpg',
                //       height: 150,
                //       width: 150,
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/$img.png"),
                        fit: BoxFit.contain
                    )
                ),
              ),
              Text(status, style: TextStyle(
                  color: (isActive) ? Colors.green : Colors.black
              ),)
            ],
          )
        ],
      ),
    );
  }
}
