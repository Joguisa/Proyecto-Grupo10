import 'package:flutter/material.dart';
import 'package:proyecto_grupo10/config/theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
   
  const MainApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      home: const Scaffold(
        body: Center(
          child: Text('Hello world'),
        ),
      ),
    );
  }
}