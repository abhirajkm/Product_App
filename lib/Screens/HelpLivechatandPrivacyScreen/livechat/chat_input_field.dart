
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../Constraints.dart';
import '../help.dart';



class ChatInputField extends StatelessWidget {
  const ChatInputField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: shadow,
                borderRadius: BorderRadius.circular(50),
              ),
              child:
              RaisedButton(
                onPressed: (){
                   Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Help()));

                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                textColor: Colors.white,
                color: PrimaryColor.withOpacity(0.8),
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Help",
                ),
              ),
            ),
            SizedBox(width: kDefaultPadding),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 0.75,
                ),
                decoration: BoxDecoration(
                  color: PrimaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Icon(
                        Icons.sentiment_satisfied_alt_outlined,
                        color: PrimaryColor
                    ),
                    SizedBox(width: kDefaultPadding / 4),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Type Text here",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(
                        Icons.send,
                        color: PrimaryColor
                    ),
                    // SizedBox(width: kDefaultPadding / 4),
                    // Icon(
                    //   Icons.camera_alt_outlined,
                    //   color: Theme.of(context)
                    //       .textTheme
                    //       .bodyText1
                    //       .color
                    //       .withOpacity(0.64),
                    // ),
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
