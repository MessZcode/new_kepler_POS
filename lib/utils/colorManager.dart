import 'package:flutter/material.dart';

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll("#", "");
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString";
    }
    return Color(
      int.parse(
        hexColorString,
        radix: 16,
      ),
    );
  }
}

class ColorManager {
  static Color primary600 = HexColor.fromHex("#0f8c68");
  static Color primary500 = HexColor.fromHex("#1caf82");
  static Color primary100 = HexColor.fromHex("#D4F7E6");
  static Color primary50 = HexColor.fromHex("#edfcf5");

  static Color secondary500 = HexColor.fromHex("#fd6412");
  static Color secondary100 = HexColor.fromHex("#FFEBD4");
  static Color secondary50 = HexColor.fromHex("#FFF6ED");

  static Color danger500 = HexColor.fromHex("#EC474F");
  static Color danger200 = HexColor.fromHex("#fccfcf");

  static Color dark900 = HexColor.fromHex("#373d42");
  static Color dark800 = HexColor.fromHex("#3e454c");
  static Color dark500 = HexColor.fromHex("#5F717B");
  static Color dark400 = HexColor.fromHex("#7A8C96");
  static Color dark300 = HexColor.fromHex("#A6B4BA");
  static Color dark200 = HexColor.fromHex("#CBD3D6");
  static Color dark100 = HexColor.fromHex("#E3E7EA");
  static Color dark50 = HexColor.fromHex("#F4F6F7");

  static Color light800 = HexColor.fromHex("#575776");
  static Color light300 = HexColor.fromHex("#BCC1D4");
  static Color light100 = HexColor.fromHex("#E9EAF0");
  static Color light50 = HexColor.fromHex("#F1F2F6");

  static Color base_light = HexColor.fromHex("#FEFEFE");
  static Color base_dark = HexColor.fromHex("#252525");

  static Color blue500 = HexColor.fromHex("#2c91cb");
  static Color blue300 = HexColor.fromHex("#8EC8EB");
  static Color blue200 = HexColor.fromHex("#c3e0f4");
  static Color warning300 = HexColor.fromHex("#ffee46");
}
