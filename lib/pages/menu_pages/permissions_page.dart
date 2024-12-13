import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsPage extends StatefulWidget {
  const PermissionsPage({super.key});
  @override
  State<PermissionsPage> createState() => _PermissionsPageState();
}

class _PermissionsPageState extends State<PermissionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 6.0),
          child: Text(
            "Configure Permissions",
            style: TextStyle(fontSize: 18.5),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView(
          shrinkWrap: true,
          children: [
            collapsibleTile(
              context,
              'Ignore Battery Optimizations',
              'This permission ensures that the app can run in the background without being interrupted by your phone\'s battery-saving features. '
                  'It is essential for features like study reminders and notifications to work reliably.',
              Permission.ignoreBatteryOptimizations,
            ),
            collapsibleTile(
              context,
              'Do Not Disturb Permission',
              'This permission ensures that no notifications or interruptions disturb you during focus sessions. ',
              Permission.accessNotificationPolicy,
            ),
            collapsibleTile(
              context,
              'Notifications Permission',
              'Enabling notifications ensures that you receive the daily study reminders depending on the time that you have set.',
              Permission.notification,
            ),
            collapsibleTile(
              context,
              'Alarm and Reminder Permission',
              'This permission allows the app to set alarms and reminders accurately, ensuring that the notification is sent at the exact time that it is set.',
              Permission.scheduleExactAlarm,
            ),
            collapsibleTile(
              context,
              'Nearby Devices Permission',
              'This permission is only to detect if you are wearing wired/wireless headphones.',
              Permission.nearbyWifiDevices,
            ),
          ],
        ),
      ),
    );
  }

  Widget collapsibleTile(
      BuildContext context, String title, String desc, Permission permission) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        expandedAlignment: Alignment.topLeft,
        collapsedBackgroundColor: Theme.of(context).colorScheme.primary,
        collapsedTextColor: Theme.of(context).colorScheme.secondary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        collapsedIconColor: Theme.of(context).colorScheme.secondary,
        iconColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  desc,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor: WidgetStateColor.resolveWith(
                        (states) => Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                      ),
                    ),
                    onPressed: () async {
                      if (await permission.request().isGranted) {
                        showDialog(
                          barrierDismissible: false,
                          barrierColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            Future.delayed(const Duration(milliseconds: 700),
                                () {
                              Navigator.of(context).pop();
                            });
                            return SimpleDialog(
                              backgroundColor: Colors.black26,
                              alignment: Alignment.bottomCenter,
                              titlePadding: EdgeInsets.all(12),
                              title: Center(
                                child: Text(
                                  'Access already granted.',
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                    child: Text(
                      'Configure',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
