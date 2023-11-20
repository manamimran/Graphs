import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../line_chart/line_model_class.dart';


class MyBarChart extends StatefulWidget {
  MyBarChart({required this.graphPoints});

  final List<PricePoint> graphPoints;

  @override
  State<MyBarChart> createState() => _MyBarChartState();
}

class _MyBarChartState extends State<MyBarChart> {
  @override
  Widget build(BuildContext context) {
    // Sort the graphPoints based on weekdays
    List<PricePoint> sortedGraphPoints = sortGraphPointsByWeekday(widget.graphPoints);

   return BarChart(
      BarChartData(
        maxY: 200,
        minY: 0,
          barGroups:sortedGraphPoints.map((data) => BarChartGroupData(x: data.x.toInt(),
            barRods: [BarChartRodData(toY: data.y)],
          )).toList(),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: bottomTitles,
              ),
            ),
          )
      ),
    );
  }

  List<PricePoint> sortGraphPointsByWeekday(List<PricePoint> graphPoints) {
    // Sort the graphPoints based on weekdays (assuming x represents weekdays)
    graphPoints.sort((a, b) => a.x.compareTo(b.x));
    return graphPoints;
  }
}

Widget bottomTitles(double value, TitleMeta meta) {
  final style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  String text;
  switch (value.toInt()) {
    case 1:
      text = 'Mon';
      break;
    case 2:
      text = 'Tue';
      break;
    case 3:
      text = 'Wed';
      break;
    case 4:
      text = 'Thu';
      break;
    case 5:
      text = 'Fri';
      break;
    case 6:
      text = 'Sat';
      break;
    case 7:
      text = 'Sun';
      break;
    default:
      text = '';
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 7,
    child: Text(text, style: style),
  );
}

