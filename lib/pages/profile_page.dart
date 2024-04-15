import 'package:flutter/material.dart';
import 'package:pomodoro_app/utils/profile_tile.dart';

class profile_page extends StatefulWidget {
  const profile_page({super.key});

  @override
  State<profile_page> createState() => _profile_pageState();
}

class _profile_pageState extends State<profile_page> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Profile"),
        ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add, size: 45,),
      ),

      body: ListView( //.builder(
        // itemBuilder:(context,index){
          //return 
          children: [
            profile_tile(
            profile_name: 'My Profile Nics',
            focus_duration: 30, 
            long_break: 25, 
            short_break: 15, 
            white_noise: 'rain', 
            ringtone: 'disney',)
          ]
          
        // },
      ),

      
    );
  }
}