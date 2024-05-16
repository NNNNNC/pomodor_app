import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pomodoro_app/user_manual/profileManual_items.dart';




class profileManualDisplay extends StatefulWidget {


  const profileManualDisplay({super.key});

  @override
  State<profileManualDisplay> createState() => _profileManualDisplayState();
}

class _profileManualDisplayState extends State<profileManualDisplay> {
  final controller = profileManualItems();
  final pageController = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Theme.of(context).colorScheme.background,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: isLastPage
            ? getStarted()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () => pageController
                          .jumpToPage(controller.items.length - 1),
                      child: Text(
                        'Skip',
                        style: Theme.of(context).textTheme.titleMedium,
                      )),

                  TextButton(
                      onPressed: () => pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn),
                      child: Text(
                        'Next',
                        style: Theme.of(context).textTheme.titleMedium,
                      ))
                ],
              ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        child: PageView.builder(
            onPageChanged: (index) => setState(
                () => isLastPage = controller.items.length - 1 == index),
            itemCount: controller.items.length,
            controller: pageController,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      controller.items[index].title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
                          blurRadius: 2,
                          spreadRadius: 3,
                          offset: Offset(0, 4), // changes position of shadow
                        ),
                      ],
                    ),
                    width: MediaQuery.of(context).size.width * 0.65,
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: ClipRRect(
                      child: Image.asset(
                        controller.items[index].image,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  SizedBox(),
                ],
              );
            }),
      ),
    );
  }

  Widget getStarted() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Theme.of(context).colorScheme.primary),
      width: MediaQuery.of(context).size.width * .9,
      height: 55,
      child: TextButton(
          onPressed: () {
              Navigator.pop(context);
          },
          child: Text(
            'Get Started',
            style: Theme.of(context).textTheme.titleMedium,
          )),
    );
  }
}
