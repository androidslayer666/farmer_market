import 'package:flutter/material.dart';

const backGroundColor = Color(0xFFFFFFFF);

final themeData = ThemeData(
  // Define the default brightness and colors.
  brightness: Brightness.light,
  primaryColor: Color(0xFFDA6317),
  backgroundColor: Color(0xFFFEF6ED),
  //cardColor: Color(0xFFF3F3F3),
  // scaffoldBackgroundColor: ColorTwo,
  bottomAppBarColor: Color(0xFF52E68B),
  hoverColor: Color(0xFFA8FDC8),
  secondaryHeaderColor: Color(0xFFFFFFFF),
  focusColor: Color(0xFFF1BF9C),
  indicatorColor: Color(0xFF717171),
  // Define the default font family.
  fontFamily: 'Roboto',

  // Define the default `TextTheme`. Use this to specify the default
  // text styling for headlines, titles, bodies of text, and more.
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    headline2: TextStyle(fontSize: 36.0),
    headline6: TextStyle(fontSize: 16.0, color: Color(0xFF717171)),
    bodyText1: TextStyle(fontSize: 20.0, color: Color(0xFF717171)),
    bodyText2: TextStyle(fontSize: 16.0),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        const Color(0xFFE5CDAD),
      ),
      //button color
      foregroundColor: MaterialStateProperty.all<Color>(
        const Color(0xFFDA6317),
      ), //text (and icon)
    ),
  ),
);

const ColorOne = Color(0xFF1D2566);
const ColorTwo = Color(0xFFFEF6ED);
const ColorThree = Color(0xFFE5CDAD);
const ColorFour = Color(0xFFA10141);
const ColorFive = Color(0xFFDA6317);
const ColorSix = Color(0xFFFEF6ED);