import 'package:app_prestamos/config/extension.dart';
import 'package:app_prestamos/screens/loan_dashboard/local_widgets/loan_info_card.dart';
import 'package:app_prestamos/styles/colors.dart';
import 'package:app_prestamos/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoanDashboardScreen extends StatefulWidget {
  const LoanDashboardScreen({super.key});

  @override
  State<LoanDashboardScreen> createState() => _LoanDashboardScreenState();
}

class _LoanDashboardScreenState extends State<LoanDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Prestamos',
          style: AppTheme.headerStyle(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: primaryColor)),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  'Total prestamos',
                                  style: AppTheme.headerStyle(),
                                )),
                                const Icon(
                                  Icons.outbond,
                                  color: redColor,
                                ),
                              ],
                            ),
                            Text(
                              '\$ 2.500',
                              style: AppTheme.titleStyle(fontsize: 20),
                            ),
                            const Divider(),
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  'Total a recibir',
                                  style: AppTheme.headerStyle(),
                                )),
                                const Icon(
                                  Icons.outbond,
                                  color: greenColor,
                                ),
                              ],
                            ),
                            Text(
                              '\$ 2.500',
                              style: AppTheme.titleStyle(fontsize: 20),
                            ),
                          ],
                        ),
                      ),
                      const VerticalDivider(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Ganancia Total',
                            style: AppTheme.headerStyle(),
                          ),
                          Text(
                            '\$ 2.500',
                            style: AppTheme.titleStyle(fontsize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              15.height(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Prestamos Pendientes',
                    style: AppTheme.headerStyle(),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(10, (index) {
                        return LoanInfoCard(onTap: () {
                          context.push('/view_loan');
                        });
                      }),
                    ),
                  )
                ],
              ),
              15.height(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Prestamos Completados',
                    style: AppTheme.headerStyle(),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(10, (index) {
                        return LoanInfoCard(onTap: () {
                          context.push('/view_loan');
                        });
                      }),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
