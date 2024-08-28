import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:status_usage/components/linearChart.dart';
import 'package:status_usage/colors.dart';

Widget containL(double w, double val, String text) {
  final fontHead = w * 0.05;
  final fontText = w * 0.04;
  return Container(
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
        color: colorContain,
        borderRadius: BorderRadius.all(Radius.circular(20))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Storage",
          style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: fontHead,
              fontWeight: FontWeight.w600),
        ),
        linearChart(val),
        const SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: fontText,
              fontWeight: FontWeight.w400),
        )
      ],
    ),
  );
}
