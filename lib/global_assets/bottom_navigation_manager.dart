import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavigationManager extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index, BuildContext context) {
    _selectedIndex = index;
    notifyListeners();
    navigateToPage(context);
  }

  void navigateToPage(BuildContext context) {
    switch (_selectedIndex) {
      case 0:
        Navigator.pushNamed(context, 'main_home');
        break;
      case 1:
        Navigator.pushNamed(context, '/list_usuario');
        break;
      case 2:
        Navigator.pushNamed(context, '/list_hardware');
        break;
      case 3:
        // Navega para a tela de Nota Fiscal
        // Certifique-se de ter a rota configurada corretamente no MaterialApp
        break;
      default:
        break;
    }
  }

  Widget buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user), label: 'Usuario'),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.computer), label: 'Hardware'),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: (index) {
        setSelectedIndex(index, context);
      },
    );
  }
}
