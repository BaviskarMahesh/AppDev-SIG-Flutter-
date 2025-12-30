import 'package:flutter/material.dart';

class AppThemes{
  static ThemeData lightTheme=ThemeData(
    primaryColor: Colors.greenAccent,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.greenAccent,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500
      ),
    )
  );
}