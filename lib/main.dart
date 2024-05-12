// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pomodoro_app/models/flashcardModel.dart';
import 'package:pomodoro_app/models/profileModel.dart';
import 'package:pomodoro_app/models/selectedModel.dart';
import 'package:pomodoro_app/models/topicModel.dart';
import 'package:pomodoro_app/onBoarding/Onboarding.dart';
import 'package:pomodoro_app/pages/main_page.dart';
import 'package:pomodoro_app/providers/visibility_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme/theme.dart';

// Hive Boxes
late Box<Flashcard> flashcardBox;
late Box<profileModel> profileBox;
late Box<TopicModel> topicBox;
late Box<SelectedModel> defaultKey;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool('onboarding') ?? false;
  

  await Hive.initFlutter();

  Hive.registerAdapter<Flashcard>(flashcardAdapter());
  Hive.registerAdapter<profileModel>(profileAdapter());
  Hive.registerAdapter<TopicModel>(TopicAdapter());
  Hive.registerAdapter<SelectedModel>(KeyAdapter());

  flashcardBox = await Hive.openBox<Flashcard>('flashcard');
  profileBox = await Hive.openBox<profileModel>('profile');
  topicBox = await Hive.openBox<TopicModel>('topic');
  defaultKey = await Hive.openBox<SelectedModel>('key');

  runApp(
    ChangeNotifierProvider(
      create: (context) => BottomBarVisibility(),
      child: MyApp(onboarding: onboarding,),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool onboarding;
  const MyApp({super.key, this.onboarding = false});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: app_theme,
      home: onboarding? MainPage() : OnboardingScreen(),
    );
  }
}
