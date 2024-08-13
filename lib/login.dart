import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:controle_patrimonial/GlobalDioConfig.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            const SizedBox(height: 16),
            TextField(
              controller: _senhaController,
              decoration: InputDecoration(
                labelText: 'Senha',
                hintText: 'Digite sua senha',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    bool loginSuccess = await _login();
                    if (loginSuccess) {
                      Navigator.pushNamed(context, '/main_home');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Falha no login')));
                    }
                  },
                  child: const Text('Login'),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/create_usuario');
                  },
                  child: const Text('Cadastrar'),
                ),
                Spacer(), // Adiciona outro Spacer para ocupar o máximo de espaço disponível
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/list_usuario');
                  },
                  child: const Text('Listar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
