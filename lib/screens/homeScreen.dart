import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphs/charts/line_chart/line_model_class.dart';
import '../charts/bar_chart/bar_chart.dart';
import '../charts/line_chart/line_chart.dart';
import '../charts/pie_chart/pie_chart.dart';
import 'bar_chart_screen.dart';

class HomeScreen extends StatefulWidget{

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   List<PricePoint> pricePoints = [];

   @override
   void initState() {
     super.initState();
   fetchData();
   }

//Alertdialog for addind values of x and y
   Future<void> showInputDialog(BuildContext context) async {
     TextEditingController xController = TextEditingController();
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
                   controller: xController,
                   keyboardType: TextInputType.number,
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
                 double x = double.parse(xController.text);
                 double y = double.parse(yController.text);

                 pricePoints.clear();

                 // Add the new data point locally
                 setState(() {
                   pricePoints.add(PricePoint(x: x, y: y));
                 });

                 // Add the new data point to Firestore
                 await addDataPointsToFirestore(pricePoints);
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
   var docs = FirebaseFirestore.instance.collection('pricePoints');

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
     var docs = FirebaseFirestore.instance.collection('pricePoints');

    var querySnapshot = await docs.get();        //we use querysnapshot to get updated data from firestore

     // Extract data from Firestore and convert to PricePoint objects
     List<PricePoint> fetchedPricePoints = querySnapshot.docs
         .map((doc) => PricePoint.fromMap(doc as DocumentSnapshot<Object?>))
         .toList();

     //print values of fetched x and y
     for (var pricePoint in fetchedPricePoints) {
       print('Fetched Data: X: ${pricePoint.x}, Y: ${pricePoint.y}');
     }
     setState(() {
       pricePoints = fetchedPricePoints;
     });
   }

   // Add a list of PricePoints to Firestore
   Future<void> addDataPointsToFirestore(List<PricePoint> pricePoint) async {
     var docs = FirebaseFirestore.instance.collection('pricePoints');

     //print values of added x and y
     for (var pricePoint in pricePoint) {
       await docs.add(pricePoint.toMap());
       print('Added Data: X: ${pricePoint.x}, Y: ${pricePoint.y}');
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
              LineChartWidget(graphPoints: pricePoints),
              SizedBox(height: 30),
              SizedBox(height: 150,
                  child: MyBarChart(graphPoints: pricePoints)),
              // SizedBox(height: 300, width: 100, child: MyPiechart()),
            ],
          ),

      ),

    );
  }
}

