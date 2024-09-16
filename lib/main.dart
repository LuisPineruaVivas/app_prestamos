import 'package:app_prestamos/config/router.dart';
import 'package:app_prestamos/firebase_options.dart';
import 'package:app_prestamos/provider/authentication/auth_provider.dart';
import 'package:app_prestamos/provider/client/client_provider.dart';
import 'package:app_prestamos/styles/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => AuthenticationProviderImpl()),
        ChangeNotifierProvider(create: (context) => ClientProviderImpl())
      ],
      child: MaterialApp.router(
        routerConfig: router,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
                centerTitle: true,
                scrolledUnderElevation: 0,
                backgroundColor: Colors.transparent),
            scaffoldBackgroundColor: whiteColor,
            primaryColor: primaryColor),
      ),
    );
  }
}
