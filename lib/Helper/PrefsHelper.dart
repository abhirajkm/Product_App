import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper {
  static Future setUser(String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString("USER", value);
  }

  static Future saveCart(String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString( "CART", value);
  }
  static Future<String> getUser() async{
    final prefs = await SharedPreferences.getInstance();
    String userDetails = prefs.getString("USER");
    return userDetails;
  }
  static Future setAddress(String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString( "ADDRESS", value);
  }
  static Future setLocation(String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString( "LOCATION", value);
  }
  static Future<String> getLocation() async{
    final prefs = await SharedPreferences.getInstance();
    String userLocation = prefs.getString("LOCATION");
    return userLocation;
  }
  static Future<String> getAddress() async{
    final prefs = await SharedPreferences.getInstance();
    String userAddress = prefs.getString("ADDRESS");
    return userAddress;
  }
}