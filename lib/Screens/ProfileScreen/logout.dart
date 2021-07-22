
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constraints.dart';
class AlertLog extends StatelessWidget {
  const AlertLog({Key key}) : super(key: key);

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
              height: 155,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: Column(
                  children: [
                    Text("Logout", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                    Divider(color:PrimaryColor.withOpacity(0.3),),
                    SizedBox(
                      height: 8,
                    ),
                    Text("Are you sure you want to logout?",
                      style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          fontSize: 15),),

                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0,top: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 90,
                            height: 35,
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
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          SizedBox(width: 30,),
                          SizedBox(
                            width: 90,
                            height: 35,
                            child: ElevatedButton(onPressed: () async{
                              SharedPreferences prefs = await SharedPreferences.getInstance();

                              prefs.setString('USER', '');
                              Navigator.pushNamedAndRemoveUntil(context, "/login", (r) => false);
                            },
                              style: ElevatedButton.styleFrom(
                                  primary: PrimaryColor,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)
                                  )
                              ),
                              child: Text("Logout",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
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

