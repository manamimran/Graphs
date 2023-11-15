import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphs/charts/bar_chart/bar_data.dart';

class MyBarChart extends StatelessWidget{
  MyBarChart({required this.weeklySummary});
 final List weeklySummary;

  @override
  Widget build(BuildContext context) {
    BarData  barData =
    BarData(
        sunAmmount: weeklySummary[0],
        monAmmount: weeklySummary[1],
        tuesAmmount: weeklySummary[2],
        wedAmmount: weeklySummary[3],
        thursAmmount: weeklySummary[4],
        friAmmount: weeklySummary[5],
        satAmmount: weeklySummary[6]);
    barData.iniializeBarData();

   return BarChart(
      BarChartData(
        maxY: 200,
        minY: 0,
        barGroups: barData.barData.map((data) => BarChartGroupData(x: data.x,
        barRods: [BarChartRodData(toY: data.y)],
        )).toList(),
      )  ,
   );
  }


}