import 'package:flutter/material.dart';
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
        Navigator.pushNamed(context, '/settings_screen');
        break;
      case 2:
        Navigator.pushNamed(context, '/list_hardware');
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
            icon: Icon(FontAwesomeIcons.gear), label: 'Configuração'),
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
