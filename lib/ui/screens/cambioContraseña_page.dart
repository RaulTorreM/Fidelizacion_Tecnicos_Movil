import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/profile_bloc.dart';

class ChangePasswordPage extends StatefulWidget {
  final String idTecnico;

  const ChangePasswordPage({Key? key, required this.idTecnico}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final profileBloc = Provider.of<PerfilBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cambiar Contraseña'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: currentPasswordController,
                decoration: InputDecoration(labelText: 'Contraseña actual'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese su contraseña actual';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: newPasswordController,
                decoration: InputDecoration(labelText: 'Nueva contraseña'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese su nueva contraseña';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: confirmPasswordController,
                decoration: InputDecoration(labelText: 'Confirmar nueva contraseña'),
                obscureText: true,
                validator: (value) {
                  if (value != newPasswordController.text) {
                    return 'Las contraseñas no coinciden';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await profileBloc.changePassword(
                      widget.idTecnico,
                      currentPasswordController.text,
                      newPasswordController.text,
                    );

                    if (profileBloc.error == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Contraseña cambiada exitosamente')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(profileBloc.error!)),
                      );
                    }
                  }
                },
                child: Text('Cambiar Contraseña'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
