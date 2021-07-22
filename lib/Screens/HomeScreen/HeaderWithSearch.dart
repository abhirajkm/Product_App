import 'package:badges/badges.dart';
import 'package:farmboxapp/Provider/CartProvider.dart';
import 'package:farmboxapp/Screens/Favorite_Screen/FavoriteList.dart';
import 'package:farmboxapp/Screens/ShoppingCartScreen/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../Constraints.dart';

class HeaderWithSearchBox extends StatelessWidget {
  const HeaderWithSearchBox({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5),
      // It will cover 20% of our total height
      height: size.height * 0.23,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: 36 + kDefaultPadding,
            ),
            height: size.height * 0.5 - 27,
            decoration: BoxDecoration(
              color: PrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Farm Box',
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  IconButton(onPressed: (){
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>FavoriteList()));
                  },
                      icon: Icon(Icons.favorite_rounded,color: Colors.white,)),
                  Consumer<CartProvider>(builder: (context, cartProvider, child) {
                    return  InkWell(
                      onTap: (){
                        Navigator.pushReplacementNamed(context, "/myCart");
                      },
                      child: Badge(
                        badgeColor: Colors.orangeAccent,
                        position: BadgePosition.topEnd(top: -15),
                        badgeContent: Text(cartProvider.cartCount.toString(),style: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.bold),),
                        child: Icon(Icons.shopping_cart,color: Colors.white,size: 23,),
                      ),
                    );
                  },),
                  // IconButton(onPressed: (){
                  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
                  // },
                  //     icon: Icon(Icons.shopping_cart,color: Colors.white,))
                  //Spacer(),
                  //Image.asset("assets/images/logo.png")
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: PrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/search');
                },
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        enabled: false,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: PrimaryColor.withOpacity(0.5),
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          // surffix isn't working properly  with SVG
                          // thats why we use row
                          // suffixIcon: SvgPicture.asset("assets/icons/search.svg"),
                        ),
                      ),
                    ),
                    SvgPicture.asset("assets/search.svg"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}