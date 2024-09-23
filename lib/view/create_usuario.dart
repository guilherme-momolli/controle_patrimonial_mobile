import 'package:controle_patrimonial/global_assets/global_dio_config.dart';
import 'package:controle_patrimonial/service/usuario_service.dart';
import 'package:flutter/material.dart';

class CreateUsuarioScreen extends StatefulWidget {
  @override
  _CreateUsuarioScreenState createState() => _CreateUsuarioScreenState();
}

class _CreateUsuarioScreenState extends State<CreateUsuarioScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  late UsuarioService _usuarioService;

  @override
  void initState() {
    super.initState();
    _usuarioService = UsuarioService(GlobalDioConfig.instance);
  }

  Future<void> _createUsuario() async {
    if (_formKey.currentState!.validate()) {
      try {
        bool resultado = await _usuarioService.createUsuario(
          _nomeController.text,
          _emailController.text,
          _senhaController.text,
        );
        if (resultado) {
          print('Usuario created successfully.');
          Navigator.pushReplacementNamed(context, '/login');
        } else {
          print('Failed to create pessoa.');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Pessoa')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTextField(_nomeController, 'Nome'),
              SizedBox(height: 16),
              _buildTextField(_emailController, 'Email'),
              SizedBox(height: 16),
              _buildTextField(_senhaController, 'Senha', obscureText: true),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _createUsuario,
                child: Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText,
      {bool obscureText = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Este campo é obrigatório';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
    );
  }
}
