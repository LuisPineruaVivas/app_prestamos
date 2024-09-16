import 'package:app_prestamos/config/extension.dart';
import 'package:app_prestamos/enums/enums.dart';
import 'package:app_prestamos/provider/client/client_provider.dart';
import 'package:app_prestamos/shared/utils/app_logger.dart';
import 'package:app_prestamos/shared/widgets/busy_overlay.dart';
import 'package:app_prestamos/shared/widgets/custom_button.dart';
import 'package:app_prestamos/shared/widgets/prestamo_card.dart';
import 'package:app_prestamos/styles/colors.dart';
import 'package:app_prestamos/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class InfoClientScreen extends StatefulWidget {
  final String clientId;
  const InfoClientScreen({super.key, required this.clientId});

  @override
  State<InfoClientScreen> createState() => _InfoClientScreenState();
}

class _InfoClientScreenState extends State<InfoClientScreen> {
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
      return BusyOverlay(
        show: stateModel.viewState == ViewState.busy,
        title: stateModel.message,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Detalles Cliente',
              style: AppTheme.headerStyle(),
            ),
          ),
          body: stateModel.singleClient == null
              ? const SizedBox()
              : Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/fondo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(40.0),
                                    bottomRight: Radius.circular(40.0))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      stateModel.singleClient!.nombreCliente
                                          .ellipsis2(),
                                      style: AppTheme.headerStyle(),
                                    ),
                                    const Spacer(),
                                    Image.asset('images/user.png',
                                        width: 60, height: 60)
                                  ],
                                ),
                                10.height(),
                                Row(
                                  children: [
                                    Text(
                                        "ID:${stateModel.singleClient!.cedulaCliente}",
                                        style: AppTheme.headerStyle()),
                                    const Spacer(),
                                    Text(
                                        'Tlfn: ${stateModel.singleClient!.tlfnCliente}',
                                        style: AppTheme.headerStyle())
                                  ],
                                ),
                                10.height(),
                                Row(
                                  children: [
                                    Expanded(
                                        child: CustomButton(
                                            onPressed: () {
                                              context.push(
                                                  '/edit_client?Client_id=${widget.clientId}');
                                            },
                                            text: 'Ver Info')),
                                    10.width(),
                                    Expanded(
                                        child: CustomButton(
                                            onPressed: () {}, text: 'Eliminar'))
                                  ],
                                )
                              ],
                            ),
                          )),
                      Expanded(
                          flex: 6,
                          child: SingleChildScrollView(
                            child: Column(
                                children: List.generate(5, (index) {
                              return PrestamoCard(onTap: () {
                                context.push('/view_loan');
                              });
                            })),
                          ))
                    ],
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            heroTag: 'btn2',
            backgroundColor: primaryColor,
            onPressed: () {
              context.push('/add_loan');
            },
            child: const Icon(Icons.add),
          ),
        ),
      );
    });
  }
}
