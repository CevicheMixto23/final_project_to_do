import 'dart:convert';


String userToJson(User data) => json.encode(data.toJson());

class User { 
  String correo;
  String contrasena;
  String? uid;
  User(this.correo,this.contrasena,[this.uid]);

  Map<String, dynamic> toJson() => {
        "correo": correo,
        "contrasena": contrasena
  };

}