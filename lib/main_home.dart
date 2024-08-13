import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:controle_patrimonial/GlobalDioConfig.dart'; // Certifique-se de que este arquivo existe e está correto

class MainHomeScreen extends StatefulWidget {
  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  late Dio _dio;
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
        // Navegue para a primeira tela
        break;
      case 1:
        // Navegue para a segunda tela
        break;
      case 2:
        break;
      case 3:
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _dio = GlobalDioConfig.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barra de Botões com Ícones'),
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
          // Adicione mais itens aqui conforme necessário
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user),
            label: 'Usuário',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.computer),
            label: 'Hardware',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.paperclip),
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
