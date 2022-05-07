import 'package:calculator_app/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  // ignore: prefer_const_constructors
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeApp(),
    );
  }
}
