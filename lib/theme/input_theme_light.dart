import 'package:flutter/material.dart';


class InputThemeLight {
  static InputDecorationTheme defaultInputDecorationTheme =
      const InputDecorationTheme(
    labelStyle: TextStyle(
      color: Color.fromARGB(255, 18, 49, 79),
    ),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(90.0),
        topRight: Radius.circular(30.0),
        bottomLeft: Radius.circular(30.0),
        bottomRight: Radius.circular(90.0),
      ),
      borderSide: BorderSide(color: Color.fromARGB(150, 79, 78, 78)),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 30.0), //입력필드 양쪽 여백
    filled: true,
    fillColor: Color.fromRGBO(244, 244, 243, 1),
    hintStyle: TextStyle(color: Colors.red),
    errorStyle: TextStyle(color: Colors.redAccent), //인풋에러메세지
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(90.0),
        topRight: Radius.circular(30.0),
        bottomLeft: Radius.circular(30.0),
        bottomRight: Radius.circular(90.0),
      ),
      borderSide: BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(90.0),
        topRight: Radius.circular(30.0),
        bottomLeft: Radius.circular(30.0),
        bottomRight: Radius.circular(90.0),
      ),
      borderSide: BorderSide(color: Colors.red),
    ),
    focusedBorder: OutlineInputBorder(
      //눌렀을때 테두리
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(90.0),
        topRight: Radius.circular(30.0),
        bottomLeft: Radius.circular(30.0),
        bottomRight: Radius.circular(90.0),
      ),
      borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
    ),
    enabledBorder: OutlineInputBorder(
      //평상시 윤곽선
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(90.0),
        topRight: Radius.circular(30.0),
        bottomLeft: Radius.circular(30.0),
        bottomRight: Radius.circular(90.0),
      ),
      borderSide: BorderSide(color: Color.fromARGB(100, 31, 31, 31)),
    ),
  );
}
