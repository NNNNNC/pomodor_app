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
import 'package:pomodoro_app/utils/data_init/initial_cards.dart';
import 'package:pomodoro_app/utils/data_init/initial_presets.dart';
import 'package:pomodoro_app/utils/data_init/initial_topics.dart';
import 'package:pomodoro_app/utils/others/notification_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme/theme.dart';
import 'package:flutter/services.dart';

// Hive Boxes
late Box<Flashcard> flashcardBox;
late Box<profileModel> profileBox;
late Box<TopicModel> topicBox;
late Box<SelectedModel> defaultKey;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationHelper.init();
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool('onboarding') ?? false;

  await Hive.initFlutter();

  // for tracking sessions statistics
  await Hive.openBox('focusSessions');

  // for the daily study target
  await Hive.openBox('studyTarget');

  await Hive.openBox('themePrefs');

  Hive.registerAdapter<Flashcard>(flashcardAdapter());
  Hive.registerAdapter<profileModel>(profileAdapter());
  Hive.registerAdapter<TopicModel>(TopicAdapter());
  Hive.registerAdapter<SelectedModel>(KeyAdapter());

  flashcardBox = await Hive.openBox<Flashcard>('flashcard');
  profileBox = await Hive.openBox<profileModel>('profile');
  topicBox = await Hive.openBox<TopicModel>('topic');
  defaultKey = await Hive.openBox<SelectedModel>('key');

  // Add preset cards and topics
  if (flashcardBox.isEmpty &&
      topicBox.isEmpty &&
      profileBox.isEmpty &&
      !onboarding) {
    for (var flashcard in InitialCards().cards) {
      await flashcardBox.add(flashcard);
    }

    for (var topic in InitialTopics().topics) {
      await topicBox.add(topic);
    }

    for (var preset in InitialPresets().presets) {
      await profileBox.add(preset);
    }
  }

  if (!onboarding)
    defaultKey.put(
      0,
      SelectedModel(
        selectedProfile: 0,
      ),
    );

  runApp(
    ChangeNotifierProvider(
      create: (context) => BottomBarVisibility(),
      child: MyApp(
        onboarding: onboarding,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool onboarding;
  const MyApp({
    super.key,
    this.onboarding = false,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Consumer<BottomBarVisibility>(
      builder: (context, value, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: value.isusingCustom ? value.getCustomTheme() : app_theme_light,
        darkTheme: value.isusingCustom ? value.getCustomTheme() : app_theme,
        themeMode: value.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        home: onboarding ? MainPage() : OnboardingScreen(),
      ),
    );
  }
}
