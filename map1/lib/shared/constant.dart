import 'package:flutter/material.dart';

Color darkGreyColor = Color(0xFF212128);
Color blue = Color(0xFF2699FB);

Color white = Color(0xFFF2FBFF);
Color blue1 = Color(0xFFDBF5FF);
Color blue2 = Color(0xFFC6F0FF);
Color blue3 = Color(0xFFB7EDFF);
//Color blue4 = Color(0xFFB7EDFF);
Color teal = Color(0xFF80FCE5);

TextStyle heading = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 30,
  fontWeight: FontWeight.normal,
  color: blue
);

TextStyle articleTitle = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 18,
  fontWeight: FontWeight.normal,
  color: white
);

TextStyle announcementTitle = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 16,
  fontWeight: FontWeight.normal,
  color: blue
);

TextStyle announcementTime = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 12,
  fontWeight: FontWeight.normal,
  color: Colors.grey
);

InputDecoration customInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.indigoAccent[100],
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.amber[100],
      width: 1.0,
    )
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.deepOrangeAccent[100],
      width: 1.0,
    )
  )
);
