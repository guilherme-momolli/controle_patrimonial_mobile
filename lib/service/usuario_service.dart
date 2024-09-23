import 'package:dio/dio.dart';

class UsuarioService {
  late Dio _dio;

  UsuarioService(this._dio);

  Future<bool> createUsuario(String nome, String email, String senha) async {
    try {
      var response = await _dio.post(
        '/usuario/create',
        data: {
          'nome': nome,
          'email': email,
          'senha': senha,
        },
      );
      return response.statusCode == 201;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> deleteUsuario(int id) async {
    try {
      var response = await _dio.delete('/usuario/delete/$id');
      if (response.statusCode != 204) {
        throw Exception(
            'Failed to delete usuario. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<dynamic>> getUsuario() async {
    try {
      var response = await _dio.get('/usuario/list');
      if (response.statusCode != 200) {
        throw Exception(
            'Failed to get usuarios. Status code: ${response.statusCode}');
      }
      return response.data;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<dynamic>> getNewUsuario() async {
    try {
      final response = await _dio.get('/usuario/list',
          options: Options(headers: {'Accept': 'application/json'}));
      if (response.statusCode != 200) {
        throw Exception(
            'Failed to get new usuarios. Status code: ${response.statusCode}');
      }
      return response.data;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<dynamic>> fetchUsuarios() async {
    try {
      var response = await _dio.get('/usuario/list');
      if (response.statusCode != 200) {
        throw Exception(
            'Failed to fetch usuarios. Status code: ${response.statusCode}');
      }
      return response.data;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
