import 'package:app_prestamos/config/extension.dart';
import 'package:app_prestamos/enums/enums.dart';
import 'package:app_prestamos/provider/client/client_provider.dart';
import 'package:app_prestamos/service/upload_doc_service.dart';
import 'package:app_prestamos/shared/utils/message.dart';
import 'package:app_prestamos/shared/utils/pick_file.dart';
import 'package:app_prestamos/shared/widgets/busy_overlay.dart';
import 'package:app_prestamos/shared/widgets/custom_button.dart';
import 'package:app_prestamos/shared/widgets/custom_notes.dart';
import 'package:app_prestamos/styles/colors.dart';
import 'package:app_prestamos/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text_form_field/flutter_text_form_field.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AddClientScreen extends StatefulWidget {
  const AddClientScreen({super.key});

  @override
  State<AddClientScreen> createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ClientProviderImpl>(builder: (context, stateModel, _) {
      return BusyOverlay(
        show: stateModel.viewState == ViewState.busy,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Agregar Cliente',
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
                      'Nombre',
                      style: AppTheme.headerStyle(),
                    ),
                    CustomTextField(
                      stateModel.clientNameController,
                      hint: 'Nombre',
                      password: false,
                      border: Border.all(color: greyColor),
                      maxLength: 35,
                    ),
                    15.height(),
                    Text(
                      'Cedula',
                      style: AppTheme.headerStyle(),
                    ),
                    CustomTextField(
                      stateModel.clientCedulaController,
                      hint: 'Cedula',
                      password: false,
                      keyboardType: TextInputType.number,
                      border: Border.all(color: greyColor),
                      maxLength: 9,
                    ),
                    15.height(),
                    Text(
                      'Telefono',
                      style: AppTheme.headerStyle(),
                    ),
                    CustomTextField(
                      stateModel.clientNumberController,
                      hint: 'Nro de Telefono',
                      password: false,
                      keyboardType: TextInputType.phone,
                      border: Border.all(color: greyColor),
                      maxLength: 16,
                    ),
                    15.height(),
                    Text(
                      'Correo (opcional)',
                      style: AppTheme.headerStyle(),
                    ),
                    CustomTextField(
                      stateModel.clientEmailController,
                      hint: 'Correo',
                      password: false,
                      keyboardType: TextInputType.emailAddress,
                      border: Border.all(color: greyColor),
                      maxLength: 35,
                    ),
                    15.height(),
                    Text(
                      'Notas (opcional)',
                      style: AppTheme.headerStyle(),
                    ),
                    subtitleWidget(
                        'Notas del cliente', stateModel.clientNoteController),
                    15.height(),
                    Text(
                      'Documento Cliente (opcional)',
                      style: AppTheme.headerStyle(),
                    ),
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              pickDocument().then((value) async {
                                if (value != null) {
                                  //subir documento al servidor
                                  stateModel.viewState = ViewState.busy;
                                  stateModel.message =
                                      'Subiendo Documento al servidor';
                                  final result =
                                      await uploadedDocumenToServer(value);
                                  if (result.state == ViewState.error) {
                                    if (context.mounted) {
                                      showMessage(context, result.filterUrl);
                                    }
                                    stateModel.viewState = ViewState.error;
                                    return;
                                  }
                                  if (result.state == ViewState.succes) {
                                    stateModel.uploadedDocument =
                                        result.filterUrl;
                                    if (context.mounted) {
                                      showMessage(context,
                                          "Documento subido correctamente");
                                    }
                                    stateModel.viewState = ViewState.succes;
                                    return;
                                  }
                                }
                              });
                            },
                            child: Text(
                              'Subir documento (pdf,image)',
                              style: AppTheme.titleStyle(
                                  color: primaryColor, fontsize: 16),
                            )),
                        const Spacer(),
                        if (stateModel.uploadedDocument != null)
                          const Icon(
                            Icons.check_circle,
                            color: greenColor,
                          )
                      ],
                    ),
                    15.height(),
                    CustomButton(
                      onPressed: () async {
                        if (stateModel.clientNameController.text.isEmpty ||
                            stateModel.clientCedulaController.text.isEmpty ||
                            stateModel.clientNumberController.text.isEmpty) {
                          showMessage(
                              context, "Llene todos los campos obligatorios",
                              isError: true);
                          return;
                        }
                        await stateModel.addClient();

                        if (stateModel.viewState == ViewState.error) {
                          if (context.mounted) {
                            showMessage(context, stateModel.message,
                                isError: true);
                          }
                        }
                        if (stateModel.viewState == ViewState.succes) {
                          if (context.mounted) {
                            stateModel.viewClient();
                            showMessage(context, stateModel.message);
                            context.go('/home_screen');
                          }
                        }
                      },
                      text: 'Agregar Cliente',
                    ),
                    40.height()
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
