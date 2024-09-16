import 'package:app_prestamos/config/extension.dart';
import 'package:app_prestamos/shared/utils/app_logger.dart';
import 'package:app_prestamos/shared/utils/pick_file.dart';
import 'package:app_prestamos/shared/widgets/custom_button.dart';
import 'package:app_prestamos/shared/widgets/date_picker.dart';
import 'package:app_prestamos/shared/widgets/dropdown_menu.dart';
import 'package:app_prestamos/styles/colors.dart';
import 'package:app_prestamos/styles/theme.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text_form_field/flutter_text_form_field.dart';

class AddLoanScreen extends StatefulWidget {
  const AddLoanScreen({super.key});

  @override
  State<AddLoanScreen> createState() => _AddLoanScreenState();
}

class _AddLoanScreenState extends State<AddLoanScreen> {
  Currency? currency;
  final currentDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agregar Prestamo',
          style: AppTheme.headerStyle(),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nombre Prestamo',
                  style: AppTheme.headerStyle(),
                ),
                CustomTextField(
                  TextEditingController(),
                  hint: 'Nombre prestamo',
                  password: false,
                  border: Border.all(color: greyColor),
                ),
                15.height(),
                Row(
                  children: [
                    Text(
                      'Monto Prestamo',
                      style: AppTheme.headerStyle(),
                    ),
                    const Spacer(),
                    Text(
                      'Tipo de Moneda',
                      style: AppTheme.headerStyle(),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        TextEditingController(),
                        hint: 'Monto',
                        keyboardType: TextInputType.number,
                        password: false,
                        border: Border.all(color: greyColor),
                      ),
                    ),
                    30.width(),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        showCurrencyPicker(
                          context: context,
                          onSelect: (Currency value) {
                            currency = value;
                            setState(() {});
                          },
                          showCurrencyCode: true,
                          showCurrencyName: true,
                          currencyFilter: <String>['USD', 'EUR', 'VEF'],
                        );
                      },
                      child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: greyColor),
                              color: whiteColor),
                          child: Text(currency == null
                              ? 'Moneda'
                              : '${currency!.code} - ${currency!.symbol}')),
                    ))
                  ],
                ),
                15.height(),
                Row(
                  children: [
                    Text(
                      'Fecha Prestamo',
                      style: AppTheme.headerStyle(),
                    ),
                    const Spacer(),
                    Text(
                      'Interes %        ',
                      style: AppTheme.headerStyle(),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        TextEditingController(),
                        hint: 'Fecha Prestamo',
                        keyboardType: TextInputType.number,
                        password: false,
                        readOnly: true,
                        onTap: () async {
                          final date = await pickDate(context,
                              firstDate: DateTime(currentDate.year - 1),
                              secondDate: currentDate);
                          if (date != null) {
                            appLogger(date);
                          }
                        },
                        border: Border.all(color: greyColor),
                      ),
                    ),
                    30.width(),
                    Expanded(
                      child: CustomTextField(
                        TextEditingController(),
                        hint: 'Interes',
                        keyboardType: TextInputType.number,
                        password: false,
                        border: Border.all(color: greyColor),
                      ),
                    ),
                  ],
                ),
                15.height(),
                Row(
                  children: [
                    Text(
                      'Cuotas',
                      style: AppTheme.headerStyle(),
                    ),
                    150.width(),
                    Text(
                      'Pago',
                      style: AppTheme.headerStyle(),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        TextEditingController(),
                        hint: 'Nro de cuotas',
                        keyboardType: TextInputType.number,
                        password: false,
                        border: Border.all(color: greyColor),
                      ),
                    ),
                    30.width(),
                    const Expanded(child: DropdownMenuPays()),
                  ],
                ),
                15.height(),
                Text(
                  'Documento prestamo (opcional)',
                  style: AppTheme.headerStyle(),
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          pickDocument().then((value) {
                            if (value != null) {
                              //subir documento al servidore
                            }
                          });
                        },
                        child: Text(
                          'Subir documento (pdf,image)',
                          style: AppTheme.titleStyle(
                              color: primaryColor, fontsize: 16),
                        )),
                    const Spacer(),
                    const Icon(
                      Icons.check_circle,
                      color: greenColor,
                    )
                  ],
                ),
                10.height(),
                Text(
                  'Notas (opcional)',
                  style: AppTheme.headerStyle(),
                ),
                //subtitleWidget('Notas del prestamo'),
                15.height(),
                CustomButton(
                  onPressed: () {},
                  text: 'Agregar Prestamo',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
