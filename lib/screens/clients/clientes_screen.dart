import 'package:app_prestamos/enums/enums.dart';
import 'package:app_prestamos/provider/client/client_provider.dart';
import 'package:app_prestamos/shared/widgets/busy_overlay.dart';
import 'package:app_prestamos/shared/widgets/client_card.dart';
import 'package:app_prestamos/styles/colors.dart';
import 'package:app_prestamos/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ClientesScreen extends StatefulWidget {
  const ClientesScreen({super.key});

  @override
  State<ClientesScreen> createState() => _ClientesScreenState();
}

bool show = true;

class _ClientesScreenState extends State<ClientesScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ClientProviderImpl>(context, listen: false).viewClient();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClientProviderImpl>(builder: (context, stateModel, _) {
      return BusyOverlay(
        show: stateModel.viewState == ViewState.busy,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Clientes',
              style: AppTheme.headerStyle(),
            ),
          ),
          body: (stateModel.clients.isNotEmpty)
              ? SingleChildScrollView(
                  child: Column(
                      children:
                          List.generate(stateModel.clients.length, (index) {
                    final data = stateModel.clients[index];
                    return ClientCard(
                        clientData: data,
                        onTap: () {
                          context
                              .push('/info_client?Client_id=${data.clientId}');
                        });
                  })),
                )
              : Center(
                  child: Text(
                    'No tienes Clientes Registrados',
                    style: AppTheme.headerStyle(),
                  ),
                ),
          floatingActionButton: Visibility(
            visible: show,
            child: FloatingActionButton(
              heroTag: 'btn',
              backgroundColor: primaryColor,
              onPressed: () {
                stateModel.clearFields();
                context.push('/add_client');
              },
              child: const Icon(Icons.add),
            ),
          ),
        ),
      );
    });
  }
}
