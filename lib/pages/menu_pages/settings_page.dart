import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pomodoro_app/pages/menu_pages/permissions_page.dart';
import 'package:pomodoro_app/utils/others/notifications.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int? selectedTime;
  TimeOfDay? reminderTime;

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    final studyBox = Hive.box('studyTarget');
    selectedTime = studyBox.get(1) ?? 3;

    NotificationService().initializeNotifications();
    _initPackageInfo();

    final savedTime = studyBox.get('reminderTime');
    if (savedTime != null) {
      final parts = savedTime.split(':');
      reminderTime = TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      );
    }
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    final settingsBox = Hive.box('settings');

    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 6.0),
          child: Text(
            "Settings",
            style: TextStyle(fontSize: 18.5),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  buildSectionHeader(context, "GENERAL"),
                  buildOption(context, "Set Study Time Target", buildDropdown(),
                      true, false, false, false, true, false),
                  buildToggleOption(context, 'Enable Study Reminder',
                      'enableReminder', false, false),
                  buildOption(
                    context,
                    "Set Study Reminder",
                    buildReminderTimePicker(context),
                    false,
                    false,
                    false,
                    true,
                    false,
                    true,
                    enabled:
                        settingsBox.get('enableReminder', defaultValue: false),
                  ),
                  buildSectionHeader(context, "POMODORO"),
                  buildToggleOption(context, "Enable Skipping Breaks",
                      'enableSkip', true, false),
                  buildToggleOption(context, "Disable Long Breaks",
                      'disableLongBreak', false, false),
                  buildToggleOption(context, "Disable White Noise",
                      'disableNoise', false, false),
                  buildToggleOption(context, 'Always Time Flashcards',
                      'alwaysTimed', false, false),
                  buildToggleOption(
                      context, 'Pulsating Button', 'enablePulse', false, true),
                  buildSectionHeader(context, "OTHERS"),
                  buildToggleOption(
                      context,
                      "Enable Paper Background in Scribble",
                      'enablePaper',
                      true,
                      false),
                  buildPermission(
                      context, "Configure App Permissions", false, false),
                  buildOption(context, "Help/Feedback", buildHelpFeedback(),
                      false, false, true, false, false, false),
                  buildOption(context, "App Info", buildAppInfo(), false, false,
                      false, false, false, false),
                  buildOption(context, "Version", buildVersionInfo(), false,
                      true, false, false, false, true),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDropdown() {
    return DropdownButtonFormField2<int>(
      dropdownStyleData: DropdownStyleData(maxHeight: 250),
      decoration: InputDecoration(
        labelText: "Select Target Time",
        labelStyle: TextStyle(color: Theme.of(context).highlightColor),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).highlightColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
      ),
      value: selectedTime,
      items: List<int>.generate(24, (i) => i + 1).map((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text("$value hour${value > 1 ? 's' : ''}"),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          selectedTime = newValue;
        });
      },
    );
  }

  Widget buildHelpFeedback() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Text("Please Contact Us:"),
        SizedBox(height: 10),
        Text("studyassistant@gmail.com"),
      ],
    );
  }

  Widget buildAppInfo() {
    return const Text(
        "The app uses the Pomodoro Technique, breaking study time into focused sessions with short breaks to boost productivity. It also includes helpful tools like flashcards, an app-lock feature, and adjustable white noise to create a personalized study environment.");
  }

  Widget buildVersionInfo() {
    return Padding(
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
                  offset: const Offset(-5, 5),
                ),
              ],
            ),
            child: Image.asset(
              'assets/icons/study-launcher.png',
              height: 75,
              width: 75,
            ),
          ),
          const SizedBox(height: 20),
          Text(_packageInfo.version),
        ],
      ),
    );
  }

  Widget buildReminderTimePicker(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          tileColor: Theme.of(context).colorScheme.primary,
          title: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Daily Reminder Time",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          subtitle: Text(
            reminderTime != null
                ? DateFormat.jm().format(
                    DateTime(0, 0, 0, reminderTime!.hour, reminderTime!.minute))
                : "No time set",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.alarm,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () async {
              final TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                builder: (context, child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      colorScheme: ColorScheme.dark(
                        primary: Colors.white,
                        onSurface: Colors.white70,
                      ),
                      buttonTheme: ButtonThemeData(
                        colorScheme: ColorScheme.dark(
                          primary: Colors.white,
                        ),
                      ),
                    ),
                    child: child!,
                  );
                },
                initialTime:
                    reminderTime ?? const TimeOfDay(hour: 9, minute: 0),
              );
              if (pickedTime != null) {
                setState(() {
                  reminderTime = pickedTime;
                });

                final studyBox = Hive.box('studyTarget');
                studyBox.put(
                  'reminderTime',
                  '${pickedTime.hour}:${pickedTime.minute}',
                );

                await NotificationService()
                    .scheduleDailyNotification(pickedTime);

                Navigator.of(context).pop();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget buildPermission(
      BuildContext context, String title, bool isFirst, bool isLast) {
    return InkWell(
      borderRadius: isFirst
          ? BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            )
          : isLast
              ? BorderRadius.only(
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                )
              : null,
      onTap: () {
        Future.delayed(const Duration(milliseconds: 150), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PermissionsPage(),
            ),
          );
        });
      },
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: isFirst
              ? BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                )
              : isLast
                  ? BorderRadius.only(
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                    )
                  : null,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOption(
      BuildContext context,
      String title,
      Widget contentWidget,
      bool isStudyTimeTarget,
      bool isVersion,
      bool isHelp,
      bool isAlarm,
      bool isFirst,
      bool isLast,
      {bool enabled = true}) {
    final studyBox = Hive.box('studyTarget');
    int studyTarget = studyBox.get(1) ?? 3;

    return InkWell(
      borderRadius: isFirst
          ? BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            )
          : isLast
              ? BorderRadius.only(
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                )
              : null,
      onTap: enabled
          ? () {
              Future.delayed(const Duration(milliseconds: 150), () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      contentPadding: const EdgeInsets.all(18),
                      title: Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      content: contentWidget,
                      actions: buildDialogActions(context, isStudyTimeTarget,
                          studyBox, studyTarget, isHelp),
                    );
                  },
                );
              });
            }
          : null,
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: isFirst
              ? BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                )
              : isLast
                  ? BorderRadius.only(
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                    )
                  : null,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: enabled
                        ? Theme.of(context).textTheme.bodyMedium?.color
                        : Colors.grey),
              ),
              Row(
                children: [
                  if (isStudyTimeTarget)
                    Text(
                      '${studyTarget} Hour${(studyTarget > 1 ? 's' : '')}   ',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  if (isVersion)
                    Text(
                      _packageInfo.version + '   ',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  if (isAlarm)
                    Text(
                      (reminderTime != null)
                          ? DateFormat.jm().format(DateTime(0, 0, 0,
                                  reminderTime!.hour, reminderTime!.minute)) +
                              '   '
                          : 'Not set   ',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: enabled
                        ? Theme.of(context).colorScheme.secondary
                        : Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildToggleOption(BuildContext context, String title, String key,
      bool isFirst, bool isLast) {
    final settingsBox = Hive.box('settings');
    final studyBox = Hive.box('studyTarget');
    bool currentValue = settingsBox.get(key, defaultValue: false);

    return InkWell(
      borderRadius: isFirst
          ? BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            )
          : isLast
              ? BorderRadius.only(
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                )
              : null,
      onTap: () {
        setState(() {
          currentValue = !currentValue;
          settingsBox.put(key, currentValue);

          if (key == 'enableReminder') {
            if (currentValue) {
              final savedTime = studyBox.get('reminderTime');
              if (savedTime != null) {
                final parts = savedTime.split(':');
                final time = TimeOfDay(
                  hour: int.parse(parts[0]),
                  minute: int.parse(parts[1]),
                );
                reminderTime = time;
                NotificationService().scheduleDailyNotification(time);
              }
            } else {
              NotificationService().cancelNotification();
            }
          }
        });
      },
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: isFirst
              ? BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                )
              : isLast
                  ? BorderRadius.only(
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                    )
                  : null,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                width: 50,
                height: 30,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Switch(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: currentValue,
                      activeColor: Colors.green,
                      onChanged: (bool value) {
                        setState(() {
                          currentValue = value;
                          settingsBox.put(key, currentValue);

                          if (key == 'enableReminder') {
                            if (currentValue) {
                              final savedTime = studyBox.get('reminderTime');
                              if (savedTime != null) {
                                final parts = savedTime.split(':');
                                final time = TimeOfDay(
                                  hour: int.parse(parts[0]),
                                  minute: int.parse(parts[1]),
                                );
                                reminderTime = time;
                                NotificationService()
                                    .scheduleDailyNotification(time);
                              }
                            } else {
                              NotificationService().cancelNotification();
                            }
                          }
                        });
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildDialogActions(BuildContext context, bool isStudyTimeTarget,
      Box studyBox, int studyTarget, bool isHelp) {
    return [
      TextButton(
        onPressed: () {
          setState(() {
            selectedTime = studyTarget;
            Navigator.of(context).pop();
          });
        },
        child: Text(
          isStudyTimeTarget
              ? 'Cancel'
              : isHelp
                  ? ''
                  : 'Back',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      if (isStudyTimeTarget)
        TextButton(
          onPressed: () {
            if (selectedTime != null && selectedTime != studyTarget) {
              setState(() {
                studyBox.put(1, selectedTime);
              });
            }
            Navigator.of(context).pop();
          },
          child: Text(
            'Save',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      if (isHelp)
        IconButton(
          onPressed: () async {
            await Clipboard.setData(
                ClipboardData(text: "studyassistant@gmail.com"));
          },
          icon: Icon(
            Icons.copy,
            color: Theme.of(context).colorScheme.secondary,
          ),
        )
    ];
  }

  Widget buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 15, bottom: 5),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
      ),
    );
  }
}
