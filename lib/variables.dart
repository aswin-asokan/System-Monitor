import 'package:fl_chart/fl_chart.dart';

//Variables required for app functioning
double cpuUsage = 0.0;
double memoryTotal = 0.0;
double memoryUsed = 0.0;
double memoryUsedGB = 0.0;
double memoryTotGB = 0.0;
double memoryFree = 0.0;
double memUsage = 0.0;
double diskTotal = 0.0;
double diskUsed = 0.0;
double diskUsage = 0.0;
double diskTotGB = 0.0;
double diskUseGB = 0.0;
double diskFree = 0.0;
List<FlSpot> cpuData = [];
List<FlSpot> memData = [];
List<FlSpot> diskData = [];
int time = 0;
String usage = "Low";
String url = "";
