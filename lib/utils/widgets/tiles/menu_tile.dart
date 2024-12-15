import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MenuTile extends StatelessWidget {
  final String title;
  final String imageURL;
  final Widget? page;
  final bool? needResize;
  final bool? isCalculator;

  const MenuTile(
      {super.key,
      required this.title,
      required this.imageURL,
      this.page,
      this.needResize,
      this.isCalculator});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (page == null) {
          SystemNavigator.pop();
        } else if (isCalculator ?? false) {
          showGeneralDialog(
            barrierLabel: 'Label',
            barrierDismissible: false,
            barrierColor: Colors.black.withOpacity(0.5),
            transitionDuration: const Duration(milliseconds: 400),
            context: context,
            pageBuilder: (context, animation, secondaryAnimation) {
              return page!;
            },
            transitionBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
          );
        } else {
          Future.delayed(const Duration(milliseconds: 150), () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => page!));
          });
        }
      },
      borderRadius: BorderRadius.circular(8),
      splashColor: Theme.of(context).disabledColor,
      child: Ink(
        padding: const EdgeInsets.all(8),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(imageURL),
              width: (needResize ?? false) ? 80 : 70,
              height: (needResize ?? false) ? 80 : 70,
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
    );
  }
}
