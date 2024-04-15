// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'pages/main_page.dart';
import 'theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: app_theme,
      home: Mainpage(),
    );
  }
}
  