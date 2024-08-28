import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:status_usage/components/gauge.dart';
import 'package:status_usage/colors.dart';

Widget containG(String head, String text, double val, double tot, Color used,
    Color free, double w) {
  final fontText = w * 0.04;
  final fontHead = w * 0.05;
  final iconSize = w * 0.1;
  final strokeWidth = w * 0.03;
  Icon icon = Icon(Symbols.abc);
  if (head == "CPU") {
    icon = Icon(
      Symbols.memory,
      color: colorCPU,
      size: iconSize,
    );
  } else if (head == "Memory") {
    icon = Icon(
      Symbols.storage,
      color: colorMem,
      size: iconSize,
    );
  }
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Text(
            head,
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: fontHead,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 10,
          ),
          RepaintBoundary(
              child: Guage(head, val, tot, used, free, icon, strokeWidth)),
          SizedBox(
            height: 10,
          ),
          Text(
            text,
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: fontText,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: colorContain,
          borderRadius: BorderRadius.all(Radius.circular(20))),
    ),
  );
}
