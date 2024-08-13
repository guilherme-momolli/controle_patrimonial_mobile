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
    _getHardware();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listar Hardwares'),
      ),
      body: ListView.builder(
        itemCount: hardwares.length,
        itemBuilder: (context, index) {
          var hardware = hardwares[index];
          return ListTile(
            title: Text(hardware['nome']),
            subtitle: Text('ID: ${hardware['id']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Implement edit functionality here
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await _deleteHardware(hardware['id']);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
