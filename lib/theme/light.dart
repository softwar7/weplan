import 'package:flutter/material.dart';

import 'package:weplan/theme/input_theme_light.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Color.fromRGBO(48, 129, 208, 1), //커서 및 각종 텍스트색 영향받음
    secondary: Color.fromRGBO(109, 185, 239, 1),
  ),
  //입력 텍스트 색상
  textTheme:const  TextTheme(
    bodyLarge: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
  ),

  drawerTheme: const DrawerThemeData(
    backgroundColor: Color.fromRGBO(250, 238, 209, 1),
    elevation: 0,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 48, 128, 208),
    iconTheme: IconThemeData(color: Colors.white),
    centerTitle: true,
    // shadowColor: Colors.black,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontStyle: FontStyle.normal,
    ),
    titleSpacing: 50.0,
  ),
  dialogTheme: DialogTheme(
    backgroundColor: const Color.fromRGBO(244, 242, 126, 1), //
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
      // backgroundColor: Color.fromARGB(255, 48, 128, 208),
      disabledBackgroundColor: const Color.fromARGB(50, 48, 128, 208),
      disabledForegroundColor: const Color.fromARGB(150, 25, 67, 109),
      // backgroundColor: const Color.fromARGB(50, 48, 128, 208),
      // foregroundColor: const Color.fromARGB(150, 25, 67, 109),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(width: 1, color: Colors.white),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: const Color.fromARGB(50, 48, 128, 208),
      foregroundColor: const Color.fromARGB(150, 25, 67, 109),
      shadowColor: Colors.transparent,
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  scaffoldBackgroundColor:const  Color.fromRGBO(244, 244, 243, 1), //앱자체 배경색

  //스케줄 상세정보 창
  bottomSheetTheme: const BottomSheetThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: Color.fromARGB(255, 244, 242, 126),
    modalBarrierColor: Colors.transparent,
  ),
  inputDecorationTheme: InputThemeLight.defaultInputDecorationTheme,
);
