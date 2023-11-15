import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/src/chart/base/axis_chart/axis_chart_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class PricePoint {
  late double x;
  late double y;

  PricePoint({required this.x, required this.y});

  Map<String, dynamic> toMap() {
    return {'x': x, 'y': y};
  }

  factory PricePoint.fromMap(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    if (data == null) {
      // Handle the case where data is null or not a valid map
      // You can return a default value or throw an exception, depending on your requirements.
      throw Exception('Invalid data in Firestore document');
    }

    // Extract x and y components
    double x = data['x'] is double ? data['x'] : 0.0;
    double y = data['y'] is double ? data['y'] : 0.0;

    return PricePoint(x: x, y: y);
  }


  // PricePoint.fromMap(Map<String, dynamic> data){         //hashmap for getting data from firestore
  //   x = data["x"];
  //   y = data["y"];
  // }

}
//
// List<PricePoint> get princePoints {
//   final data = <double>[70, 90, 77, 93, 65, 55, 56, 20];
//   return data
//       .mapIndexed(
//           (index, element) => PricePoint.list(x: index.toDouble(), y: element))
//       .toList();
// }

