import 'package:controle_patrimonial/global_assets/bottom_navigation_manager.dart';
import 'package:controle_patrimonial/service/hardware_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:controle_patrimonial/global_assets/global_dio_config.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  late Dio _dio;
  final BottomNavigationManager bottomNavManager = BottomNavigationManager();
  late HardwareService _hardwareService;

  List<dynamic> hardwares = [];

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
                    'codigoPatrimonial':
                        safeText(hardware['codigoPatrimonial']),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patrimonios'),
      ),
      body: ListView.builder(
        itemCount: hardwares.length,
        itemBuilder: (context, index) {
          final hardware = hardwares[index];

          return Card(
            child: ListTile(
              title: Text(safeText(hardware['codigoPatrimonial'])),
              subtitle: Text(
                  '${safeText(hardware['componente'])}, ${safeText(hardware['modelo'])}, ${safeText(hardware['pretoTotal'])}'),
              trailing: Icon(Icons.more_horiz),
            ),
          );
        },
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
