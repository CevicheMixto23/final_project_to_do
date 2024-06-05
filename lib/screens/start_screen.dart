import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: GestureDetector(
        onTap: () {
          Navigator.pushReplacementNamed(context, "loginScreen");
        },
        child: Stack(
          children: [
            Center(
              // Center the logo
              child: Image.asset('assets/logo.png'),
            ),
            Positioned(
              bottom: 0, // Anchor to the bottom
              right: 0, // Anchor to the right
              child: Image.asset(
                'assets/fondo.png',
                width: 250,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
