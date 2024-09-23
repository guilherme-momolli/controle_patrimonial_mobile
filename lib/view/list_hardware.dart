import 'package:controle_patrimonial/global_assets/global_dio_config.dart';
import 'package:controle_patrimonial/global_assets/bottom_navigation_manager.dart';
import 'package:controle_patrimonial/service/hardware_service.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ListHardwareScreen extends StatefulWidget {
  @override
  _ListHardwareScreenState createState() => _ListHardwareScreenState();
}

class _ListHardwareScreenState extends State<ListHardwareScreen> {
  late Dio _dio;
  List<dynamic> hardwares = [];
  final BottomNavigationManager bottomNavManager = BottomNavigationManager();
  late HardwareService _hardwareService;

  @override
  void initState() {
    super.initState();
    _dio = GlobalDioConfig.instance;
    //_hardwareService = HardwareService(GlobalDioConfig.instance);
    _getHardware();
  }

  String safeText(dynamic text) {
    if (text is int) {
      return text.toString();
    } else if (text is String) {
      return text;
    } else {
      return '';
    }
  }

  Future<void> _getHardware() async {
    try {
      var response = await _dio.get('/hardware/list');
      if (response.statusCode == 200) {
        setState(() {
          hardwares = response.data
              .map((dynamic hardware) => {
                    'id': safeText(hardware['codigoPatrimonial']),
                    'componente': safeText(hardware['componente']),
                    'modelo': safeText(hardware['modelo']),
                    'preco': safeText(hardware['precoTotal'])
                  })
              .toList();
        });
      } else {
        print('Failed to get hardware. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<dynamic>> _fetchhardware() async {
    var response = await _dio.get('/hardware/list');
    return response.data
        .map((dynamic hardware) => {
              'componente': hardware['componente'],
              'codigoPatrimonial': hardware['codigoPatrimonial'],
              'modelo': hardware['modelo'],
              'precoTotal': hardware['precoTotal']
            })
        .toList();
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
          final hardware = hardwares[index];
          return Card(
              child: ListTile(
            title: Text(safeText(hardware['modelo'])),
            subtitle: Text('id: ${hardware['id']}'
                'componente: ${hardware['componente']}'
                'numeroSerial: ${hardware['numeroSerial']}'
                'velocidade: ${hardware['velocidade']}'
                'fabricante: ${hardware['fabricante']}'
                'capacidadeArmazenamento: ${hardware['capacidadeArmazenamento']}'
                'dataFabricacao: ${hardware['dataFabricacao']}'
                'precoTotal: ${hardware['precoTotal']}'
                'estatus: ${hardware['estatus']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await _deleteHardware(hardware['id']);
                  },
                ),
              ],
            ),
          ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create_hardware');
        },
        tooltip: 'Adicionar novo hardware',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: bottomNavManager.buildBottomNavigationBar(context),
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
