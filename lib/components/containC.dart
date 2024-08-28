import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:status_usage/components/chart.dart';
import 'package:status_usage/colors.dart';

Widget containC(double w, double h, String head, String text1, String text2,
    List<FlSpot> data) {
  final fontHead = w * 0.05;
  final fontText = w * 0.04;
  return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: colorContain,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          head,
          style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: fontHead,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 15,
        ),
        chart(h, data, head),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            (head == "CPU Usage")
                ? Text(
                    "Percentage: " + text1 + "%",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: fontText,
                        fontWeight: FontWeight.w400),
                  )
                : Text(
                    "Used: " + text1,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: fontText,
                        fontWeight: FontWeight.w400),
                  ),
            (head == "CPU Usage")
                ? Text(
                    "Usage: " + text2,
                    style: GoogleFonts.poppins(
                        color: (text2 == "Low")
                            ? Colors.greenAccent
                            : (text2 == "Medium")
                                ? Colors.orangeAccent
                                : Colors.redAccent,
                        fontSize: fontText,
                        fontWeight: FontWeight.w400),
                  )
                : (head == "Memory Usage")
                    ? Text(
                        "Free: " + text2 + "MB",
                        style: GoogleFonts.poppins(
                            color: (double.parse(text2) >= 2048)
                                ? Colors.greenAccent
                                : (double.parse(text2) < 2048 &&
                                        double.parse(text2) >= 500)
                                    ? Colors.orangeAccent
                                    : Colors.redAccent,
                            fontSize: fontText,
                            fontWeight: FontWeight.w400),
                      )
                    : Text(
                        "Free: " + text2 + "GB",
                        style: GoogleFonts.poppins(
                            color: (double.parse(text2) >= 5)
                                ? Colors.greenAccent
                                : (double.parse(text2) < 3 &&
                                        double.parse(text2) >= 0.5)
                                    ? Colors.orangeAccent
                                    : Colors.redAccent,
                            fontSize: fontText,
                            fontWeight: FontWeight.w400),
                      )
          ],
        )
      ]));
}
