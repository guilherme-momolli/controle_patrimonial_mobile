import 'package:controle_patrimonial/global_assets/global_dio_config.dart';
import 'package:controle_patrimonial/global_assets/bottom_navigation_manager.dart';
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
            title: Text(hardware['codigo_patrimonial']),
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
                  icon: Icon(Icons.add_circle_outline),
                  onPressed: () {
                    Navigator.pushNamed(context, '/create_hardware');
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
