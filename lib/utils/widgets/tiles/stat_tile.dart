import 'package:flutter/material.dart';

class StatTile extends StatelessWidget {
  final String timeSpent;
  final String subText;

  const StatTile({
    super.key,
    required this.timeSpent,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {},
      child: Ink(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              blurRadius: 1.5,
              spreadRadius: 0,
              offset: const Offset(0, 2),
              color: Colors.black.withOpacity(0.25),
            ),
          ],
        ),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    timeSpent,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 50,
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    'mins',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w200,
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Text(
                  subText,
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
