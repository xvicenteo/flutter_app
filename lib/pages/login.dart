import 'package:flutter/material.dart';
import 'package:flutterapps/user_services/auth_controller.dart';
import 'package:flutterapps/user_services/storage.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();
    AuthController authController = AuthController();

    final secureStorage = SecureStorageService();

    username.text = 'root';
    password.text = 'VtiPptVFVtf8B7HT4N3V';

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column (
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage('assets/omkiner_logo.png'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0 ,0),
            child: TextFormField(
              controller: username,
              decoration: const InputDecoration(hintText: 'Usuario'),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0 ,0),
            child: TextFormField(
              controller: password,
              decoration: const InputDecoration(hintText: 'Contraseña'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0 ,0),
            child: ElevatedButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 14),
              ),
              onPressed: () async{
                var refreshToken = await secureStorage.readToken('refresh');
                authController.performTokenRefresh(refreshToken!);
                if(!context.mounted) return;
                authController.loginUser(context, username.text, password.text);
              },
              child: const Text('Entrar'),
            ),
          ),
        ],
      ),
    );
  }
}
