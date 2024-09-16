import 'package:app_prestamos/config/extension.dart';
import 'package:app_prestamos/styles/theme.dart';
import 'package:flutter/material.dart';

class LoanViewDetailsCard extends StatelessWidget {
  final String headerText;
  final String titleText;
  const LoanViewDetailsCard(
      {super.key, required this.headerText, required this.titleText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(headerText, style: AppTheme.headerStyle()),
        Text(
          titleText,
          style: AppTheme.titleStyle(fontsize: 18),
        ),
        15.height()
      ],
    );
  }
}
