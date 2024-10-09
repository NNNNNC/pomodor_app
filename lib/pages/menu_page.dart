import 'package:flutter/material.dart';
import 'package:pomodoro_app/utils/menu_tile.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
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
          ),
          MenuTile(
            title: 'Themes',
            imageURL: 'assets/images/theme.png',
          ),
          MenuTile(
            title: 'Presets',
            imageURL: 'assets/images/preset.png',
          ),
          MenuTile(
            title: 'Settings',
            imageURL: 'assets/images/settings.png',
          )
        ],
      ),
    );
  }
}
