import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CourtView extends StatelessWidget {

  final Map<String, int> slotNumber;
  CourtView({this.slotNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffE5E5E5),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        children: List.generate(20, (index){
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Material(
              color: Colors.white,
              elevation: 10.0,
              borderRadius: BorderRadius.circular(10.0),
              shadowColor: Color(0x802196F3),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      heightFactor: 1.0,
                      widthFactor: 1.0,
                      child: Text(
                        'Court no.',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}