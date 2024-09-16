import 'package:app_prestamos/styles/colors.dart';
import 'package:app_prestamos/styles/theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final double? width;
  const CustomButton(
      {super.key, required this.onPressed, this.text = 'continue', this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
        child: Text(
          text,
          style: AppTheme.titleStyle(
              color: whiteColor, isbold: true, fontsize: 25),
        ),
      ),
    );
  }
}
