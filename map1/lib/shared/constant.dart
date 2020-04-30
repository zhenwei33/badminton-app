import 'package:flutter/material.dart';

Color darkGreyColor = Color(0xFF212128);
Color blue = Color(0xFF2699FB);

Color white = Color(0xFFF2FBFF);
Color blue1 = Color(0xFFDBF5FF);
Color blue2 = Color(0xFFC6F0FF);
Color blue3 = Color(0xFFB7EDFF);
//Color blue4 = Color(0xFFB7EDFF);

Color darkBlue = Color(0xFF87a4cc);
Color teal = Color(0xFF80FCE5);

Color lightBlue = Color(0xFFBCE0FD);

//WHITE
TextStyle whiteReg_30 = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 30,
  fontWeight: FontWeight.normal,
  color: Colors.white
);

TextStyle whiteReg_18 = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 18,
  fontWeight: FontWeight.normal,
  color: white
);

TextStyle whiteReg_16 = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 16,
  fontWeight: FontWeight.normal,
  color: Colors.white
);

TextStyle whiteBold_14 = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: Colors.white
);

TextStyle whiteReg_14 = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 14,
  fontWeight: FontWeight.normal,
  color: Colors.white
);


//BLUE
//========================================================
TextStyle heading = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 30,
  fontWeight: FontWeight.normal,
  color: blue
);

TextStyle blueBold_20 = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: blue
);

TextStyle blueReg_20 = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 20,
  fontWeight: FontWeight.normal,
  color: blue
);

TextStyle blueBold_14 = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: blue
);

TextStyle blueReg_16 = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 16,
  fontWeight: FontWeight.normal,
  color: blue
);

TextStyle blueReg_14 = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 14,
  fontWeight: FontWeight.normal,
  color: blue
);

TextStyle blueReg_12 = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 12,
  fontWeight: FontWeight.normal,
  color: blue
);


//LIGHT BLUE
//========================================================
TextStyle lightBlueReg_18 = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 18,
  fontWeight: FontWeight.normal,
  color: lightBlue
);

TextStyle lightBlueReg_12 = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 12,
  fontWeight: FontWeight.normal,
  color: lightBlue
);


//GREY
//========================================================
TextStyle greyReg_12 = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 12,
  fontWeight: FontWeight.normal,
  color: Colors.grey
);
//========================================================


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


TextStyle eventText = TextStyle(color: blue, fontWeight: FontWeight.normal);