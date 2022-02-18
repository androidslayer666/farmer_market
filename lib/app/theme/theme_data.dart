import 'package:flutter/material.dart';

const backGroundColor = Color(0xFFFFFFFF);

final themeData = ThemeData(
  // Define the default brightness and colors.
  brightness: Brightness.light,
  primaryColor: ColorTwo,
  backgroundColor: ColorThree,
  //cardColor: Color(0xFFF3F3F3),
  scaffoldBackgroundColor: backGroundColor,
  // Define the default font family.
  fontFamily: 'Roboto',

  // Define the default `TextTheme`. Use this to specify the default
  // text styling for headlines, titles, bodies of text, and more.
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    headline6: TextStyle(fontSize: 36.0),
    bodyText2: TextStyle(fontSize: 18.0, fontFamily: 'Hind'),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        ColorTwo,
      ),
      //button color
      foregroundColor: MaterialStateProperty.all<Color>(
        Color(0xffffffff),
      ), //text (and icon)
    ),
  ),
);

/* CSV */
const colors = 'F8F8F8,3B6F61,80B729,47231A,AF9094';

const ColorOne = Color(0xFF1D2566);
const ColorTwo = Color(0xFF369E13);
const ColorThree = Color(0xFFE5CDAD);
const ColorFour = Color(0xFFA10141);
