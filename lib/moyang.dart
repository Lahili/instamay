import 'package:flutter/material.dart';

var theme = ThemeData(
  appBarTheme: AppBarTheme(
      color: Colors.grey,
      titleTextStyle: TextStyle(
        fontSize: 25,
      ),
      actionsIconTheme: IconThemeData(size: 40)),
  textTheme: TextTheme(
    bodyText2: TextStyle(color: Colors.grey),
    headline6: TextStyle(color: Colors.amber),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(selectedItemColor: Colors.redAccent,unselectedItemColor: Colors.black,
      showUnselectedLabels: false,backgroundColor: Colors.amber,showSelectedLabels: true,elevation: 10,
  ),
);
