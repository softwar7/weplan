import 'package:flutter/material.dart';


ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Color.fromRGBO(48, 129, 208, 1), //커서 및 각종 텍스트색 영향받음
    secondary: Color.fromRGBO(109, 185, 239, 1),
  ),
  //입력 텍스트 색상
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
  ),

  drawerTheme: const DrawerThemeData(
    backgroundColor: Color.fromRGBO(250, 238, 209, 1),
    elevation: 0,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromRGBO(250, 238, 209, 1),
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontStyle: FontStyle.normal,
    ),
    iconTheme: IconThemeData(color: Colors.black),
    actionsIconTheme: IconThemeData(color: Colors.black),
    titleSpacing: 50.0,
  ),
  dialogTheme: DialogTheme(
    backgroundColor: const Color.fromRGBO(250, 238, 209, 1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    titleTextStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(221, 0, 0, 0), //다이얼로그 대제목
      fontSize: 22,
    ),
    contentTextStyle: const TextStyle(
      color: Colors.black,
      fontSize: 18,
    ),
    actionsPadding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
    alignment: Alignment.center,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      disabledBackgroundColor: const Color.fromARGB(50, 48, 128, 208),
      disabledForegroundColor: const Color.fromARGB(150, 25, 67, 109),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(width: 1, color: Colors.white),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      shadowColor: Colors.transparent,
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  scaffoldBackgroundColor: const Color.fromRGBO(250, 238, 209, 1),

  //스케줄 상세정보 창
  bottomSheetTheme: const BottomSheetThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: Color.fromRGBO(250, 238, 209, 1),
    modalBarrierColor: Colors.transparent,
  ),
  // inputDecorationTheme: InputThemeLight.defaultInputDecorationTheme,
);
