import 'package:controle_patrimonial/global_assets/bottom_navigation_manager.dart';
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
  List<dynamic> hardwares = [];

  @override
  void initState() {
    super.initState();
    _dio = GlobalDioConfig.instance;
    _getHardware();
  }

  String safeText(String? text) {
    return text ?? '';
  }

  Future<void> _getHardware() async {
    try {
      var response = await _dio.get('/hardware/list');
      if (response.statusCode == 200) {
        setState(() {
          hardwares = response.data
              .map((dynamic hardware) => {
                    'nome': safeText(hardware['nome']),
                    'descricao': safeText(hardware['descricao'])
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
    var response = await _dio.get('/usuario/list');
    return response.data
        .map((dynamic usuario) =>
            {'nome': usuario['nome'], 'descricao': usuario['descricao']})
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
              title: Text(safeText(hardware['nome'])),
              subtitle: Text(safeText(hardware['descricao'])),
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
