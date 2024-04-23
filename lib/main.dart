// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pomodoro_app/models/profileModel.dart';
import 'package:pomodoro_app/providers/visibility_provider.dart';
import 'package:provider/provider.dart';
import 'pages/main_page.dart';
import 'theme/theme.dart';

// Hive Boxes
//late Box flashcardBox;
late Box<profileModel> profileBox;

//const String flashcardBoxName = 'flashcard';
const String profileBoxName = 'profile';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter<profileModel>(profileAdapter());

  //flashcardBox = await Hive.openBox(flashcardBoxName);
  await Hive.openBox<profileModel>(profileBoxName);

  runApp(
    ChangeNotifierProvider(
      create: (context) => BottomBarVisibility(),
      child: const MyApp(),
    ),
  );
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
