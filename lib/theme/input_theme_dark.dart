import 'package:flutter/material.dart';

class InputThemeDark {
  static InputDecorationTheme defaultInputDecorationTheme =
      const InputDecorationTheme(
    labelStyle: TextStyle(
      color: Color.fromARGB(255, 255, 255, 255),
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
    fillColor: Color(0xFF363062),
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
      borderSide: BorderSide(color: Color(0xFFF5E8C7)),
    ),
    enabledBorder: OutlineInputBorder(
      //평상시 윤곽선
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(90.0),
        topRight: Radius.circular(30.0),
        bottomLeft: Radius.circular(30.0),
        bottomRight: Radius.circular(90.0),
      ),
      borderSide: BorderSide(color: Color(0xFF818FB4)),
    ),
  );
}
