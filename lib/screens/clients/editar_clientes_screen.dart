import 'package:app_prestamos/config/extension.dart';
import 'package:app_prestamos/enums/enums.dart';
import 'package:app_prestamos/provider/client/client_provider.dart';
import 'package:app_prestamos/service/upload_doc_service.dart';
import 'package:app_prestamos/shared/utils/app_logger.dart';
import 'package:app_prestamos/shared/utils/message.dart';
import 'package:app_prestamos/shared/utils/pick_file.dart';
import 'package:app_prestamos/shared/utils/url_launcher_helper.dart';
import 'package:app_prestamos/shared/widgets/busy_overlay.dart';
import 'package:app_prestamos/shared/widgets/custom_button.dart';
import 'package:app_prestamos/shared/widgets/custom_notes.dart';
import 'package:app_prestamos/styles/colors.dart';
import 'package:app_prestamos/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text_form_field/flutter_text_form_field.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EditClientScreen extends StatefulWidget {
  final String clientId;
  const EditClientScreen({super.key, required this.clientId});

  @override
  State<EditClientScreen> createState() => _EditClientScreenState();
}

class _EditClientScreenState extends State<EditClientScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ClientProviderImpl>(context, listen: false)
        .viewClientById(widget.clientId);
  }

  @override
  Widget build(BuildContext context) {
    appLogger(widget.clientId);
    return Consumer<ClientProviderImpl>(builder: (context, stateModel, _) {
      stateModel.clientNameController.text =
          stateModel.singleClient!.nombreCliente;
      stateModel.clientCedulaController.text =
          stateModel.singleClient!.cedulaCliente;
      stateModel.clientNumberController.text =
          stateModel.singleClient!.tlfnCliente;
      stateModel.clientEmailController.text =
          stateModel.singleClient!.emailCliente;
      stateModel.clientNoteController.text =
          stateModel.singleClient!.notasCliente;
      return BusyOverlay(
        show: stateModel.viewState == ViewState.busy,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Datos Cliente',
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
                      password: false,
                      keyboardType: TextInputType.phone,
                      border: Border.all(color: greyColor),
                      maxLength: 16,
                    ),
                    15.height(),
                    Text(
                      'Correo',
                      style: AppTheme.headerStyle(),
                    ),
                    CustomTextField(
                      stateModel.clientEmailController,
                      password: false,
                      keyboardType: TextInputType.emailAddress,
                      border: Border.all(color: greyColor),
                      maxLength: 35,
                    ),
                    15.height(),
                    Text(
                      'Notas',
                      style: AppTheme.headerStyle(),
                    ),
                    subtitleWidget('', stateModel.clientNoteController),
                    15.height(),
                    Text(
                      'Documento Cliente',
                      style: AppTheme.headerStyle(),
                    ),
                    (stateModel.singleClient!.documentoCliente != null)
                        ? Row(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    launchSite(stateModel
                                        .singleClient!.documentoCliente);
                                  },
                                  child: Text(
                                    'Ver documento (pdf,image)',
                                    style: AppTheme.titleStyle(
                                        color: primaryColor, fontsize: 16),
                                  )),
                              const Spacer(),
                              const Icon(
                                Icons.check_circle,
                                color: greenColor,
                              )
                            ],
                          )
                        : Row(
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
                                            await uploadedDocumenToServer(
                                                value);
                                        if (result.state == ViewState.error) {
                                          if (context.mounted) {
                                            showMessage(
                                                context, result.filterUrl);
                                          }
                                          stateModel.viewState =
                                              ViewState.error;
                                          return;
                                        }
                                        if (result.state == ViewState.succes) {
                                          stateModel.uploadedDocument =
                                              result.filterUrl;
                                          if (context.mounted) {
                                            showMessage(context,
                                                "Documento subido correctamente");
                                          }
                                          stateModel.viewState =
                                              ViewState.succes;
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
                            ],
                          ),
                    15.height(),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            onPressed: () async {
                              if (stateModel
                                      .clientNameController.text.isEmpty ||
                                  stateModel
                                      .clientCedulaController.text.isEmpty ||
                                  stateModel
                                      .clientNumberController.text.isEmpty) {
                                showMessage(context,
                                    "Llene todos los campos obligatorios",
                                    isError: true);
                                return;
                              }
                              await stateModel.updateClient(
                                  widget.clientId,
                                  stateModel.clientNameController.text.trim(),
                                  stateModel.clientCedulaController.text.trim(),
                                  stateModel.clientNumberController.text.trim(),
                                  stateModel.clientEmailController.text.trim(),
                                  stateModel.clientNoteController.text.trim());

                              if (stateModel.viewState == ViewState.error) {
                                if (context.mounted) {
                                  showMessage(context, stateModel.message,
                                      isError: true);
                                }
                                return;
                              }
                              if (stateModel.viewState == ViewState.succes) {
                                if (context.mounted) {
                                  stateModel.viewClient();
                                  showMessage(context, stateModel.message);
                                  context.go('/home_screen');
                                }
                              }
                            },
                            text: 'Guardar',
                          ),
                        ),
                        10.width(),
                        Expanded(
                            child: CustomButton(
                                onPressed: () async {
                                  await stateModel
                                      .deleteClient(widget.clientId);

                                  if (stateModel.viewState == ViewState.error) {
                                    if (context.mounted) {
                                      showMessage(context, stateModel.message,
                                          isError: true);
                                    }
                                    return;
                                  }
                                  if (stateModel.viewState ==
                                      ViewState.succes) {
                                    if (context.mounted) {
                                      stateModel.viewClient();
                                      showMessage(context, stateModel.message);
                                      context.go('/home_screen');
                                    }
                                  }
                                },
                                text: 'Eliminar'))
                      ],
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
