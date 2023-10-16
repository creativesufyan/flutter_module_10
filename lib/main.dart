import 'package:flutter/material.dart';
import 'package:module_10/home_screen.dart';

// ToDo application
// CRUD create , read , update , delete

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
