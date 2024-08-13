import 'package:controle_patrimonial/list_hardware.dart';
import 'package:controle_patrimonial/list_usuario.dart';
import 'package:controle_patrimonial/login.dart';
import 'package:controle_patrimonial/main_home.dart';
import 'package:controle_patrimonial/update_usuario.dart';
import 'package:flutter/material.dart';
import 'package:controle_patrimonial/create_usuario.dart';
import 'package:controle_patrimonial/GlobalDioConfig.dart';

void main() {
  GlobalDioConfig.configureDio();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle Patrimonial',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 0, 0)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Controle Patrimonial'),
      routes: {
        '/login': (context) => LoginScreen(),
        '/list_usuario': (context) => ListarUsuarioScreen(),
        '/list_hardware': (context) => ListarHardwareScreen(),
        '/create_usuario': (context) => CreateUsuarioScreen(),
        '/update_usuario': (context) => UpdateUsuarioScreen(),
        '/main_home': (context) => MainHomeScreen()
      },
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
              mainAxisAlignment: MainAxisAlignment
                  .spaceEvenly, 
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
