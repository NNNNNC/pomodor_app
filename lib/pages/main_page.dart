import 'package:flutter/material.dart';
import 'package:pomodoro_app/pages/flashcard_page.dart';
import 'package:pomodoro_app/pages/pomodoro_page.dart';
import 'package:pomodoro_app/pages/profile_page.dart';
import 'package:pomodoro_app/pages/topic_page.dart';



class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {

  int currentIndex = 0;
  final screens = [
    pomodoro_page(),
    flashcard_page(),
    topic_page(),
    profile_page(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: IndexedStack(
          index: currentIndex,
          children: screens,
          ),
        
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) => setState(() => currentIndex = value),
          items: [
          BottomNavigationBarItem(
            icon: Container(
              height: 30,
              child: Image.asset(
                'icons/pie-chart.png',
                color: Theme.of(context).colorScheme.secondary,),
                ),
            label: 'Pomodoro',
          ),
          BottomNavigationBarItem(
            icon: Container(height: 30,child: Image.asset('icons/document.png', color: Theme.of(context).colorScheme.secondary,),),
            label: 'Flash Card'
          ),
          BottomNavigationBarItem(
            icon: Container(height: 30,child: Image.asset('icons/bill.png', color: Theme.of(context).colorScheme.secondary,),),
            label: 'Topics'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined, color: Theme.of(context).colorScheme.secondary, size: 35,),
            label: 'Profile'
          )
        ],
        ),
      );
  }
}