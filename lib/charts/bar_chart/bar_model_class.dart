import 'package:cloud_firestore/cloud_firestore.dart';


class BarPoints{
  late String week;
  late double y;

  BarPoints({required this.week, required this.y});

  factory BarPoints.fromMap(DocumentSnapshot documentSnapshot) {             //The factory constructor allows you to decide whether to return a new instance of the class or a previously cached instance.
    Map<String, dynamic>? data = documentSnapshot.data() as Map<String, dynamic>?;  //DocumentSnapshot represents a snapshot of a document in a Firestore database.

    if (data == null) {
      // Handle the case where data is null or not a valid map
      // You can return a default value or throw an exception, depending on your requirements.
      throw Exception('Invalid data in Firestore document');
    }

    // Extract x and y components
    String Weeks = data['Weeks'] is String ? data['Weeks'] : 0.0;
    double y = data['y'] is double ? data['y'] : 0.0;
    return BarPoints(week: Weeks, y: y);
  }

  Map<String, dynamic> toMap() {
    return {'Weeks': week, 'y': y};
  }

}