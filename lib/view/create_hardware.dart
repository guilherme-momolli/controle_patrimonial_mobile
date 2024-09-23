import 'package:controle_patrimonial/global_assets/global_dio_config.dart';
import 'package:controle_patrimonial/model/enum/componente.dart';
import 'package:controle_patrimonial/model/enum/estatus.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class CreateHardwareScreen extends StatefulWidget {
  @override
  _CreateHardwareScreenState createState() => _CreateHardwareScreenState();
}

class _CreateHardwareScreenState extends State<CreateHardwareScreen> {
  final TextEditingController _codigoPatrimonialController =
      TextEditingController();
  final TextEditingController _componenteController = TextEditingController();
  final TextEditingController _numeroSerialController = TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _fabricanteController = TextEditingController();
  final TextEditingController _velocidadeController = TextEditingController();
  final TextEditingController _capacidadeArmazenamentoController =
      TextEditingController();
  final TextEditingController _dataFabricacaoController =
      TextEditingController();
  final TextEditingController _precoTotalController = TextEditingController();
  final TextEditingController _estatusController = TextEditingController();
  late Dio _dio;

  Componente? _selectedComponente;
  Estatus? _selectedEstatus;

  @override
  void initState() {
    super.initState();
    _dio = GlobalDioConfig.instance;
  }

  Future<void> _createHardware() async {
    String codigoPatrimonial = _codigoPatrimonialController.text;
    String componente = _componenteController.text;
    String numeroSerial = _numeroSerialController.text;
    String modelo = _modeloController.text;
    String fabricante = _fabricanteController.text;
    String velocidade = _velocidadeController.text;
    String capacidadeArmazenamento = _capacidadeArmazenamentoController.text;
    String dataFabricacao = _dataFabricacaoController.text;
    double precoTotal = double.parse(_precoTotalController.text);
    String estatus = _estatusController.text;

    try {
      var response = await _dio.post(
        '/hardware/create',
        data: {
          'codigoPatrimonial': codigoPatrimonial,
          'componente': componente,
          'numeroSerial': numeroSerial,
          'modelo': modelo,
          'fabricante': fabricante,
          'velocidade': velocidade,
          'capacidadeArmazenamento': capacidadeArmazenamento,
          'dataFabricacao': dataFabricacao,
          'precoTotal': precoTotal.toString(),
          'estatus': estatus,
        },
      );
      if (response.statusCode == 201) {
        print('Hardware criado com sucesso.');
      } else {
        print(
            'Falha ao criar hardware. Código de status: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Hardware'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _codigoPatrimonialController,
              decoration: InputDecoration(
                labelText: 'Código Patrimonial',
                border: OutlineInputBorder(),
              ),
            ),
            DropdownButtonFormField<Componente>(
              value: _selectedComponente,
              icon: const Icon(Icons.arrow_downward),
              onChanged: (Componente? newValue) {
                setState(() {
                  _selectedComponente = newValue;
                });
              },
              items: Componente.values.map((Componente component) {
                return DropdownMenuItem<Componente>(
                  value: component,
                  child: Text(component.toString().split('.').last),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Componente',
                border: OutlineInputBorder(),
              ),
            ),
            // Dropdown para Estatus
            DropdownButtonFormField<Estatus>(
              value: _selectedEstatus,
              icon: const Icon(Icons.arrow_downward),
              onChanged: (Estatus? newValue) {
                setState(() {
                  _selectedEstatus = newValue;
                });
              },
              items: Estatus.values.map((Estatus status) {
                return DropdownMenuItem<Estatus>(
                  value: status,
                  child: Text(status.toString().split('.').last),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Estatus',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _createHardware();
              },
              child: Text('Criar'),
            ),
          ],
        ),
      ),
    );
  }
}
