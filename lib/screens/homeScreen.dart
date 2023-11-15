import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../charts/bar_chart/bar_chart.dart';
import '../charts/line_chart/line_chart.dart';
import '../charts/pie_chart/pie_chart.dart';
import '../charts/line_chart/salesData.dart';

class HomeScreen extends StatefulWidget{

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   List<PricePoint> pricePoint = [];

   @override
   void initState() {
     super.initState();
   fetchData();
   }
// Function to clear data from Firestore
  Future<void> clearDataFromFirestore() async {
    CollectionReference dataCollection =
    FirebaseFirestore.instance.collection('pricePoints');

    QuerySnapshot querySnapshot = await dataCollection.get();         ////we use querysnapshot to get updated data from firestore

    // Iterate through the documents and delete them
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
    // Optionally, you may want to fetch updated data or update the state
    fetchData();
  }
   // Fetch data from Firestore
   Future<void> fetchData() async {
     CollectionReference dataCollection =
     FirebaseFirestore.instance.collection('pricePoints');

     QuerySnapshot querySnapshot = await dataCollection.get();        //we use querysnapshot to get updated data from firestore

     // Extract data from Firestore and convert to PricePoint objects
     List<PricePoint> fetchedPricePoints = querySnapshot.docs
         .map((doc) => PricePoint.fromMap(doc as DocumentSnapshot<Object?>))
         .toList();

     print('Fetched Data:');
     for (var pricePoint in fetchedPricePoints) {
       print('X: ${pricePoint.x}, Y: ${pricePoint.y}');
     }
     setState(() {
       pricePoint = fetchedPricePoints;
     });
   }

   // Add a list of PricePoints to Firestore
   Future<void> addDataPointsToFirestore(List<PricePoint> pricePoint) async {
     CollectionReference dataCollection =
     FirebaseFirestore.instance.collection('pricePoints');

     for (var pricePoint in pricePoint) {
       await dataCollection.add(pricePoint.toMap());
       print('Added Data: X: ${pricePoint.x}, Y: ${pricePoint.y}');
     }

     fetchData(); // Refresh the data after adding new points
   }

  // List<double> weeklySummary = [4.40, 2.50, 42.42, 10.50, 100.20, 88.99, 90.10];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My FL Graphs'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ElevatedButton(onPressed: (){
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => LineChartWidget())
            //   );
            // }, child: Text('next')),
            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                setState(() {
                // Replace this with logic to add data points to Firestore
                List<PricePoint> newDataAdded = [
                  PricePoint(x: 6.0, y: 42.0),
                  PricePoint(x: 7.0, y: 30.0),
                  PricePoint(x: 8.0, y: 59.0),
                  PricePoint(x: 9.0, y: 50.0),
                  PricePoint(x: 10.0, y: 27.0)
                  // Add more data points as needed
                ];
                addDataPointsToFirestore(newDataAdded);
                print('data added');
                });// Add more data points as needed
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
            LineChartWidget(graphPoints: pricePoint),
        // SizedBox(height: 150,
        //                   child: MyBarChart(weeklySummary: pricePoint)),
          ],
        ),
      ),

            // Container(
            //   child: ListView.builder(
            //     itemCount: valueList.length,
            //     itemBuilder: (context, index) {
            //       PricePoint value = valueList[index];
            //       return   ListTile(
            //
            //               title:Text('${value.x} ${value.y}'),
            //
            //       );
            //     },
            //   ),
            // ),

            // SizedBox(
            //   child: value == null
            //       ? CircularProgressIndicator()
            //       : LineChart(
            //           LineChartData(
            //             lineBarsData: [
            //               LineChartBarData(
            //                 spots: value
            //                     .map((point) => FlSpot(point.x, point.y))
            //                     .toList(),
            //                 isCurved: true,
            //                 dotData: FlDotData(show: true),
            //               ),
            //             ],
            //           ),
            //         ),
            // ),

            // SizedBox(height: 30), // Add some spacing
            // SizedBox(
            //     height: 150, child: MyBarChart(weeklySummary: weeklySummary)),
            // SizedBox(height: 300, width: 100, child: MyPiechart()),

      //   Column(
      //   children: [
      //     // ElevatedButton(onPressed: (){
      //     //   Navigator.push(
      //     //       context,
      //     //       MaterialPageRoute(builder: (context) => LineChartWidget())
      //     //   );
      //     // }, child: Text('next')),
      //     SizedBox(height: 30),
      //     LineChartWidget(graphPoints:pricePoints),
      //     ElevatedButton(
      //       onPressed: () {
      //         // Replace this with the actual list of data points you want to add
      //         List<PricePoint> newDataPoints = [
      //           PricePoint(x: 6.0, y: 42.0),
      //           PricePoint(x: 7.0, y: 30.0),
      //           // Add more data points as needed
      //         ];
      //         addDataPointsToFirestore(newDataPoints);
      //         print('data added');
      //       },
      //       child: Text('Add Data to Firestore'),
      //     ),
      //
      //     SizedBox(height: 30),
      //     // Add some spacing
      //     SizedBox(height: 150,
      //         child: MyBarChart(weeklySummary: weeklySummary)),
      //     SizedBox(height: 300, width: 100,
      //         child: MyPiechart()),
      //   ],
      // ),

//          floatingActionButton: FloatingActionButton(
//            onPressed: () {
//              // Replace this with the actual list of data points you want to add
//              List<PricePoint> newDataPoints = [
//                PricePoint(x: 6.0, y: 42.0),
//                PricePoint(x: 7.0, y: 30.0),
//                PricePoint(x: 8.0, y: 59.0),
//                PricePoint(x: 9.0, y: 50.0),
//                PricePoint(x: 10.0, y: 27.0),
//                // Add more data points as needed
//              ];
//              addDataPointsToFirestore(newDataPoints);
//            },
//            child: Icon(Icons.add),
//          ),
//        );
//      }
// }

      // Container(
      //   child: ListView.builder(
      //     itemCount: pricePoints.length,
      //     itemBuilder: (context, index) {
      //       PricePoint value = pricePoints[index];
      //       return   ListTile(
      //
      //               title:Text('${value.x} ${value.y}'),
      //
      //       );
      //     },
      //   ),
      // ),

      // SingleChildScrollView(
      //   child: Column(
      //           children: [
      //             // ElevatedButton(onPressed: (){
      //             //   Navigator.push(
      //             //       context,
      //             //       MaterialPageRoute(builder: (context) => LineChartWidget())
      //             //   );
      //             // }, child: Text('next')),
      //             SizedBox(height: 30),
      //             LineChartWidget(pricePoints: pricePoints),
      //             ElevatedButton(
      //               onPressed: () {
      //                 // Replace this with logic to add data points to Firestore
      //                 addDataPointToFirestore(PricePoint(x: 3.0, y: 60.0));
      //                 // Add more data points as needed
      //               },
      //               child: Text('Add Data to Firestore'),
      //             ),
      //             SizedBox(height: 30), // Add some spacing
      //             SizedBox(height: 150,
      //                 child: MyBarChart(weeklySummary: weeklySummary)),
      //             SizedBox(height: 300,width: 100,
      //                   child: MyPiechart()),
      //           ],
      //         ),
      // ),
    );
  }
}
