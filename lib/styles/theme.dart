import 'package:app_prestamos/styles/font_size.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static TextStyle titleStyle(
          {Color? color, bool? isbold = false, double? fontsize = 12}) =>
      TextStyle(
          fontSize: fontsize,
          color: color,
          fontWeight: isbold! ? FontWeight.bold : FontWeight.normal);

  static TextStyle subtitleStyle(
          {Color? color,
          bool? isbold = false,
          double? fontsize = subTitleSize}) =>
      TextStyle(
          fontSize: fontsize,
          color: color,
          fontWeight: isbold! ? FontWeight.bold : FontWeight.normal);

  static TextStyle headerStyle({Color? color}) => TextStyle(
      fontSize: headerSize, color: color, fontWeight: FontWeight.bold);

  static TextStyle titulosStyle({Color? color}) =>
      TextStyle(fontSize: 40, color: color, fontWeight: FontWeight.w900);
}
