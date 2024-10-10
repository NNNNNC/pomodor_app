import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pomodoro_app/providers/visibility_provider.dart';
import 'package:provider/provider.dart';

class ThemeTile extends StatefulWidget {
  final String bgURL;
  final String radioValue;
  final String themeTitle;

  const ThemeTile({
    super.key,
    required this.bgURL,
    required this.radioValue,
    required this.themeTitle,
  });

  @override
  State<ThemeTile> createState() => _ThemeTileState();
}

class _ThemeTileState extends State<ThemeTile> {
  @override
  Widget build(BuildContext context) {
    final themeBox = Hive.box('themePrefs');

    String selectedTheme = themeBox.get(1) ?? 'simple';
    return Consumer<BottomBarVisibility>(
      builder: (context, value, child) => InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          setState(() {
            selectedTheme = widget.radioValue;
            themeBox.put(1, widget.radioValue);

            if (widget.radioValue == 'simple') {
              themeBox.put(0, false);
            } else {
              themeBox.put(0, true);
            }

            value.toggleCustomTheme();

            Navigator.pop(context);
          });
        },
        child: Ink(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                blurRadius: 1.5,
                spreadRadius: 0,
                offset: const Offset(0, 2),
                color: Colors.black.withOpacity(0.25),
              ),
            ],
            image: DecorationImage(
              image: AssetImage(widget.bgURL),
              fit: BoxFit.cover,
              opacity: 0.4,
            ),
          ),
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Radio<String>(
                  activeColor: Colors.blue[800],
                  value: widget.radioValue,
                  groupValue: selectedTheme,
                  onChanged: (value) {
                    setState(() {
                      selectedTheme = value!;
                      themeBox.put(1, value);
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    widget.themeTitle,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
