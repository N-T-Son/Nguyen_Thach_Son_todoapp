import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Color.fromARGB(255, 197, 197, 237),
  iconTheme: const IconThemeData(
    color: Color.fromARGB(255, 254, 248, 248),
    size: 25,
    
  ),
  appBarTheme: const AppBarTheme(backgroundColor: Color.fromARGB(255, 46, 45, 45), elevation: 0),
  tabBarTheme: const TabBarTheme(
    labelColor: Color.fromARGB(255, 255, 255, 255),
  ),
);
