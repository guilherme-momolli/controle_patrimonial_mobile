import 'package:controle_patrimonial/GlobalDioConfig.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:controle_patrimonial/main.dart';

class UpdateUsuarioScreen extends StatefulWidget {
  @override
  _UpdateUsuarioScreenState createState() => _UpdateUsuarioScreenState();
}

class _UpdateUsuarioScreenState extends State<UpdateUsuarioScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  late Dio _dio;

  @override
  void initState() {
    super.initState();
    _dio = GlobalDioConfig.instance;
  }

  Future<void> _updateUsuario(int id) async {
    String nome = _nomeController.text;
    String email = _emailController.text;
    String senha = _senhaController.text;

    try {
      var response = await _dio.post(
        '/usuario/update/$id',
        data: {
          'nome': nome,
          'email': email,
          'senha': senha,
        },
      );
      if (response.statusCode == 201) {
        print('Usuario created successfully.');
      } else {
        print('Failed to update pessoa. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Pessoa'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _senhaController,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                //_updateUsuario();
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
