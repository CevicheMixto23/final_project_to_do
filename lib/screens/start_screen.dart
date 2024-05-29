import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 104, 142, 186),
      body: GestureDetector(
        onTap: () {
          Navigator.pushReplacementNamed(context, "homeScreen");
        },
        child: Stack(
          // Use Stack for overlapping widgets
          children: [
            Center(
              // Center the logo
              child: Image.asset('assets/logo.png'),
            ),
            Positioned(
              // Position the bottom image at the bottom right
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
