import 'package:app_prestamos/config/extension.dart';
import 'package:app_prestamos/shared/utils/app_logger.dart';
import 'package:app_prestamos/shared/widgets/custom_button.dart';
//import 'package:app_prestamos/shared/widgets/custom_notes.dart';
import 'package:app_prestamos/shared/widgets/date_picker.dart';
import 'package:app_prestamos/shared/widgets/dropdow_metodos.dart';
import 'package:app_prestamos/styles/colors.dart';
import 'package:app_prestamos/styles/theme.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text_form_field/flutter_text_form_field.dart';

class AddPayScreen extends StatefulWidget {
  const AddPayScreen({super.key});

  @override
  State<AddPayScreen> createState() => _AddPayScreenState();
}

class _AddPayScreenState extends State<AddPayScreen> {
  Currency? currency;
  final currentDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nuevo Pago',
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
                Row(
                  children: [
                    Text(
                      'Monto Pago',
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
                      'Metodo Pago ',
                      style: AppTheme.headerStyle(),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        TextEditingController(),
                        hint: 'Fecha Pago',
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
                    const Expanded(child: DropdownMenuMethods())
                  ],
                ),
                15.height(),
                Text(
                  'Notas (opcional)',
                  style: AppTheme.headerStyle(),
                ),
                //subtitleWidget('Notas del pago'),
                15.height(),
                CustomButton(
                  onPressed: () {},
                  text: 'Agregar Pago',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
