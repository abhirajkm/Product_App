import 'package:flutter/material.dart';

import '../../Constraints.dart';

class TitleWithViewAll extends StatelessWidget {
  const TitleWithViewAll({
    Key key,
    this.title,
    this.press,
  }) : super(key: key);
  final String title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: <Widget>[
          TitleWithCustomUnderline(text: title),
          Spacer(),

          InkWell(
            onTap: press,
            child: Text(
              "ViewAll",
                style:TextStyle(
                  fontWeight: FontWeight.w600,letterSpacing: 1,
                      color:Colors.red,
                      fontSize: 15,
                      //fontWeight: FontWeight.bold
                  ),
                )
            ),


         // Text("ViewAll",
         //      style: GoogleFonts.roboto(
         //        textStyle: TextStyle(
         //          color: Colors.red,
         //          fontSize: 15,
         //          //fontWeight: FontWeight.bold
         //        ),
         //      )),

        ],
      ),
    );
  }
}

class TitleWithCustomUnderline extends StatelessWidget {
  const TitleWithCustomUnderline({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      child: Stack(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(left: kDefaultPadding / 4),
              child: Text(
                text,
                style:
                  TextStyle(
                    fontWeight: FontWeight.w600,letterSpacing: 1,
                    color: Colors.black,
                    fontSize: 18,
                    //fontWeight: FontWeight.bold
                  ), )
          ),
              ]


              //style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
           // ),
         // ),





          

      //  ],
      )
    );
  }
}
