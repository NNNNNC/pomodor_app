import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_app/pages/flashcard_page.dart';
import 'package:pomodoro_app/pages/menu_page.dart';
import 'package:pomodoro_app/pages/pomodoro_page.dart';
import 'package:pomodoro_app/pages/profile_page.dart';
import 'package:pomodoro_app/pages/topic_page.dart';
import 'package:pomodoro_app/providers/visibility_provider.dart';
import 'package:provider/provider.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

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
    MenuPage(
      key: PageStorageKey('MenuPage'),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomBarVisibility>(
      builder: (context, value, child) => DefaultTabController(
        initialIndex: 0,
        length: 5,
        child: PopScope(
          canPop: value.isVisible ? true : false,
          // onPopInvoked: (didPop) {
          //   if (didPop) {
          //     return;
          //   }
          //   _showLeaveDialog(context);
          // },
          child: Scaffold(
            bottomNavigationBar: value.isVisible ? bottomBar(context) : null,
            body: PageStorage(
              bucket: bucket,
              child: DoubleBackToCloseApp(
                snackBar: SnackBar(
                  duration: Durations.medium4,
                  backgroundColor: const Color.fromARGB(255, 22, 22, 22),
                  content: Text(
                    value.isVisible
                        ? 'Tap back again to leave the app.'
                        : 'You cannot leave while on lock mode',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                child: TabBarView(
                  physics: value.isVisible
                      ? const PageScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
                  children: pages,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomBar(BuildContext context) {
    return Container(
      height: 70,
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
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
        tabs: const [
          SizedBox(
            width: 70,
            child: Tab(
              text: 'Pomodoro',
              icon: ImageIcon(
                AssetImage('assets/icons/pie-chart.png'),
                size: 20,
              ),
            ),
          ),
          SizedBox(
            width: 70,
            child: Tab(
              text: 'Flashcard',
              icon: ImageIcon(
                AssetImage('assets/icons/document.png'),
                size: 20,
              ),
            ),
          ),
          SizedBox(
            width: 70,
            child: Tab(
              text: 'Topics',
              icon: ImageIcon(
                AssetImage('assets/icons/bill.png'),
                size: 20,
              ),
            ),
          ),
          SizedBox(
            width: 70,
            child: Tab(
              text: 'Presets',
              icon: Icon(
                Icons.person_outline,
                size: 20,
              ),
            ),
          ),
          SizedBox(
            width: 70,
            child: Tab(
              text: 'Menu',
              icon: Icon(
                Icons.menu,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
