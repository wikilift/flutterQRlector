import 'package:flutter/material.dart';

class CustomTheme {
  static Color primaryColor = Colors.red;
  static ThemeData theme = ThemeData.light().copyWith(
    primaryColor: primaryColor,
    appBarTheme: const AppBarTheme(color: Colors.red),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: Colors.red),
    elevatedButtonTheme:
        ElevatedButtonThemeData(style: ElevatedButton.styleFrom(primary: primaryColor, shape: const StadiumBorder())),
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: primaryColor, selectedItemColor: Colors.amber),
    unselectedWidgetColor: Colors.grey,
    primaryTextTheme: Typography(platform: TargetPlatform.android).black,
    //textTheme: Typography(platform: TargetPlatform.android, black: TextTheme()).black,
    /* textTheme: const TextTheme(
      bodyText1: TextStyle(),
      bodyText2: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    ).apply(
      bodyColor: Colors.orange,
      displayColor: Colors.blue,
    ),*/
  );
}
