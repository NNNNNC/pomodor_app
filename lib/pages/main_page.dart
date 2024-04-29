import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_app/pages/flashcard_page.dart';
import 'package:pomodoro_app/pages/pomodoro_page.dart';
import 'package:pomodoro_app/pages/profile_page.dart';
import 'package:pomodoro_app/pages/topic_page.dart';
import 'package:pomodoro_app/providers/visibility_provider.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomBarVisibility>(
      builder: (context, value, child) => DefaultTabController(
        length: 4,
        child: Scaffold(
          bottomNavigationBar: value.isVisible ? bottomBar(context) : null,
          body: const TabBarView(
            children: [
              PomodoroPage(),
              flashcard_page(),
              topic_page(),
              profile_page(),
            ],
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
