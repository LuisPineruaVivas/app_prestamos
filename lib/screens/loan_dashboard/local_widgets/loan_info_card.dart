import 'package:app_prestamos/config/extension.dart';
import 'package:app_prestamos/styles/colors.dart';
import 'package:app_prestamos/styles/theme.dart';
import 'package:flutter/material.dart';

class LoanInfoCard extends StatelessWidget {
  final Function() onTap;
  const LoanInfoCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 220,
        width: 180,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: primaryColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.outbond,
                  color: redColor,
                ),
                Expanded(
                    child: Text(
                  '\$ 500',
                  textAlign: TextAlign.right,
                  style: AppTheme.subtitleStyle(
                      isbold: true, color: whiteColor, fontsize: 18),
                ))
              ],
            ),
            10.height(),
            Text(
              'Prestamo a:',
              style: AppTheme.titleStyle(color: whiteColor, fontsize: 18),
            ),
            Center(
              child: Text(
                'Luis Piñerua'.ellipsis(),
                style: AppTheme.titleStyle(
                    isbold: true, color: whiteColor, fontsize: 18),
              ),
            ),
            Text(
              'Fecha:',
              style: AppTheme.titleStyle(color: whiteColor, fontsize: 18),
            ),
            Center(
              child: Text(
                '7/13/2024',
                style: AppTheme.titleStyle(
                    isbold: true, color: whiteColor, fontsize: 18),
              ),
            ),
            Row(
              children: [
                Text(
                  'Cuotas: ',
                  style: AppTheme.titleStyle(color: whiteColor, fontsize: 18),
                ),
                Text(
                  '8',
                  style: AppTheme.titleStyle(
                      isbold: true, color: whiteColor, fontsize: 18),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Interes: ',
                  style: AppTheme.titleStyle(color: whiteColor, fontsize: 18),
                ),
                Text(
                  '10%',
                  style: AppTheme.titleStyle(
                      isbold: true, color: whiteColor, fontsize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
