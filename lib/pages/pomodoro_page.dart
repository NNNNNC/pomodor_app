import 'package:flutter/material.dart';
import 'package:pomodoro_app/utils/topic_dialog.dart';
// import 'package:flutter/widgets.dart';

class PomodoroPage extends StatefulWidget {
  const PomodoroPage({super.key});

  @override
  State<PomodoroPage> createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pomodoro"),
      ),

      // Select topic and headphones
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  /*onPressed: () => showMenu(
                    context: context,
                    position:
                        const RelativeRect.fromLTRB(30.0, 150.0, 100.0, 150.0),
                    items: const [
                      PopupMenuItem(
                        child: Text('Topic 1'),
                      ),
                      PopupMenuItem(
                        child: Text('Topic 2'),
                      ),
                      PopupMenuItem(
                        child: Text('Topic 3'),
                      ),
                      PopupMenuItem(
                        child: Text('Topic 4'),
                      ),
                    ],
                  ),*/
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) {
                      return const TopicDialog();
                    },
                  ),
                  child: Text(
                    'SELECT TOPIC',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => showMenu(
                    context: context,
                    position:
                        const RelativeRect.fromLTRB(270.0, 140.0, 300.0, 150.0),
                    items: const [
                      PopupMenuItem(
                        child: Text('No Sound'),
                      ),
                      PopupMenuItem(
                        child: Text('Rain'),
                      ),
                      PopupMenuItem(
                        child: Text('TV Static'),
                      ),
                      PopupMenuItem(
                        child: Text('Fan'),
                      ),
                    ],
                  ),
                  icon: Icon(
                    Icons.headphones,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 36,
          ),

          // states
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Focus state
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(77),
                      bottomLeft: Radius.circular(77),
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1.5,
                        spreadRadius: 0,
                        offset: const Offset(-4, 4),
                        color: Colors.black.withOpacity(0.25),
                      ),
                    ],
                  ),
                  height: 32,
                  width: 71,
                  child: const Center(
                    child: Text(
                      'Focus',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Long Break State
                Container(
                  margin: const EdgeInsets.only(left: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1.5,
                        spreadRadius: 0,
                        offset: const Offset(0, 4),
                        color: Colors.black.withOpacity(0.25),
                      ),
                    ],
                  ),
                  height: 32,
                  width: 90,
                  child: const Center(
                    child: Text(
                      'Long Break',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Short break state
                Container(
                  margin: const EdgeInsets.only(left: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      topRight: Radius.circular(77),
                      bottomRight: Radius.circular(77),
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1.5,
                        spreadRadius: 0,
                        offset: const Offset(4, 4),
                        color: Colors.black.withOpacity(0.25),
                      ),
                    ],
                  ),
                  height: 32,
                  width: 71,
                  child: const Center(
                    child: Text(
                      'Break',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 72,
          ),

          // Focus Button
          Container(
            width: 251,
            height: 251,
            decoration: BoxDecoration(
              color: const Color(0xff3a3939),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 1.5,
                  spreadRadius: 7,
                  offset: Offset.zero,
                  color: Colors.black.withOpacity(0.25),
                )
              ],
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'FOCUS',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Click here to start pomodoro',
                    style: TextStyle(
                      color: Color(0xffc0c0c0),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
