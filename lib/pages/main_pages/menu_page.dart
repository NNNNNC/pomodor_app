import 'package:flutter/material.dart';
import 'package:pomodoro_app/pages/menu_pages/preset_page.dart';
import 'package:pomodoro_app/pages/menu_pages/settings_page.dart';
import 'package:pomodoro_app/pages/menu_pages/statistics_page.dart';
import 'package:pomodoro_app/pages/menu_pages/themes_page.dart';
import 'package:pomodoro_app/utils/calculator/calculator_page.dart';
import 'package:pomodoro_app/utils/widgets/tiles/menu_tile.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: const Text(
            "Menu",
            style: TextStyle(
              fontSize: 18.5,
            ),
          ),
        ),
      ),
      body: GridView.count(
        // shrinkWrap: true,
        crossAxisCount: 2,
        padding: const EdgeInsets.all(12),
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: [
          MenuTile(
            title: 'Statistics',
            imageURL: 'assets/images/statistics.png',
            page: StatPage(),
          ),
          MenuTile(
              title: 'Themes',
              imageURL: 'assets/images/theme.png',
              page: ThemePage()),
          MenuTile(
              title: 'Presets',
              imageURL: 'assets/images/preset.png',
              page: PresetPage()),
          MenuTile(
            title: 'Settings',
            imageURL: 'assets/images/settings.png',
            page: SettingsPage(),
          ),
          MenuTile(
            title: 'Calculator',
            imageURL: 'assets/images/calculator2.png',
            page: CalculatorPage(),
          )
        ],
      ),
    );
  }
}
