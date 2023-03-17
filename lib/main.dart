import 'package:flutter/material.dart';
import 'package:hisab/screens/home.dart';
import 'package:hisab/service/auth_service.dart';
import 'package:hisab/service/student_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isAuthenticated = await AuthService.authenticate();
  if (isAuthenticated) {
    runApp(const MyApp());
  } else {
    main();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    StudentService.init();
    return MaterialApp(
      title: 'Hisab',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Home(title: 'Hisab Home'),
    );
  }
}
