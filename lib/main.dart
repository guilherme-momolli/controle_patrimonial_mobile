import 'package:controle_patrimonial/list_usuario.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:controle_patrimonial/create_usuario.dart';

void main() {
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
        '/create_usuario': (context) => CreateUsuarioScreen(),
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
    _dio = Dio();
    //dio.options.method = "POST";
    _dio.options.headers["Access-Control-Allow-Origin"] = "*";
    _dio.options.headers["Access-Control-Allow-Credentials"] = true;
    _dio.options.headers["Access-Control-Allow-Headers"] =
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale";
    _dio.options.headers["Access-Control-Allow-Methods"] =
        "GET, HEAD, POST, OPTIONS";
  }

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    _dio.close();
    super.dispose();
  }

  Future<void> _login() async {
    String email = _emailController.text;
    String senha = _senhaController.text;
    try {
      var response = await _dio.post('http://192.168.0.121:8080/usuario/login',
          data: {'email': email, 'senha': senha});
      if (response.statusCode == 200) {
        print('Login bem sucedido.');
      } else {
        print('Falha no login: ${response.statusCode}');
      }
      print(response.data);
    } catch (e) {
      print(e);
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
              onPressed: _login,
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
