import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:map1/shared/constant.dart';

class DurationSlider extends StatefulWidget {
  @override
  _DurationSliderState createState() => _DurationSliderState();
}

class _DurationSliderState extends State<DurationSlider> {
  var rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.access_time,
                color: blue,
              ),
              SizedBox(
                width: 10,
              ),
              Text("Duration Hour(s)", style: blueBoldText)
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              showValueIndicator: ShowValueIndicator.always,
              
              inactiveTrackColor: Color(0xFFF1F9FF),
              trackHeight: 10,
              trackShape: RoundedRectSliderTrackShape(),
              activeTrackColor: blue,

              inactiveTickMarkColor: Color(0xFFBCE0FD),
              tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 3),
              activeTickMarkColor: blue,

              thumbShape: CustomSliderThumbCircle(thumbRadius: 10, min: 0, max: 3),
              overlayColor: blue.withOpacity(0.3),
              minThumbSeparation: 100,
            ),
            child: Slider(
              min: 0.0,
              max: 3.0,
              value: rating.toDouble(),
              divisions: 3,
              onChanged: (val) {
                setState(() {
                  rating = val;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}



class CustomSliderThumbCircle extends SliderComponentShape {
  final double thumbRadius;
  final int min;
  final int max;

  const CustomSliderThumbCircle({
    @required this.thumbRadius,
    this.min = 0,
    this.max = 10,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
  }) {
    final Canvas canvas = context.canvas;

    TextSpan span = new TextSpan(
      style: new TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: blue,
      ),
      text: getValue(value),
    );

    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();
    Offset textCenter =
        Offset(center.dx - (tp.width / 2), center.dy + 20);


    canvas.drawCircle(center, 15, Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill);

    canvas.drawCircle(center, 12, Paint()
      ..color = blue
      ..style = PaintingStyle.fill);
    tp.paint(canvas, textCenter);
  }

  String getValue(double value) {
    return ((max * value).round()).toString();
  }
}