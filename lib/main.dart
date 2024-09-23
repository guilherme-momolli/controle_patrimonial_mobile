import 'package:controle_patrimonial/global_assets/bottom_navigation_manager.dart';
import 'package:controle_patrimonial/view/create_hardware.dart';
import 'package:controle_patrimonial/view/create_usuario.dart';
import 'package:controle_patrimonial/view/list_hardware.dart';
import 'package:controle_patrimonial/view/list_usuario.dart';
import 'package:controle_patrimonial/view/login.dart';
import 'package:controle_patrimonial/view/main_home.dart';
import 'package:controle_patrimonial/view/settings_screen.dart';
import 'package:controle_patrimonial/view/update_usuario.dart';
import 'package:flutter/material.dart';
import 'package:controle_patrimonial/global_assets/global_dio_config.dart';
import 'package:provider/provider.dart';
import 'package:controle_patrimonial/global_assets/theme_controller.dart';

void main() {
  GlobalDioConfig.configureDio();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeController()),
        ChangeNotifierProvider(create: (_) => BottomNavigationManager()),
      ],
      child: Consumer2<ThemeController, BottomNavigationManager>(
        builder: (context, themeController, bottomNavManager, child) {
          return MaterialApp(
            title: 'Controle Patrimonial',
            theme: themeController.themeData,
            initialRoute: '/',
            routes: {
              '/': (context) => MyHomePage(title: 'Controle Patrimonial'),
              '/login': (context) => LoginScreen(),
              '/list_hardware': (context) => ListHardwareScreen(),
              '/list_usuario': (context) => ListarUsuarioScreen(),
              '/create_hardware': (context) => CreateHardwareScreen(),
              '/create_usuario': (context) => CreateUsuarioScreen(),
              '/main_home': (context) => MainHomeScreen(),
              '/update_usuario': (context) => UpdateUsuarioScreen(),
              '/settings_screen': (context) => SettingsScreen()
            },
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text('Login'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/create_usuario');
                    },
                    child: Text('Cadastrar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
