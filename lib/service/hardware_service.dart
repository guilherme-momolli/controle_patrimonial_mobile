import 'package:dio/dio.dart';

export 'package:controle_patrimonial/service/hardware_service.dart';

class HardwareService {
  late Dio _dio;

  HardwareService(this._dio);

  static String safeText(dynamic text) {
    if (text is int) {
      return text.toString();
    } else if (text is String) {
      return text;
    } else {
      return '';
    }
  }

  static String formatPrice(double price) {
    return price.toStringAsFixed(2);
  }

  static String capitalize(String text) {
    if (text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  static String combineStrings(List<String?> items) {
    return items.join(', ');
  }

  Future<List<dynamic>> getHardwareList() async {
    try {
      var response = await _dio.get('/hardware/list');
      if (response.statusCode == 200) {
        return response.data
            .map((dynamic hardware) => {
                  'id': safeText(hardware['codigoPatrimonial']),
                  'componente': safeText(hardware['componente']),
                  'modelo': safeText(hardware['modelo']),
                  'preco': safeText(hardware['precoTotal'])
                })
            .toList();
      } else {
        throw Exception(
            'Failed to get hardware. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> deleteHardware(int id) async {
    try {
      var response = await _dio.delete('/hardware/delete/$id');
      if (response.statusCode == 200) {
        print('Hardware deleted successfully.');
        return null;
      } else {
        throw Exception(
            'Failed to delete hardware. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
