import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomodoro_app/pages/main_pages/flashcard_page.dart';
import 'package:pomodoro_app/pages/main_pages/menu_page.dart';
import 'package:pomodoro_app/pages/main_pages/pomodoro_page.dart';
import 'package:pomodoro_app/pages/main_pages/topic_page.dart';
import 'package:pomodoro_app/providers/visibility_provider.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  final PageStorageBucket bucket = PageStorageBucket();
  DateTime? lastBackPressed;
  late TabController _tabController;

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
    MenuPage(
      key: PageStorageKey('MenuPage'),
    ),
  ];

  bool get canPop {
    return lastBackPressed != null &&
        DateTime.now().difference(lastBackPressed!) <
            const Duration(seconds: 2);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: pages.length, vsync: this);
    _tabController.addListener(_clearSnackBarsOnPageChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_clearSnackBarsOnPageChange);
    _tabController.dispose();
    super.dispose();
  }

  void _clearSnackBarsOnPageChange() {
    if (_tabController.indexIsChanging) {
      ScaffoldMessenger.of(context).clearSnackBars();
    }
  }

  void handleBackPress(BottomBarVisibility value) {
    if (!value.isVisible) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 2),
          backgroundColor: Color.fromARGB(255, 22, 22, 22),
          content: Text(
            'You cannot leave while on lock mode',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      );
      return;
    }

    final now = DateTime.now();
    if (lastBackPressed == null ||
        now.difference(lastBackPressed!) > const Duration(seconds: 2)) {
      lastBackPressed = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 2),
          backgroundColor: Color.fromARGB(255, 22, 22, 22),
          content: Text(
            'Tap back again to leave the app.',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      );
    } else {
      SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomBarVisibility>(
      builder: (context, value, child) => DefaultTabController(
        initialIndex: 0,
        length: 4,
        child: PopScope(
          canPop: canPop,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) handleBackPress(value);
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: value.isVisible ? bottomBar(context) : null,
            body: PageStorage(
              bucket: bucket,
              child: TabBarView(
                controller: _tabController,
                physics: value.isVisible
                    ? const PageScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                children: pages,
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
        controller: _tabController,
        dividerColor: Colors.transparent,
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
