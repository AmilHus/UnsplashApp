import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unsplash App',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 1, 4, 10),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
