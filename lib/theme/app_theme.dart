import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
      primaryColor: Colors.blueAccent,
      secondaryHeaderColor: Colors.blueAccent.shade700,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.white,
          )),
      buttonTheme: const ButtonThemeData(buttonColor: Colors.white, padding: EdgeInsets.all(8.0)),
      bottomAppBarTheme: const BottomAppBarTheme(color: Colors.black),
      tabBarTheme: const TabBarTheme(
        indicatorColor: Colors.white,
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
      ));

  static final ThemeData darkTheme = ThemeData(
      primaryColor: Colors.blueAccent,
      secondaryHeaderColor: Colors.blueAccent.shade700,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.white,
          )),
      buttonTheme: const ButtonThemeData(buttonColor: Colors.white, padding: EdgeInsets.all(8.0)),
      bottomAppBarTheme: const BottomAppBarTheme(color: Colors.black),
      tabBarTheme: const TabBarTheme(
        indicatorColor: Colors.white,
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
      ));
}
