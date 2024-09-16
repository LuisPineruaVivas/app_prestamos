import 'package:app_prestamos/screens/clients/add_client_screen.dart';
import 'package:app_prestamos/screens/add_payment/add_payment_screen.dart';
import 'package:app_prestamos/screens/authentication/login.dart';
import 'package:app_prestamos/screens/authentication/register.dart';
import 'package:app_prestamos/screens/clients/editar_clientes_screen.dart';
import 'package:app_prestamos/screens/clients/info_client_screen.dart';
import 'package:app_prestamos/screens/home_screen.dart';
import 'package:app_prestamos/screens/loan_dashboard/add_loan/add_loan_screen.dart';
import 'package:app_prestamos/screens/loan_dashboard/loan_dashboard_screen.dart';
import 'package:app_prestamos/screens/loan_dashboard/view_loan/view_loan_screen.dart';
import 'package:app_prestamos/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    path: '/home_screen',
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: '/register_screen',
    builder: (context, state) => const RegisterScreen(),
  ),
  GoRoute(
    path: '/login_screen',
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: '/loan_dashboard_screen',
    builder: (context, state) => const LoanDashboardScreen(),
  ),
  GoRoute(
    path: '/add_loan',
    builder: (context, state) => const AddLoanScreen(),
  ),
  GoRoute(
    path: '/add_client',
    builder: (context, state) => const AddClientScreen(),
  ),
  GoRoute(
    path: '/view_loan',
    builder: (context, state) => const ViewLoanScreen(),
  ),
  GoRoute(
      path: '/info_client',
      builder: (context, state) {
        final clientId = state.uri.queryParameters['Client_id'];
        return InfoClientScreen(
          clientId: clientId!,
        );
      }),
  GoRoute(
    path: '/add_pay',
    builder: (context, state) => const AddPayScreen(),
  ),
  GoRoute(
      path: '/edit_client',
      builder: (context, state) {
        final clientId = state.uri.queryParameters['Client_id'];
        return EditClientScreen(
          clientId: clientId!,
        );
      }),
]);
