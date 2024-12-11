import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pomodoro_app/utils/widgets/tiles/stat_tile.dart';

class StatPage extends StatelessWidget {
  const StatPage({super.key});

  double getDailyProgress(num todayFocus) {
    final studyBox = Hive.box('studyTarget');
    int targetTimeInSeconds =
        (studyBox.get(1) ?? 3) * 60 * 60; // 3 hours is default
    return todayFocus / targetTimeInSeconds;
  }

  num getTotalFocusTime(DateTimeRange range) {
    final sessionBox = Hive.box('focusSessions');
    num totalFocusTime = 0;

    for (var session in sessionBox.values) {
      DateTime sessionDate = DateTime.parse(session['date']);
      if (sessionDate.isAfter(range.start) && sessionDate.isBefore(range.end)) {
        totalFocusTime += session['duration'];
      }
    }

    return totalFocusTime; // in seconds
  }

  num getTotalFocusTimeAll() {
    final sessionBox = Hive.box('focusSessions');
    num totalFocusTime = 0;

    for (var session in sessionBox.values) {
      totalFocusTime += session['duration'];
    }

    return totalFocusTime; // in seconds
  }

  num getTodayFocusTime() {
    final now = DateTime.now();
    DateTimeRange todayRange = DateTimeRange(
      start: DateTime(now.year, now.month, now.day),
      end: DateTime(now.year, now.month, now.day + 1),
    );
    return getTotalFocusTime(todayRange);
  }

  num getWeeklyFocusTime() {
    final now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTimeRange weekRange = DateTimeRange(
      start: startOfWeek,
      end: now.add(Duration(days: 1)),
    );
    return getTotalFocusTime(weekRange);
  }

  num getMonthlyFocusTime() {
    final now = DateTime.now();
    DateTimeRange monthRange = DateTimeRange(
      start: DateTime(now.year, now.month, 1),
      end: DateTime(now.year, now.month + 1, 1),
    );
    return getTotalFocusTime(monthRange);
  }

  void incrementDailyGoalCounter() {
    final studyBox = Hive.box('studyTarget');
    int dailyGoalCount = studyBox.get('dailyGoalCount') ?? 0;
    studyBox.put('dailyGoalCount', dailyGoalCount + 1);
  }

  @override
  Widget build(BuildContext context) {
    final studyBox = Hive.box('studyTarget');
    int targetTimeInSeconds = (studyBox.get(1) ?? 3) * 60 * 60;

    final num todayFocus = getTodayFocusTime();
    final num weeklyFocus = getWeeklyFocusTime();
    final num monthlyFocus = getMonthlyFocusTime();

    final double dailyProgress = getDailyProgress(todayFocus);

    final String todayFocusString =
        Duration(seconds: todayFocus.toInt()).inMinutes.toString();

    final String weeklyFocusString =
        Duration(seconds: weeklyFocus.toInt()).inMinutes.toString();

    final String monthlyFocusString =
        Duration(seconds: monthlyFocus.toInt()).inMinutes.toString();

    final String overallFocusString =
        Duration(seconds: getTotalFocusTimeAll().toInt()).inMinutes.toString();

    final int remainingTimeInSeconds = targetTimeInSeconds - todayFocus.toInt();

    String remainingTimeString;

    if (dailyProgress >= 1.0) {
      incrementDailyGoalCounter();
      remainingTimeString = "You’ve reached your daily goal!";
    } else {
      if (remainingTimeInSeconds == targetTimeInSeconds) {
        remainingTimeString = "You need to study!";
      } else if (remainingTimeInSeconds >= 3600) {
        int hoursLeft = (remainingTimeInSeconds / 3600).floor();
        remainingTimeString =
            "$hoursLeft more hour${hoursLeft > 1 ? 's' : ''} to go!";
      } else {
        int minutesLeft = remainingTimeInSeconds ~/ 60;
        remainingTimeString =
            "$minutesLeft more minute${minutesLeft > 1 ? 's' : ''} to go!";
      }
    }

    final int dailyGoalCount = studyBox.get('dailyGoalCount') ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: const Text(
            "Statistics",
            style: TextStyle(
              fontSize: 18.5,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Wrap(
              children: [
                GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(12),
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    StatTile(
                        timeSpent: todayFocusString, subText: 'Studied today'),
                    StatTile(
                        timeSpent: weeklyFocusString,
                        subText: 'Studied this week'),
                    StatTile(
                        timeSpent: monthlyFocusString,
                        subText: 'Studied this month'),
                    StatTile(
                        timeSpent: overallFocusString,
                        subText: 'Total studied'),
                  ],
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 18, top: 16),
              child: Row(
                children: [
                  Text(
                    'Daily Progress',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  width: MediaQuery.of(context).size.width * 0.92,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        spreadRadius: 1,
                        offset: const Offset(0, 2),
                        color: Colors.black.withOpacity(0.25),
                      ),
                    ],
                  ),
                  child: CircularPercentIndicator(
                    radius: 100.0,
                    lineWidth: 16.0,
                    animation: true,
                    percent: dailyProgress > 1.0 ? 1.0 : dailyProgress,
                    center: Text(
                      "${(dailyProgress * 100).toStringAsFixed(1)}%",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32.0,
                          color: Colors.lightBlueAccent),
                    ),
                    footer: Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: Text(
                        remainingTimeString,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                    circularStrokeCap: CircularStrokeCap.square,
                    progressColor:
                        dailyProgress >= 1.0 ? Colors.green : Colors.blue,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
              child: Text(
                "Daily Goals Reached: $dailyGoalCount",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
