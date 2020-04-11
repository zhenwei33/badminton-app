import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:map1/shared/constant.dart';

class AdminChart extends StatefulWidget {
  final Widget child;

  AdminChart({Key key, this.child}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<AdminChart> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
        betweenBarsData: [
          BetweenBarsData(
              fromIndex: 0, toIndex: 0, colors: [Colors.amber, Colors.pink])
        ],
        gridData: FlGridData(drawHorizontalLine: false),
        borderData: FlBorderData(border: Border.all(width: 0)),
        //extraLinesData: ExtraLinesData(extraLinesOnTop: false),
        minX: 0,
        maxX: 10,
        minY: 0,
        maxY: 10,
        titlesData: FlTitlesData(
          bottomTitles: SideTitles(
              showTitles: true,
              reservedSize: 20,
              getTitles: (value) {
                switch (value.toInt()) {
                  case 2:
                    return 'MAR';
                  case 5:
                    return 'JUN';
                  case 8:
                    return 'SEP';
                }
                return '';
              },
              margin: 8),
          leftTitles: SideTitles(
              showTitles: true,
              reservedSize: 20,
              getTitles: (value) {
                switch (value.toInt()) {
                  case 2:
                    return '2';
                  case 4:
                    return '4';
                  case 6:
                    return '6';
                  case 8:
                    return '8';
                  case 10:
                    return '10';
                }
                return '';
              },
              margin: 8),
        ),
        lineBarsData: [
          LineChartBarData(
              dotData: FlDotData(show: false),
              colors: gradientColors,
              barWidth: 5,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(
                show: true,
                // gradientFrom: Offset(0.0, 0.0),
                // gradientTo: Offset(0.0, 1.0),
                gradientColorStops: [0.0, 1.0],
                colors: gradientColors
                    .map((color) => color.withOpacity(0.5))
                    .toList(),
              ),
              isCurved: true,
              spots: [
                FlSpot(0.0, 2.0),
                FlSpot(3.0, 1.0),
                FlSpot(5.0, 6.0),
                // FlSpot(0.0, 9.0),
                // FlSpot(4.0, 10.0),
                // FlSpot(8.0, 10.0),
                FlSpot(10.0, 9.0),
              ])
        ]));
  }
}