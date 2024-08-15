import 'package:controle_patrimonial/global_assets/bottom_navigation_manager.dart';
import 'package:flutter/material.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final BottomNavigationManager bottomNavManager = BottomNavigationManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barra de Botões com Ícones'),
      ),
      body: Center(),
      bottomNavigationBar: bottomNavManager.buildBottomNavigationBar(context),
    );
  }
}
