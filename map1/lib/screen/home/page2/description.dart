import 'package:flutter/material.dart';
import 'package:map1/shared/constant.dart';

class Description extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        border: Border.all(color: blue3)
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Description",
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: Color(0xFFBCE0FD)
          )
        ),
      ),
    );
  }

}