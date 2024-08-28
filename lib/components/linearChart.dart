import 'package:flutter/material.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';
import 'package:status_usage/colors.dart';

Widget linearChart(double val) {
  return LinearGauge(
    enableGaugeAnimation: true,
    linearGaugeBoxDecoration:
        LinearGaugeBoxDecoration(thickness: 20, backgroundColor: colorBack),
    valueBar: [
      ValueBar(
        color: Colors.lightBlueAccent,
        value: val,
        valueBarThickness: 20,
      )
    ],
    rulers: RulerStyle(
        showLabel: false,
        rulerPosition: RulerPosition.top,
        primaryRulersHeight: 0,
        secondaryRulersHeight: 0,
        showPrimaryRulers: false,
        showSecondaryRulers: false),
  );
}
