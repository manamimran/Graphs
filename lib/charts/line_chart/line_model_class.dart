import 'package:cloud_firestore/cloud_firestore.dart';


class PricePoint {
  late double x;
  late double y;

  PricePoint({required this.x, required this.y});


  factory PricePoint.fromMap(DocumentSnapshot documentSnapshot) {             //The factory constructor allows you to decide whether to return a new instance of the class or a previously cached instance.
    Map<String, dynamic>? data = documentSnapshot.data() as Map<String, dynamic>?;  //DocumentSnapshot represents a snapshot of a document in a Firestore database.

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

  Map<String, dynamic> toMap() {
    return {'x': x, 'y': y};
  }


}


