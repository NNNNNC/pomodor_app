import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_app/pages/flashcard_page.dart';
import 'package:pomodoro_app/pages/pomodoro_page.dart';
import 'package:pomodoro_app/pages/profile_page.dart';
import 'package:pomodoro_app/pages/topic_page.dart';
import 'package:pomodoro_app/providers/visibility_provider.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final PageStorageBucket bucket = PageStorageBucket();
  final List<Widget> pages = const [
    PomodoroPage(
      key: PageStorageKey('PomodoroPage'),
    ),
    flashcard_page(
      key: PageStorageKey('FlashcardPage'),
    ),
    topic_page(
      key: PageStorageKey('TopicPage'),
    ),
    profile_page(
      key: PageStorageKey('ProfilePage'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomBarVisibility>(
      builder: (context, value, child) => DefaultTabController(
        length: 4,
        child: Scaffold(
          bottomNavigationBar: value.isVisible ? bottomBar(context) : null,
          body: PageStorage(
            bucket: bucket,
            child: TabBarView(
              children: pages,
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      ),
      child: TabBar(
        tabAlignment: TabAlignment.fill,
        indicator: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 2.0,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        indicatorColor: Theme.of(context).colorScheme.secondary,
        labelColor: Theme.of(context).colorScheme.secondary,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
        tabs: const [
          Tab(
            text: 'Pomodoro',
            icon: ImageIcon(
              AssetImage('assets/icons/pie-chart.png'),
              size: 25,
            ),
          ),
          Tab(
            text: 'Flashcard',
            icon: ImageIcon(
              AssetImage('assets/icons/document.png'),
              size: 25,
            ),
          ),
          Tab(
            text: 'Topics',
            icon: ImageIcon(
              AssetImage('assets/icons/bill.png'),
              size: 25,
            ),
          ),
          Tab(
            text: 'Profile',
            icon: Icon(
              Icons.person_outline,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}
