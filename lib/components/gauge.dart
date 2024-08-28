import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

Widget Guage(String head, double value, double tot, Color used, Color free,
    Icon icon, double w) {
  return PieChart(
    dataMap: <String, double>{head: value},
    chartType: ChartType.ring,
    baseChartColor: free,
    colorList: <Color>[used],
    chartRadius: 400,
    legendOptions: LegendOptions(showLegends: false),
    centerWidget: icon,
    chartValuesOptions: ChartValuesOptions(showChartValues: false),
    initialAngleInDegree: 270,
    totalValue: tot,
    ringStrokeWidth: w,
  );
}
