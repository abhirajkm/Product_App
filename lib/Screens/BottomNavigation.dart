import 'package:farmboxapp/Screens/Catogory/CategoryList.dart';
import 'package:farmboxapp/Screens/HomeScreen/HomeScreen.dart';
import 'package:farmboxapp/Screens/ProfileScreen/profile.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../Constraints.dart';
import 'Favorite_Screen/FavoriteList.dart';
import 'OrderScreen/MyOrder.dart';
import 'OrderScreen/Order.dart';


class FirstScreen extends StatefulWidget {
  FirstScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  var _selectedPageIndex;
  List<Widget> _pages;
  PageController _pageController;


  @override
  void initState() {
    super.initState();

    _selectedPageIndex = 0;

    _pages = [
      HomeScreen(),
      //FavList(),
      AllOrders(),
      CategoryGrid(),
      Profile(),

    ];

    _pageController = PageController(initialPage: _selectedPageIndex);
  }


  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        //The following parameter is just to prevent
        //the user from swiping to the next page.
        physics: NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            // icon:SvgPicture.asset("assets/svg_icons/home1.svg",
            //     color: _selectedPageIndex==0? PrimaryColor: Colors.black,
            //     width: 20),
            icon: Icon(Icons.home_filled,size: 22,),
            label: "home",

          ),
          BottomNavigationBarItem(
              // icon:SvgPicture.asset("assets/svg_icons/shopping-bag.svg",
              //     color: _selectedPageIndex==1? PrimaryColor: Colors.black,
              //     width: 25),
              icon: Icon(Icons.document_scanner_rounded,size: 22,),
              label: "My Orders"
          ),
          BottomNavigationBarItem(
            // icon:SvgPicture.asset("assets/svg_icons/deal.svg",
            //     color: _selectedPageIndex==2? PrimaryColor: Colors.black,
            //     width: 30),
            icon: Icon(Icons.category_sharp,size: 22,),
            label: "Category",
          ),
          // BottomNavigationBarItem(icon:
          // SvgPicture.asset(
          //     "assets/svg_icons/gift-box.svg",
          //     color: _selectedPageIndex==3? PrimaryColor: Colors.black,
          //     width: 25
          // ),
          //     label: "Credits"
          // ),
          BottomNavigationBarItem(
              // icon:SvgPicture.asset("assets/svg_icons/user-profile.svg",
              //   width: 20,
              //   color: _selectedPageIndex==4? PrimaryColor: Colors.black,
              // ),
              icon: Icon(Icons.person,size: 22,),
              label: "Account"
          ),
        ],
        selectedItemColor: PrimaryColor,
        unselectedItemColor: Colors.black,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedLabelStyle: TextStyle(fontSize: 13),

        currentIndex: _selectedPageIndex,
        onTap: (selectedPageIndex) {
          setState(() {
            _selectedPageIndex = selectedPageIndex;
            _pageController.jumpToPage(selectedPageIndex);
          });
        },
      ),
    );
  }

}

