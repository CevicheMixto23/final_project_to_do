import 'package:final_project_to_do/models/user_model.dart';
import 'package:final_project_to_do/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController correo1Controller = TextEditingController();
  TextEditingController contrasena1Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blueGrey,
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Center(
            child: Text('HAZLO',
                style: GoogleFonts.righteous(
                  fontSize: 80,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Text('LOGIN',
              style: GoogleFonts.righteous(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(
            height: 70,
          ),
          SizedBox(
            width: size.width * 0.7,
            child: TextField(
              controller: correo1Controller,
              decoration: const InputDecoration(
                  hintText: 'Correo electronico',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: SizedBox(
              width: size.width * 0.7,
              child: TextField(
                obscureText: true,
                controller: contrasena1Controller,
                decoration: const InputDecoration(
                    hintText: 'Contraseña',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "signUpScreen");
            },
            child: const Text(
              'Aún no tienes una cuenta ¡Regístrate ahora!',
              style: TextStyle(
                  decoration: TextDecoration.underline, color: Colors.black),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                User user =
                    User(correo1Controller.text, contrasena1Controller.text);
                loginUser(user).then((isSuccesful) {
                  if (isSuccesful != '') {
                    String id = isSuccesful;
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              title: const Text('Login Exitoso'),
                              content:
                                  const Text('Usuario logeado correctamente'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, "homeScreen",
                                          arguments: id);
                                    },
                                    child: const Text('Aceptar'))
                              ]);
                        });
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              title: const Text('Usuario no registrado'),
                              content: const Text(
                                  '¡No existe un Usuario con esas credenciales!'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Aceptar'))
                              ]);
                        });
                  }
                });
              },
              child: const Text('Iniciar sesión')),
        ],
      ),
    );
  }
}
