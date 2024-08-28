import 'package:controle_patrimonial/global_assets/bottom_navigation_manager.dart';
import 'package:controle_patrimonial/global_assets/theme_controller.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;

  final BottomNavigationManager bottomNavManager = BottomNavigationManager();
  final ThemeController themeMode = ThemeController();

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300,
              height: 400,
              margin: const EdgeInsets.all(20), // Added const here
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0), // Added const here
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Icon(Icons.person), // Adicione o ícone desejado aqui
                          const Text(
                            'Usuário',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: toggleTheme,
                        child: Text(_isDarkMode
                            ? 'Mudar para Claro'
                            : 'Mudar para Escuro'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavManager.buildBottomNavigationBar(context),
    );
  }
}
