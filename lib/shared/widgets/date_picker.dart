import 'package:app_prestamos/styles/colors.dart';
import 'package:flutter/material.dart';

Future<DateTime?> pickDate(BuildContext context,
    {required DateTime firstDate, required DateTime secondDate}) async {
  final date = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: secondDate,
      builder: (context, child) {
        return Theme(
            data: ThemeData.light().copyWith(
                primaryColor: primaryColor,
                colorScheme: const ColorScheme.light(primary: primaryColor),
                buttonTheme:
                    const ButtonThemeData(textTheme: ButtonTextTheme.primary)),
            child: child!);
      });
  return date;
}
