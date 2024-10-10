import 'package:flutter/material.dart';
import 'package:pomodoro_app/utils/theme_tile.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: const Text(
            "Themes",
            style: TextStyle(
              fontSize: 18.5,
            ),
          ),
        ),
      ),
      body: GridView.count(
        childAspectRatio: (itemWidth / (itemHeight / 1.3)),
        padding: const EdgeInsets.all(18),
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: [
          ThemeTile(
            bgURL: 'assets/bg/simple.jpg',
            radioValue: 'simple',
            themeTitle: 'Simple',
          ),
          ThemeTile(
            bgURL: 'assets/bg/forest.jpg',
            radioValue: 'forest',
            themeTitle: 'Forest',
          ),
          ThemeTile(
            bgURL: 'assets/bg/modern.jpg',
            radioValue: 'modern',
            themeTitle: 'Modern',
          ),
          ThemeTile(
            bgURL: 'assets/bg/underwater.jpg',
            radioValue: 'underwater',
            themeTitle: 'Underwater',
          ),
          ThemeTile(
            bgURL: 'assets/bg/chocolate.jpg',
            radioValue: 'choco',
            themeTitle: 'Chocolate',
          ),
          ThemeTile(
            bgURL: 'assets/bg/rosy.jpg',
            radioValue: 'rosy',
            themeTitle: 'Rosy',
          ),
          ThemeTile(
            bgURL: 'assets/bg/zen.jpg',
            radioValue: 'zen',
            themeTitle: 'Zen',
          ),
        ],
      ),
    );
  }
}
