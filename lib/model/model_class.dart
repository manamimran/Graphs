import 'dart:ui';

class ModelClass{
 late int saleValue;
 late String saleYear;
 late Color colorValue;

  ModelClass({required this.saleValue, required this.saleYear, required this.colorValue});

  ModelClass.fromMap(Map<String, dynamic> map){

    saleValue = map["SaleValue"] ;
    saleYear = map["SaleYear"];
    colorValue =Color(map["ColorValue"]);
  }

 Map<String, dynamic> toMap(){       // hashmap for setting data to firestore
   return {

     "SaleValue" : saleValue,
     "SaleYear" : saleYear,
     "ColorValue" : colorValue.value,
   };
 }
}