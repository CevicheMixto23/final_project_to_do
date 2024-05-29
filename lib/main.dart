import 'package:final_project_to_do/routes/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hazlo App',
      initialRoute: AppRouting.initialRoute,
      debugShowCheckedModeBanner: false,
      routes: AppRouting.getRoutes(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      )
    );
  }
}