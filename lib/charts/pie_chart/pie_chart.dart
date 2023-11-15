import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPiechart extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PieChart(
        PieChartData(
            centerSpaceRadius: 40,
            borderData: FlBorderData(show: false),
            sectionsSpace: 0,
          sections: [
            PieChartSectionData(
              value: 20,
              color: Colors.grey,
              titleStyle:TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xffffffff),
              ),
            ),
            PieChartSectionData(
              value: 40,
              color: Colors.blue,
              titleStyle:TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xffffffff),
            ),
            ),
            PieChartSectionData(
              value: 10,
              color: Colors.red,
              titleStyle:TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xffffffff),
          ),
            ),
            PieChartSectionData(
              value: 25,
              color: Colors.purple,
              titleStyle:TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xffffffff),
              ),
            ),
          ]
        )
      ),
    );
  }
}


