

import 'package:flutter/material.dart';

import '../../Constraints.dart';
class HistoryAlert extends StatelessWidget {
  const HistoryAlert({Key key,
    this.title,
    this.text,
    this.button,
    this.press

  }) : super(key: key);
    final String title, text, button;
    final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0)
        ),
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 157,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                child: Column(

                  children: [
                    Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    Divider(color:PrimaryColor.withOpacity(0.3),),
                    SizedBox(
                      height: 8,
                    ),
                    Text(text,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15),),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0,top: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 90,
                            height: 30,
                            child: ElevatedButton(onPressed: () {
                              Navigator.of(context).pop();
                            },
                              style: ElevatedButton.styleFrom(
                                primary: PrimaryColor.withOpacity(0.1),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)
                                )
                              ),
                              child: Text('Cancel',
                                style: TextStyle(
                                    color: PrimaryColor,
                                fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(width: 30,),
                          SizedBox(
                            width: 90,
                            height: 30,
                            child: ElevatedButton(onPressed:press,
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)
                                  )
                              ),
                              child: Text(button,
                                style: TextStyle(
                                  color: Colors.white,
                                fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

          ],
        )
    );
  }
}

