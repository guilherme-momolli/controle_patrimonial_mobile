// Add this new file: lib/route_config.dart

import 'package:controle_patrimonial/view/create_hardware.dart';
import 'package:controle_patrimonial/view/create_usuario.dart';
import 'package:controle_patrimonial/view/list_hardware.dart';
import 'package:controle_patrimonial/view/list_usuario.dart';
import 'package:controle_patrimonial/view/main_home.dart';
import 'package:controle_patrimonial/view/settings_screen.dart';
import 'package:controle_patrimonial/view/update_usuario.dart';
import 'package:flutter/material.dart';
import 'package:controle_patrimonial/main.dart';
import 'package:controle_patrimonial/view/login.dart';

class RouteConfig {
  static Map<String, WidgetBuilder> get routes {
    return {
      '/login': (context) => LoginScreen(),
      '/list_hardware': (context) => ListHardwareScreen(),
      '/list_usuario': (context) => ListarUsuarioScreen(),
      '/create_hardware': (context) => CreateHardwareScreen(),
      '/create_usuario': (context) => CreateUsuarioScreen(),
      '/main_home': (context) => MainHomeScreen(),
      '/update_usuario': (context) => UpdateUsuarioScreen(),
      '/settings_screen': (context) => SettingsScreen()
    };
  }
}
