import 'package:flutter/material.dart';
import 'package:pomodoro_app/pages/edit_page.dart';
import 'package:pomodoro_app/utils/custom_box.dart';

class profile_tile extends StatelessWidget {
  final String profile_name;
  final int focus_duration;
  final int long_break;
  final int short_break;
  final String white_noise;
  final String ringtone;

  const profile_tile({
    super.key, 
    required this.profile_name,
    required this.focus_duration, 
    required this.long_break, 
    required this.short_break, 
    required this.white_noise, 
    required this.ringtone,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12,right: 12, top: 12, bottom: 5),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (Context) => edit_page()));
        },
        child: custom_box(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(profile_name, style: Theme.of(context).textTheme.titleLarge),
                  PopupMenuButton(
                    color: Color.fromRGBO(48, 48, 48, 0.9),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text('Set Default', style: TextStyle(fontWeight: FontWeight.bold),
                         )
                        ),
                      PopupMenuItem(
                        child: Text('Delete', style: TextStyle(fontWeight: FontWeight.bold)
                        )
                        )
                    ])
                  ],
                ),
                SizedBox(height: 10,),
              Row(
                children: [
                  Text('Focus Duration :', style: Theme.of(context).textTheme.titleMedium),
                  Padding(
                    padding: const EdgeInsets.only(left: 60),
                    child: Text(focus_duration.toString()+' minutes' , style: Theme.of(context).textTheme.titleMedium),
                  ),
                  ],
              ),
              SizedBox(height: 8,),
              Row(
                children: [
                  Text('Long Break :', style: Theme.of(context).textTheme.titleMedium),
                  Padding(
                    padding: const EdgeInsets.only(left: 90),
                    child: Text(long_break.toString()+' minutes', style: Theme.of(context).textTheme.titleMedium),
                  ),
                  ],
              ),
              SizedBox(height: 8,),
              Row(
                children: [
                  Text('Short Break :', style: Theme.of(context).textTheme.titleMedium),
                  Padding(
                    padding: const EdgeInsets.only(left: 85),
                    child: Text(short_break.toString()+' minutes', style: Theme.of(context).textTheme.titleMedium),
                  ),
                  ],
              ),
              SizedBox(height: 8,),
              Row(
                children: [
                  Text('White Noise :', style: Theme.of(context).textTheme.titleMedium),
                  Padding(
                    padding: const EdgeInsets.only(left: 80),
                    child: Text(white_noise, style: Theme.of(context).textTheme.titleMedium),
                  ),
                  ],
              ),
              SizedBox(height: 8,),
              Row(
                children: [
                  Text('Ringtone :', style: Theme.of(context).textTheme.titleMedium),
                  Padding(
                    padding: const EdgeInsets.only(left: 105),
                    child: Text(ringtone, style: Theme.of(context).textTheme.titleMedium),
                  ),
                  ],
              ),
              ],
            ),
        )
      ),
    );
  }
}