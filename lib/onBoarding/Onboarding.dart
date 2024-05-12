import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pomodoro_app/onBoarding/onBoarding_items.dart';
import 'package:pomodoro_app/pages/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  final controller = onBoardingItems();
  final pageController = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      bottomSheet: Container(
        color: Theme.of(context).colorScheme.background,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: isLastPage? getStarted() : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            TextButton(
              onPressed: () => pageController.jumpToPage(controller.items.length-1), 
              child: Text('Skip', style: Theme.of(context).textTheme.titleLarge,)),

            SmoothPageIndicator(
              controller: pageController,
              count: controller.items.length,
              effect: WormEffect(
                activeDotColor: Theme.of(context).colorScheme.secondary,

              ),
            ),

            TextButton(onPressed: () => pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn), child: Text('Next', style: Theme.of(context).textTheme.titleLarge,))
        
          ],
        ),
      ),

      

      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
          onPageChanged: (index) => setState(() => isLastPage = controller.items.length-1 == index),
          itemCount: controller.items.length,
          controller: pageController,
          itemBuilder: (context,index){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(
                  width: 300,
                  child: Text(controller.items[index].title, 
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary),
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
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(-15, 15), // changes position of shadow
                      ),
                    ],
                  ),
                  width: 250,
                  height: 500,
                  child: ClipRRect(
                    child: Image.asset(controller.items[index].image, fit: BoxFit.cover,),
                    borderRadius: BorderRadius.circular(18),
                  )
                  ),
              ],
            );
          }),
      ),
    );
  }

  Widget getStarted(){
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Theme.of(context).colorScheme.primary
        ),
        width: MediaQuery.of(context).size.width*.9,
        height: 55,
        child: TextButton(
          onPressed: () async{
            final pres = await SharedPreferences.getInstance();
            pres.setBool('onboarding', true);

            if(!mounted)return;
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));
          }, 
          child: Text('Get Started', style: Theme.of(context).textTheme.titleLarge,)
          ),
      );
    }

}