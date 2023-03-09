import 'package:flutter/material.dart';
import 'package:hisab/service/student_manager.dart';

import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    StudentManager.init();
    return MaterialApp(
      title: 'Hisab',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Home(title: 'Hisab Home'),
    );
  }
}