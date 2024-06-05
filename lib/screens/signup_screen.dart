import 'package:final_project_to_do/models/user_model.dart';
import 'package:final_project_to_do/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController correoController = TextEditingController();
  TextEditingController contrasenaController = TextEditingController();
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
          Text('REGISTER',
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
              controller: correoController,
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
                controller: contrasenaController,
                decoration: const InputDecoration(
                    hintText: 'Contraseña',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                User user =
                    User(correoController.text, contrasenaController.text);
                addUser(user).then((isSuccesful) {
                  if (isSuccesful) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              title: const Text('Usuario Registrado'),
                              content: const Text(
                                  'Usuario registrado correctamente'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, "loginScreen");
                                    },
                                    child: const Text('Aceptar'))
                              ]);
                        });
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              title: const Text('Usuario Existente'),
                              content: const Text(
                                  '¡Ya existe un usuario con ese correo electronico!'),
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
              child: const Text('Registrarse'))
        ],
      ),
    );
  }
}
