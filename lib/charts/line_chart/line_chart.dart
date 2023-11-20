import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'line_model_class.dart';

class LineChartWidget extends StatelessWidget {
  LineChartWidget({required this.graphPoints});

  final List<PricePoint> graphPoints;  //The widget takes a list of DataPoint objects as a parameter. DataPoint seems to be a custom class holding x and y values.

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(LineChartData(lineBarsData: [LineChartBarData(
          spots: graphPoints.map((point) => FlSpot(point.x, point.y)).toList(),   //spots is a list of FlSpot objects, which are used to represent points on the chart. It maps the x and y values from each DataPoint in the provided list.
          isCurved: false, dotData: FlDotData(show: true))

      ])),
    );
  }
}