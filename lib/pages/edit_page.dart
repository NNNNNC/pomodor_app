import 'package:flutter/material.dart';
import 'package:pomodoro_app/utils/custom_box.dart';

class edit_page extends StatefulWidget {
  const edit_page({super.key});

  @override
  State<edit_page> createState() => _edit_pageState();
}

class _edit_pageState extends State<edit_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.check,
                  size: 30,
                )),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30, left: 10, bottom: 5),
            child: Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Text(
                  'TIMER',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: custom_box(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Focus Duration:',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text('_____' + ' Minutes',
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              )),
          Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, top: 3.5),
              child: custom_box(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Long Break Length:',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text('_____' + ' Minutes',
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              )),
          Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, top: 3.5),
              child: custom_box(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Short Break Length:',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text('_____' + ' Minutes',
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              )),
          Padding(
            padding: EdgeInsets.only(top: 45, left: 10, bottom: 5),
            child: Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Text(
                  'SOUND',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, top: 3.5),
              child: custom_box(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'White Noise:',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text('_____',
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              )),
              Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, top: 3.5),
              child: custom_box(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ringtone:',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text('_____',
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
