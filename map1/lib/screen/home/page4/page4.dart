import 'package:flutter/material.dart';
import 'package:map1/shared/constant.dart';

import 'package:dash_chat/dash_chat.dart';

// class Page4 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return null;
//   }
   
// }

class Page4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Container(
              height: 80,
              child: Center(
                child: Text(
                  "CHAT BOT",
                  style: TextStyle(
                      color: blue, fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              //color: Colors.pink,
              height: 530,
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 445,
                    width: double.infinity,
                    color: Colors.grey[100].withOpacity(1),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    color: Colors.white,
                    height: 60,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 310,
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Say something...",
                                hintStyle: lightBlueRegText,
                                border: InputBorder.none),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_forward,
                            color: blue,
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
