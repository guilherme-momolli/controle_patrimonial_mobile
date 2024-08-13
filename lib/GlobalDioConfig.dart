import 'package:dio/dio.dart';

class GlobalDioConfig {
  static final Dio _instance = Dio();

  static void configureDio() {
    _instance.options.baseUrl = 'http://192.168.0.117:8080';
    _instance.options.headers["Access-Control-Allow-Origin"] = "*";
    _instance.options.headers["Access-Control-Allow-Credentials"] = true;
    _instance.options.headers["Access-Control-Allow-Headers"] =
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale";
    _instance.options.headers["Access-Control-Allow-Methods"] =
        "GET, HEAD, POST, OPTIONS";
    //_instance.options.headers['Accept'] = 'application/json';
  }

  static Dio get instance => _instance;
}
