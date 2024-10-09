import 'package:flutter/material.dart';

class MenuTile extends StatelessWidget {
  final String title;
  final String imageURL;

  const MenuTile({
    super.key,
    required this.title,
    required this.imageURL,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {},
      child: Ink(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8),
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
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(imageURL),
                width: 60,
                height: 60,
                color: null,
              ),
              SizedBox(height: 17),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              )
            ],
          ),
        ),
      ),
    );
  }
}
