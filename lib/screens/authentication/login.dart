import 'package:app_prestamos/config/extension.dart';
import 'package:app_prestamos/enums/enums.dart';
import 'package:app_prestamos/provider/authentication/auth_provider.dart';
import 'package:app_prestamos/shared/utils/message.dart';
import 'package:app_prestamos/shared/widgets/busy_overlay.dart';
import 'package:app_prestamos/shared/widgets/custom_button.dart';
import 'package:app_prestamos/shared/widgets/scaffold_home.dart';
import 'package:app_prestamos/styles/colors.dart';
import 'package:app_prestamos/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text_form_field/flutter_text_form_field.dart';
import 'package:flutter_utilities/flutter_utilities.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProviderImpl>(
        builder: (context, stateModel, _) {
      return BusyOverlay(
        show: stateModel.state == ViewState.busy,
        title: stateModel.message,
        child: ScaffoldHome(
          image: 'images/registro.png',
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: 10.height(),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 20.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Iniciar Sesion',
                          style: AppTheme.titulosStyle(color: primaryColor),
                        ),
                        15.height(),
                        CustomTextField(
                          stateModel.emailController,
                          hint: 'Correo',
                          password: false,
                          border: Border.all(color: primaryColor),
                        ),
                        15.height(),
                        CustomTextField(
                          stateModel.passwordController,
                          hint: 'Contraseña',
                          border: Border.all(color: primaryColor),
                        ),
                        25.height(),
                        CustomButton(
                          onPressed: () async {
                            if (stateModel.passwordController.text.isEmpty) {
                              showMessage(context, 'Llene todos los campos',
                                  isError: true);
                            }
                            if (!FlutterUtilities().isEmailValid(
                                stateModel.emailController.text.trim())) {
                              showMessage(context, 'Correo Invalido',
                                  isError: true);
                              return;
                            }
                            await stateModel.loginUser();
                            if (stateModel.state == ViewState.error &&
                                context.mounted) {
                              showMessage(context, stateModel.message);
                              return;
                            }
                            if (stateModel.state == ViewState.succes &&
                                context.mounted) {
                              showMessage(context, stateModel.message);
                              context.go('/home_screen');
                            }
                          },
                          text: 'Iniciar Sesion',
                        ),
                        25.height(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'No tienes cuenta? ',
                              style: TextStyle(
                                  color: Colors.black45, fontSize: 15),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.go('/register_screen');
                              },
                              child: Text('Registrate',
                                  style: AppTheme.subtitleStyle(
                                      color: primaryColor, isbold: true)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
