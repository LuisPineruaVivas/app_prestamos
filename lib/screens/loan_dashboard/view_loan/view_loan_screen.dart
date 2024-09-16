import 'package:app_prestamos/config/extension.dart';
import 'package:app_prestamos/screens/loan_dashboard/local_widgets/loan_view_details_card.dart';
import 'package:app_prestamos/shared/widgets/cuota_card.dart';
import 'package:app_prestamos/shared/widgets/custom_button.dart';
import 'package:app_prestamos/shared/widgets/pago_card.dart';
import 'package:app_prestamos/styles/colors.dart';
import 'package:app_prestamos/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ViewLoanScreen extends StatefulWidget {
  const ViewLoanScreen({super.key});

  @override
  State<ViewLoanScreen> createState() => _ViewLoanScreenState();
}

class _ViewLoanScreenState extends State<ViewLoanScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalles Prestamo',
          style: AppTheme.headerStyle(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LoanViewDetailsCard(
                  titleText: "Prestamo de emergencia",
                  headerText: 'Nombre del Prestamo'),
              const LoanViewDetailsCard(
                  titleText: "\$500", headerText: 'Monto'),
              Column(
                children: [
                  Text(
                    'Documento Prestamo',
                    style: AppTheme.headerStyle(),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Ver Documento',
                        style: AppTheme.titleStyle(
                            color: primaryColor, fontsize: 16),
                      ))
                ],
              ),
              const Row(
                children: [
                  LoanViewDetailsCard(
                      titleText: "14/07/2024", headerText: 'Fecha de Prestamo'),
                  Spacer(),
                  LoanViewDetailsCard(titleText: "8", headerText: 'Cuotas')
                ],
              ),
              const Row(
                children: [
                  LoanViewDetailsCard(
                      titleText: "Semanal", headerText: 'Frecuencia de Pagos'),
                  Spacer(),
                  LoanViewDetailsCard(titleText: "5%", headerText: 'Interes')
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: TabBar(
                    labelStyle: const TextStyle(fontSize: 18.0),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    controller: tabController,
                    indicator: const BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    tabs: const [Tab(text: 'Cuotas'), Tab(text: 'Pagos')]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: double.maxFinite,
                  height: 250,
                  child: TabBarView(controller: tabController, children: [
                    SingleChildScrollView(
                      child: Column(
                          children: List.generate(5, (index) {
                        return const CuotaCard('100', '5/8/2024', true);
                      })),
                    ),
                    SingleChildScrollView(
                      child: Column(
                          children: List.generate(5, (index) {
                        return const PagoCard('100', '5/8/2024');
                      })),
                    ),
                  ]),
                ),
              ),
              10.height(),
              Row(
                children: [
                  Expanded(
                      child: CustomButton(
                    onPressed: () {},
                    text: 'Borrar',
                  )),
                  10.width(),
                  Expanded(
                      child: CustomButton(
                    onPressed: () {
                      context.push('/add_pay');
                    },
                    text: 'Nuevo Pago',
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
