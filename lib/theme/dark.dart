import 'package:flutter/material.dart';


ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF363062),
    secondary: Color(0xFF818FB4),
    // onPrimary: Colors.white,
    // onSecondary: Colors.white70,
  ),
  //입력 텍스트 색상
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
  ),

  drawerTheme: const DrawerThemeData(
    backgroundColor: Color(0xFF363062),
    elevation: 0,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF435585),
    iconTheme: IconThemeData(color: Colors.white),
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontStyle: FontStyle.normal,
    ),
    titleSpacing: 50.0,
  ),
  dialogTheme: DialogTheme(
    backgroundColor: const Color.fromARGB(255, 66, 64, 103),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
    titleTextStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 22,
    ),
    contentTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 18,
    ),
    actionsPadding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
    alignment: Alignment.center,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFF5E8C7),
      foregroundColor: const Color.fromARGB(255, 16, 11, 33),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(width: 1, color: Colors.white),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.lightBlueAccent,
      shadowColor: Colors.transparent,
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  scaffoldBackgroundColor: const Color(0xFF363062),

  bottomSheetTheme: const BottomSheetThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: Color(0xFF4D4C7D),
    modalBarrierColor: Colors.transparent,
  ),
  // inputDecorationTheme: InputThemeDark.defaultInputDecorationTheme,
);
