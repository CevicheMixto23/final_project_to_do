
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
      backgroundColor:  const Color.fromARGB(255, 104, 142, 186),
      body: Column(
        children: [
          const SizedBox(height: 100,),
          Center(
            child: Text('HAZLO', 
            style: GoogleFonts.righteous(
              fontSize: 100, 
              color: Colors.black,
              fontWeight: FontWeight.bold,    
              )
            ),
          ),
          Text('LOGIN', 
            style: GoogleFonts.righteous(
              fontSize: 40, 
              color: Colors.black,
              fontWeight: FontWeight.bold,    
              )
          ),
          const SizedBox(height: 150,),
          SizedBox(
            width: size.width * 0.7,
            child: TextField(
              controller: correo1Controller,
              decoration: const InputDecoration(
              hintText: 'Correo electronico',
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))
              )
             ),
           ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: SizedBox(
              width: size.width * 0.7,
              child: TextField(
                controller: contrasena1Controller,
                decoration: const InputDecoration(
                hintText: 'Contraseña',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
                )
               ),
             ),
            ),
          ),
          TextButton(
            onPressed: (){
              Navigator.pushNamed(context, "signUpScreen");
            }, 
            child: const Text('Aún no tienes una cuenta ¡Regístrate ahora!',
            style: TextStyle(decoration: TextDecoration.underline,color: Colors.black),
            ),
          ),
          ElevatedButton(onPressed: (){
            User user = User(correo1Controller.text, contrasena1Controller.text);
            loginUser(user).then((isSuccesful){
              if (isSuccesful){
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                title: const Text('Login Exitoso'),
                content: const Text('Usuario logeado correctamente'),
                actions: [
                  TextButton(onPressed: (){
                    Navigator.pushReplacementNamed(context, "homeScreen");
                  }, child: const Text('Aceptar'))
                ]);           
              });}
              else{
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                title: const Text('Usuario no registrado'),
                content: const Text('¡No existe un Usuario con esas credenciales!'),
                actions: [
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: const Text('Aceptar'))
                ]);           
              });  
              }
              });
          }, child: const Text('Iniciar sesión'))
        ],
      ),
    );
  }
} 
