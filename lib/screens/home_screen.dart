import 'package:app_prestamos/screens/clients/clientes_screen.dart';
import 'package:app_prestamos/screens/loan_dashboard/loan_dashboard_screen.dart';
import 'package:app_prestamos/screens/perfil_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        indicatorColor: Colors.blueAccent,
        selectedIndex: _currentIndex,
        destinations: <Widget>[
          navBarItem('images/loan-2.png', 'images/loan.png', 'Prestamos'),
          navBarItem('images/cliente-2.png', 'images/cliente.png', 'Clientes'),
          navBarItem('images/person.png', 'images/person-2.png', 'Perfil'),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: const <Widget>[
          LoanDashboardScreen(),
          ClientesScreen(),
          PerfilScreen()
        ],
      ),
    );
  }

  Widget navBarItem(String image, String activeimage, String label) {
    return NavigationDestination(
      icon: Image.asset(
        image,
        height: 30,
      ),
      label: label,
      selectedIcon: Image.asset(
        activeimage,
        height: 65,
      ),
    );
  }
}
