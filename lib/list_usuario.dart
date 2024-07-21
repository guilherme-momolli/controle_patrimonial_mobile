import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ListarUsuarioScreen extends StatefulWidget {
  @override
  _ListarUsuarioScreenState createState() => _ListarUsuarioScreenState();
}

class _ListarUsuarioScreenState extends State<ListarUsuarioScreen> {
  late Dio _dio;
  List<dynamic> usuarios = [];

  @override
  void initState() {
    super.initState();
    _dio = Dio();
    _dio.options.headers["Access-Control-Allow-Origin"] = "*";
    _dio.options.headers["Access-Control-Allow-Credentials"] = true;
    _dio.options.headers["Access-Control-Allow-Headers"] =
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale";
    _dio.options.headers["Access-Control-Allow-Methods"] =
        "GET, HEAD, POST, OPTIONS";
    //_getUsuario();
    _getNewUsuario();
  }

  Future<void> _deleteUsuario(int id) async {
    try {
      var response = await _dio.delete(
        'http://192.168.0.121:8080/usuario/delete/$id',
      );
      if (response.statusCode == 200) {
        print('Pessoa deleted successfully.');
      } else {
        print('Failed to delete pessoa. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getUsuario() async {
    try {
      var response = await _dio.get('http://192.168.0.121:8080/usuario/list');
      if (response.statusCode == 200) {
        setState(() {
          usuarios = response.data;
        });
      } else {
        print('Failed to get usuarios. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getNewUsuario() async {
    try {
      final response = await _dio.get('http://192.168.0.121:8080/usuario/list',
          options: Options(headers: {
            'Accept': 'application/json',
          }));
    } catch (e) {
      print(e);
    }
  }

  Future<List<dynamic>> _fetchUsuarios() async {
    var response = await _dio.get('http://192.168.0.121:8080/usuario/list');
    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listar Usuario'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _fetchUsuarios(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var usuario = snapshot.data![index];
                return card(
                  title: Text(usuario['nome']),
                  subtitle: Text(
                      'id: ${usuario['id']} email: ${usuario['email']} senha: ${usuario['senha']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Editar'),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () async {
                          await _deleteUsuario(usuario['id']);
                          setState(() {});
                        },
                        child: const Text('Deletar'),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget card(
      {required Widget title,
      required Widget subtitle,
      required Widget trailing}) {
    return Card(
      child: ListTile(
        title: title,
        subtitle: subtitle,
        trailing: trailing,
      ),
    );
  }
}
