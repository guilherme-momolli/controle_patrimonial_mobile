import 'package:controle_patrimonial/list_hardware.dart';
import 'package:controle_patrimonial/list_usuario.dart';
import 'package:controle_patrimonial/update_usuario.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Controle Patrimonial'),
      routes: {
        '/list_usuario': (context) => ListarUsuarioScreen(),
        '/list_hardware': (context) => ListarHardwareScreen(),
        '/create_usuario': (context) => CreateUsuarioScreen(),
        '/update_usuario': (context) => UpdateUsuarioScreen()
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  late Dio _dio;

  @override
  void initState() {
    super.initState();
    _dio = GlobalDioConfig.instance;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    _dio.close();
    super.dispose();
  }

  Future<bool> _login() async {
    String email = _emailController.text;
    String senha = _senhaController.text;
    try {
      var response = await _dio
          .post('/usuario/login', data: {'email': email, 'senha': senha});
      if (response.statusCode == 200) {
        print('Login bem sucedido.');
        return true;
      } else {
        print('Falha no login: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
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
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Digite seu email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _senhaController,
              decoration: InputDecoration(
                labelText: 'Senha',
                hintText: 'Digite sua senha',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                bool loginSuccess = await _login();
                if (loginSuccess) {
                  Navigator.pushNamed(context, '/list_hardware');
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Falha no login')));
                }
              },
              child: Text('Login'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/create_usuario');
              },
              child: Text('Cadastrar'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/list_usuario');
              },
              child: Text('Listar'),
            ),
          ],
        ),
      ),
    );
  }
}
