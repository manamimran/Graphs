import 'package:graphs/charts/bar_chart/single_bar.dart';

class BarData{
  final double sunAmmount;
  final double monAmmount;
  final double tuesAmmount;
  final double wedAmmount;
  final double thursAmmount;
  final double friAmmount;
  final double satAmmount;

  BarData({required this.sunAmmount, required this.monAmmount, required this.tuesAmmount, required this.wedAmmount, required
      this.thursAmmount, required this.friAmmount, required this.satAmmount});

  List<SingleBar> barData =[ ];

    void iniializeBarData(){
    barData= [
     SingleBar(x: 0, y: sunAmmount),
     SingleBar(x: 1, y: monAmmount),
     SingleBar(x: 2, y: tuesAmmount),
     SingleBar(x: 3, y: wedAmmount),
     SingleBar(x: 4, y: thursAmmount),
     SingleBar(x: 5, y: friAmmount),
     SingleBar(x: 6, y: satAmmount),
    ];
}

}