import 'package:controle_patrimonial/GlobalDioConfig.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ListarHardwareScreen extends StatefulWidget {
  @override
  _ListarHardwareScreenState createState() => _ListarHardwareScreenState();
}

class _ListarHardwareScreenState extends State<ListarHardwareScreen> {
  late Dio _dio;
  List<dynamic> hardwares = [];

  @override
  void initState() {
    super.initState();
    _dio = GlobalDioConfig.instance;
    _getNewHardware();
    _getHardware();
  }

  Future<void> _deleteHardware(int id) async {
    try {
      var response = await _dio.delete('/hardware/delete/$id');
      if (response.statusCode == 200) {
        print('Hardware deleted successfully.');
        _getHardware();
      } else {
        print('Failed to delete hardware. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getHardware() async {
    try {
      var response = await _dio.get('/hardware/list');
      if (response.statusCode == 200) {
        setState(() {
          hardwares = response.data;
        });
      } else {
        print('Failed to get hardware. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getNewHardware() async {
    try {
      final response = await _dio.get('/hardware/list',
          options: Options(headers: {
            'Accept': 'application/json',
          }));
    } catch (e) {
      print(e);
    }
  }

  Future<List<dynamic>> _fetchHardwares() async {
    var response = await _dio.get('/hardware/list');
    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listar Hardwares'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _fetchHardwares(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: hardwares.length,
              itemBuilder: (context, index) {
                var hardware = hardwares[index];
                return card(
                  title: Text(hardware['nome']),
                  subtitle: Text('id: ${hardware['id']}'),
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
                          await _deleteHardware(hardware['id']);
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

  Widget card({
    required Widget title,
    required Widget subtitle,
    required Widget trailing,
  }) {
    return Card(
      child: ListTile(
        title: title,
        subtitle: subtitle,
        trailing: trailing,
      ),
    );
  }
}
