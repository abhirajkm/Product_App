

import 'package:bexindia/Screens/HelpLivechatandPrivacyScreen/livechat/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:savebox/Screen/CreditPages/AddCredit.dart';


import '../../../Constraints.dart';

class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            BackButton(),
            // CircleAvatar(
            //   backgroundImage: AssetImage("assets/images/profilepic.jpg"),
            // ),
            SizedBox(width: kDefaultPadding * 0.75),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lets chat here",
                  style: TextStyle(fontSize: 16, letterSpacing: 1.2),
                ),
              ],
            )
          ],
        ),
        actions: [
          IconButton(
      icon: Image.asset("assets/logoo.png"),


            onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => AddCredit()));
            },
          ),
          SizedBox(width: kDefaultPadding / 2),
        ],
      ),
      body: Body(),
    );
  }
}
