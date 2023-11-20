
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../charts/bar_chart/bar_chart.dart';
import '../charts/bar_chart/bar_model_class.dart';

class BarChartScreen extends StatefulWidget{
  @override
  State<BarChartScreen> createState() => _BarChartScreenState();
}

class _BarChartScreenState extends State<BarChartScreen> {
  List<BarPoints> barPoints = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

//Alertdialog for addind values of x and y
  Future<void> showInputDialog(BuildContext context) async {
    TextEditingController weeksController = TextEditingController();
    TextEditingController yController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Data Points'),
          content: Container(
            height: 200,
            child: Column(
              children: [
                TextField(
                  controller: weeksController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'X Value'),
                ),
                TextField(
                  controller: yController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Y Value'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Get the values of X and Y and add a new data point
                String x = weeksController.text;
                double y = double.parse(yController.text);

                barPoints.clear();

                // Add the new data point locally
                setState(() {
                  barPoints.add(BarPoints(week: x, y: y));
                });

                // Add the new data point to Firestore
                await addDataPointsToFirestore(barPoints);
                await fetchData();

                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

// Function to clear data from Firestore
  Future<void> clearDataFromFirestore() async {
    var docs = FirebaseFirestore.instance.collection('barPoints');

    var querySnapshot = await docs.get();         ////we use querysnapshot to get updated data from firestore

    // Iterate through the documents and delete them
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {       //This is a loop that iterates over each document (QueryDocumentSnapshot) in the querySnapshot.docs collection.
      await doc.reference.delete();
    }
    setState(() {});
    // Optionally, you may want to fetch updated data or update the state
    fetchData();
  }

  // Fetch data from Firestore
  Future<void> fetchData() async {
    var docs = FirebaseFirestore.instance.collection('barPoints');

    var querySnapshot = await docs.get();        //we use querysnapshot to get updated data from firestore

    // Extract data from Firestore and convert to PricePoint objects
    List<BarPoints> fetchedPricePoints = querySnapshot.docs
        .map((doc) => BarPoints.fromMap(doc as DocumentSnapshot<Object?>))
        .toList();

    //print values of fetched x and y
    for (var pricePoint in fetchedPricePoints) {
      print('Fetched Data: X: ${pricePoint.week}, Y: ${pricePoint.y}');
    }
    setState(() {
      barPoints = fetchedPricePoints;
    });
  }

  // Add a list of PricePoints to Firestore
  Future<void> addDataPointsToFirestore(List<BarPoints> pricePoint) async {
    var docs = FirebaseFirestore.instance.collection('barPoints');

    //print values of added x and y
    for (var pricePoint in pricePoint) {
      await docs.add(pricePoint.toMap());
      print('Added Data: X: ${pricePoint.week}, Y: ${pricePoint.y}');
    }
    //  fetchData(); // Refresh the data after adding new points
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
       appBar: AppBar(
       title: Text('My FL Graphs'),
       ),
     body: SingleChildScrollView(
       child: Column(
         children: [
           SizedBox(height: 30),
           ElevatedButton(
             onPressed: () {
               showInputDialog(context);
             },
             child: Text('Add Data to Firestore'),
           ),
           ElevatedButton(
             onPressed: () {
               setState(() {
                 // Replace this with logic to clear data points from Firestore
                 clearDataFromFirestore();
                 print('Data cleared');
               });
             },
             child: Text('Clear Data in Firestore'),
           ),
           Padding( padding: EdgeInsets.all(20.0),
             child: SizedBox(height: 300,
                // child: MyBarChart(graphPoints: barPoints)),
           ),
           )
         ],
       ),
     ),
   );
  }
}