// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pomodoro_app/models/flashcardModel.dart';
import 'package:pomodoro_app/models/profileModel.dart';
import 'package:pomodoro_app/models/topicModel.dart';
import 'package:pomodoro_app/pages/main_page.dart';
import 'package:pomodoro_app/providers/visibility_provider.dart';
import 'package:provider/provider.dart';
import 'theme/theme.dart';

// Hive Boxes
late Box<Flashcard> flashcardBox;
late Box<profileModel> profileBox;
late Box<TopicModel> topicBox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter<Flashcard>(flashcardAdapter());
  Hive.registerAdapter<profileModel>(profileAdapter());
  Hive.registerAdapter<TopicModel>(TopicAdapter());

  flashcardBox = await Hive.openBox<Flashcard>('flashcard');
  profileBox = await Hive.openBox<profileModel>('profile');
  topicBox = await Hive.openBox<TopicModel>('topic');

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
      home: MainPage(),
    );
  }
}
