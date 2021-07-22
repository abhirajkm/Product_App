import 'package:bexindia/Screens/Catogory/CategoryList.dart';
import 'package:flutter/material.dart';
import 'Category_Biscuits/CategorySnacks.dart';
import 'Category_Biscuits/SnacksAll.dart';
import 'Category_Pickle/CategoryPickle.dart';
import 'Category_Pickle/PickleAll.dart';
import 'HeaderWithSearch.dart';
import 'HomeCategoryList/HomeCategory.dart';
import 'ProductsForYou/AvailableProList.dart';
import 'ProductsForYou/AvailableProductAll.dart';
import 'TitleWithViewAll.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HeaderWithSearchBox(size: size),
            TitleWithViewAll(title: "Category", press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryGrid()));

            }),
           // SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(

                  height: 120,

              
                  child:HomeCategoryList()
              ),
            ),
            SizedBox(height: 20,),
            TitleWithViewAll(title: "Products For You", press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AvailProductAll()));

            }),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 200,
                child:AvailaleProductList()
              ),
            ),

            // SizedBox(height: 7,),
            // TitleWithViewAll(title: "Fav Snacks For You", press: () {
            //   Navigator.push(context, MaterialPageRoute(builder: (context)=>AvailProductAll()));
            //
            // }),
            // SizedBox(height: 10,),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: SizedBox(
            //       height: 100,
            //       child:Snackslist()
            //   ),
            // ),


            SizedBox(height: 20,),
            TitleWithViewAll(title: "Snacks", press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AllSnacks()));

            }),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 200,
                  child:CategorySnacks()
              ),
            ),
            SizedBox(height: 20,),
            TitleWithViewAll(title: "Fruits & Vegetables", press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AllPickles()));


            }),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(0),
              child: SizedBox(
                  height: 220,
                  child:CategoryPickle()
              ),
            ),
          ],
        ),
      ),
    );
  }
}
