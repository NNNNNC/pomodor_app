import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 6.0),
            child: const Text(
              "Settings",
              style: TextStyle(
                fontSize: 18.5,
              ),
            ),
          ),
        ),
        body: Column());
  }
}
