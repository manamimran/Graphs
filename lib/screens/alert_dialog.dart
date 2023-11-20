import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../charts/line_chart/line_model_class.dart';

class AlertDialog extends StatefulWidget{
  // AlertDialog(this.pricePoint);
  //  final PricePoint pricePoint;
  @override
  State<AlertDialog> createState() => _AlertDialogState();


}

class _AlertDialogState extends State<AlertDialog> {
  TextEditingController xController = TextEditingController();
  TextEditingController yController = TextEditingController();



  @override
  Widget build(BuildContext context) {
  return AlertDialog(

  );
    }}