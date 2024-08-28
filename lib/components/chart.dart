import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:status_usage/colors.dart';

Widget chart(double height, List<FlSpot> data, String head) {
  Color main = colorCPU, secondary = colorCPUacc;
  if (head == "CPU Usage") {
    main = colorCPU;
    secondary = colorCPUacc;
  } else if (head == "Memory Usage") {
    main = colorMem;
    secondary = colorMemacc;
  } else {
    main = colorDisk;
    secondary = colorDiskacc;
  }
  return SizedBox(
    height: height * 0.25,
    child: LineChart(
      LineChartData(
        minX: data.isNotEmpty ? data.first.x : 0,
        maxX: data.isNotEmpty ? data.last.x : 0,
        minY: 0,
        maxY: 100,
        lineBarsData: [
          LineChartBarData(
            spots: data,
            isCurved: true,
            barWidth: 2,
            color: main,
            belowBarData: BarAreaData(show: true, color: secondary),
          ),
        ],
        borderData: FlBorderData(
            show: true,
            border: Border.all(
              color: colorLine,
            )),
        titlesData: FlTitlesData(
            topTitles: const AxisTitles(),
            rightTitles: const AxisTitles(),
            bottomTitles: const AxisTitles(),
            leftTitles: AxisTitles(
                sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toStringAsFixed(0),
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 10),
                );
              },
            ))),
        gridData: FlGridData(
          show: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(color: colorLine);
          },
          getDrawingVerticalLine: (value) {
            return FlLine(color: colorLine);
          },
        ),
      ),
    ),
  );
}
