import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int? selectedTime;

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
        body: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 40),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.primary,
            ),
            height: 270,
            width: 400,
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 50),
            child: ListView(
              children: [
                buildOption(
                    context,
                    "Daily Study Time Target",
                    DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        labelText: "Select Target Time",
                        border: OutlineInputBorder(),
                      ),
                      value: selectedTime, // Change mo lang value
                      items: [2, 3, 4, 5].map((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text("$value hours"),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedTime = newValue;
                        });
                      },
                    ),
                    true),
                Divider(
                  height: 15,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                buildOption(
                    context,
                    "Help/Feedback",
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Please Contact Us:"),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Team143@gmail.com")
                      ],
                    ),
                    false),
                buildOption(
                    context,
                    "App Info",
                    Text(
                        "The app uses the Pomodoro Technique, breaking study time into focused sessions with short breaks to boost productivity. It also includes helpful tools like flashcards, an app-lock feature, and adjustable white noise to create a personalized study environment."),
                    false),
                buildOption(
                    context,
                    "Version",
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: Offset(-5, 5),
                                ),
                              ],
                            ),
                            child: Image.asset(
                              'assets/icons/study-launcher.png',
                              height: 75,
                              width: 75,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text("1.5.5")
                        ],
                      ),
                    ),
                    false),
              ],
            ),
          ),
        ));
  }

  GestureDetector buildOption(BuildContext context, String title,
      Widget ContentWidget, bool isStudyTimeTarget) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                content: ContentWidget,
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (isStudyTimeTarget)
                        TextButton(
                          onPressed: () {
                            // Ano mangyayare???
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Save',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ],
                  )
                ],
              );
            });
      },
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).colorScheme.tertiary,
              )
            ],
          )),
    );
  }
}
