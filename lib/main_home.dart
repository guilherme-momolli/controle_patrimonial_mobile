import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:controle_patrimonial/GlobalDioConfig.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key); // Added key parameter

  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _screens = <Widget>[
    Text('Seja bem vindo'),
    Text('Outra Tela'),
    Text('Hardware'),
    Text('Nota Fiscal')
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (_selectedIndex) {
      case 0:
        break;
      case 1:
        Navigator.pushNamed(context, '/list_usuario');
        break;
      case 2:
        Navigator.pushNamed(context, '/list_hardware');
        break;
      case 3:
        // Navega para a tela de Nota Fiscal
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barra de Botões com Ícones'), // Made const
      ),
      body: Center(
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house),
            label: 'Principal',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user),
            label: 'Usuário',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.computer),
            label: 'Hardware',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.pager),
            label: 'Nota Fiscal',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
