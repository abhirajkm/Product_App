import 'package:flutter/material.dart';
import 'package:farmboxapp/Screens/HelpLivechatandPrivacyScreen/livechat/message_screen.dart';

import '../../Constraints.dart';
final List<DataList> data = <DataList>[
  DataList(
    'What are my payment options here?',
    <DataList>[
      DataList(
        'we provide multiple payment options 1.netbanking,2 debit/credit card options 3.UPI servises',

      ),

    ],
  ),
  DataList(
    'What if i miss a delivery call from courier partner?',
    <DataList>[
      DataList('You will get a call,otherwise contact our customer care no'),

    ],
  ),
  DataList(
    'How do i track my order',
    <DataList>[
      DataList('please follow the steps 1.go to orders page 2.click track my order'),


    ],
  ),
];
class DataList {
  DataList(this.title, [this.children = const <DataList>[]]);

  final String title;
  final List<DataList> children;
}
class Help extends StatefulWidget {
  const Help({Key key}) : super(key: key);

  @override
  _HelpState createState() => _HelpState();
}


class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        //resizeToAvoidBottomInset: true,
        backgroundColor: BackgroundColor,
        appBar:  AppBar(
          //toolbarHeight: 40,
          backgroundColor: Colors.white,
          elevation: 0,

          title: Padding(
            padding: const EdgeInsets.only(left:60.0),
            child: Text("Help",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
                fontSize: 20,letterSpacing: 1.5,fontFamily:'roboto' )),
          ),

          leading: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back,color:Colors.black,size: 25,)),
          actions: <Widget>[
            Padding(padding: EdgeInsets.only(right: 25.0),
              // child:GestureDetector(
              //     onTap:(){},
              //     child: Icon(Icons.search,color:Colors.black,size: 25,)),
            ),

          ],

        ),

        body: SingleChildScrollView(
          //physics: ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
          child: Container(
             margin: EdgeInsets.all(15),
              height: MediaQuery.of(context).size.height,
              child: Center(
                child : Column(
                  children: [
                    //Container(),
                    SizedBox(height: 10,),
                      Container(
                        height: 450,
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) =>
                              DataPopUp(data[index]),
                          itemCount: data.length,
                        ),
                      ),


                    Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Row(
                                children: [

                                  Text("Still if you need please contact us?",textAlign: TextAlign.left,style: TextStyle(color: Colors.red),),
                                ]
                            ),

                          ),
                          SizedBox(height: 20,),
                          SizedBox(
                            height: 50,
                            width: 350,
                            child: RaisedButton(

                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>MessagesScreen()));

                              },
                              padding: EdgeInsets.all(10.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              color: PrimaryColor,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 60),
                                child: Row(
                                  children: [

                                    Icon(Icons.chat,color: Colors.white,size: 20,),
                                    SizedBox(width: 5,),
                                    Text(
                                      'Live Chat'.toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: 1,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,

                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],

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
class DataPopUp extends StatelessWidget {
  const DataPopUp(this.popup);

  final DataList popup;

  Widget _buildTiles(DataList root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<DataList>(root),
      title: Text(
        root.title,
      ),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(popup);
  }
}
