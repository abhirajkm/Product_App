import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Colors that we use in our app
const PrimaryColor = Color(0xff833ab4);
const TextColor = Color(0xFF3C4046);
const BackgroundColor = Color(0xFFF5F5F5);
const SecondColor = Color(0xffd8045e);
const kErrorColor = Color(0xFFF03738);

const double kDefaultPadding = 20.0;
final Shader linearGradient = LinearGradient(
  colors: <Color>[Color(0xffDA44bb), Color(0xff6a1b9a)],
).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

const List<BoxShadow> shadow = [
  BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
];

const TextStyle kHeading = TextStyle(
  fontSize: 60,
  fontWeight: FontWeight.bold,
  color: Colors.grey,
);

const TextStyle kBodyText = TextStyle(
  fontSize: 22,
  color: Colors.grey,
);


