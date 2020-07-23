import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AdminChart extends StatefulWidget {
  final bookings;

  AdminChart({Key key, this.bookings}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<AdminChart> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  @override
  Widget build(BuildContext context) {
    List allMonths = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
    List existedMonths = new List();

    Map bookingDateMap = new Map();
    widget.bookings.forEach((booking) {
      final date = DateTime.parse(booking.bookedDate).month;
      if (bookingDateMap[date] == null) {
        bookingDateMap[date] = 0;
        existedMonths.add(date);
      }
      bookingDateMap[date] += 1;
    });
    print(bookingDateMap);
    allMonths.forEach((month) {
      if (!existedMonths.contains(month)) bookingDateMap[month] = 0.0;
    });
    
    List<FlSpot> flSpots = new List<FlSpot>();
    int highestCount = 0;
    final finalMap = new SplayTreeMap.from(bookingDateMap, (a,b) => a.compareTo(b));
    print(finalMap);
    finalMap.forEach((key, value) {
      if (value > highestCount) highestCount = value;
      flSpots.add(FlSpot(key.toDouble(), value.toDouble()));
    });

    final int yAxisUpperBoundary = ((highestCount + 9) ~/ 10) * 10;

    return LineChart(
      LineChartData(
        betweenBarsData: [
          BetweenBarsData(fromIndex: 0, toIndex: 0, colors: [Colors.amber, Colors.pink])
        ],
        gridData: FlGridData(drawHorizontalLine: false),
        borderData: FlBorderData(border: Border.all(width: 0)),
        //extraLinesData: ExtraLinesData(extraLinesOnTop: false),
        minX: 1,
        maxX: 12,
        minY: 0,
        maxY: yAxisUpperBoundary.toDouble(),
        titlesData: FlTitlesData(
          bottomTitles: SideTitles(
            showTitles: true,
            reservedSize: 20,
            getTitles: (value) {
              switch (value.toInt()) {
                case 1:
                  return 'Jan';
                case 2:
                  return 'Feb';
                case 3:
                  return 'Mar';
                case 4:
                  return 'Apr';
                case 5:
                  return 'May';
                case 6:
                  return 'Jun';
                case 7:
                  return 'Jul';
                case 8:
                  return 'Aug';
                case 9:
                  return 'Sep';
                case 10:
                  return 'Oct';
                case 11:
                  return 'Nov';
                case 12:
                  return 'Dec';
              }
              return '';
            },
            margin: 8,
          ),
          leftTitles: SideTitles(
            showTitles: true,
            reservedSize: 20,
            margin: 8,
            interval: yAxisUpperBoundary / 5,
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            dotData: FlDotData(show: false),
            colors: gradientColors,
            barWidth: 5,
            isStrokeCapRound: true,
            belowBarData: BarAreaData(
              show: true,
              // gradientFrom: Offset(0.0, 0.0),d
              gradientColorStops: [0.0, 1.0],
              colors: gradientColors.map((color) => color.withOpacity(0.5)).toList(),
            ),
            isCurved: true,
            spots: flSpots,
          )
        ],
      ),
    );
  }
}
