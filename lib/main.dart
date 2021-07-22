
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'Provider/AllProductProvider.dart';
import 'Provider/CartProvider.dart';
import 'Provider/CategoryProvider.dart';
import 'Provider/FavoriteProvider.dart';
import 'Provider/OrderProvider.dart';
import 'Provider/ProductProvider.dart';
import 'Provider/homeProvider.dart';
import 'Screens/BottomNavigation.dart';
import 'Screens/Catogory/SubProductsList.dart';
import 'Screens/CheckoutScreen/Components/CheckoutOrder.dart';
import 'Screens/CheckoutScreen/ConfirmCheckout.dart';
import 'Screens/CheckoutScreen/ShippingAddress.dart';
import 'Screens/CheckoutScreen/ReviewOrder.dart';
import 'Screens/LoginScreen/ForgotPassword/otp.dart';
import 'Screens/LoginScreen/signin.dart';
import 'Screens/OnboardingScreen/SplashScreen.dart';
import 'Screens/OnboardingScreen/onboard.dart';
import 'Screens/OrderScreen/Order.dart';
import 'Screens/OrderScreen/OrderDetails.dart';
import 'Screens/PaymentScreen/paymentsuccess.dart';
import 'Screens/CheckoutScreen/Components/NewAddress.dart';
import 'Screens/ProductScreen/DetailPage.dart';
import 'Screens/RegistrationScreen/register.dart';
import 'Screens/Searchitems/search.dart';
import 'Screens/ShoppingCartScreen/cart.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => AllProductProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),



      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title:  'FarmBox',
          theme: ThemeData(
           // scaffoldBackgroundColor: Colors.white,
            textTheme:
            GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),


          routes: {
            '/':(context)=>Splashscreen(),
            '/onboard':(context)=>Onboarding(),
            '/register':(context)=>Register(),
            '/prodetail' : (context) => ProductDetail(),
            //'/favlist' : (context) => FavoriteList(),

            '/home':(context)=>FirstScreen(),
            '/login':(context)=>SignIn(),
            //'/address':(context)=>NewAddress(),
            '/subCategory':(context)=>SubCategoryList(),
            '/checkout':(context)=>Checkout(),
            '/myCart':(context)=>Cart(),
            "/otp":(context)=>Otp(),
            '/order-detail':(context)=>OrderDetails(),
            '/my-orders':(context)=>AllOrders(),
            "/add-address":(context)=>ShippingAddress(),
            "/my-address":(context)=>MyAddress(),
            '/confirm-checkout':(context)=>ConfirmCheckout(),
            '/product-detail':(context)=>ProductDetail(),
            '/search':(context)=>Search(),
            '/Payment-Success':(context)=>Paymentsuccess(),

          }












      ),
    );
  }
}