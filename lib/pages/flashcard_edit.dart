import 'package:carousel_slider/carousel_slider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_app/utils/flashcard_box.dart';

class flashcard_edit extends StatefulWidget {
  const flashcard_edit({super.key});

  @override
  State<flashcard_edit> createState() => _flashcard_editState();
}

class _flashcard_editState extends State<flashcard_edit> {
  final controller = CarouselController();
  FlipCardController _controller = FlipCardController();
  List<String> texts = [
    'NICO',
    'ANGELO',
    'CELIS',
    'VILLONO',
    'NICO',
    'ANGELO',
    'CELIS',
    'VILLONO',
    'NICO',
    'ANGELO',
    'CELIS',
    'VILLONO',
    'NICO',
    'ANGELO',
    'CELIS',
    'VILLONO',
  ];
  int _currentIndex = 0;
  int count(_currentIndex) {
    return _currentIndex + 1;
  }

  void next() {
    controller.nextPage(duration: Duration(milliseconds: 400));
  }

  void previous() {
    controller.previousPage(duration: Duration(milliseconds: 400));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: 'flashcard edit',
          onPressed: () {
            setState(() {
              texts.add('New Flashcard'); // Add a new flashcard to the list
            });
          },
          child: Icon(
            Icons.add,
            size: 45,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            top: 90,
            bottom: 50,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 35, right: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Card Set Name',
                        style: Theme.of(context).textTheme.titleLarge),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.check,
                          size: 30,
                          color: Theme.of(context).colorScheme.secondary,
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Stack(
                children: [
                  Center(
                      child: CarouselSlider.builder(
                          carouselController: controller,
                          itemCount: texts.length,
                          itemBuilder: (context, index, realIndex) {
                            final text = texts[index];
                            return FlipCard(
                                controller: _controller,
                                direction: FlipDirection.HORIZONTAL,
                                front: flashcard_box(
                                  card_content: text,
                                  flip_button: 'Check answer',
                                ),
                                back: flashcard_box(
                                  card_content: 'Jake Sacay',
                                  flip_button: 'Check question',
                                ));
                          },
                          options: CarouselOptions(
                              height: 400,
                              viewportFraction: 1,
                              enableInfiniteScroll: false,
                              initialPage: 0,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              }))),
                  Positioned(
                      left: 5,
                      right: 5,
                      top: 0,
                      bottom: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: previous,
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Theme.of(context).colorScheme.secondary,
                              )),
                          IconButton(
                              onPressed: next,
                              icon: Icon(Icons.arrow_forward_ios,
                                  size: 25,
                                  color:
                                      Theme.of(context).colorScheme.secondary)),
                        ],
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30, left: 20),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            texts.removeAt(_currentIndex);
                          });
                        },
                        icon: Icon(
                          Icons.close,
                          color: Theme.of(context).colorScheme.secondary,
                        )),
                    SizedBox(
                      height: 5,
                      width: 300,
                      child: LinearProgressIndicator(
                        borderRadius: BorderRadius.circular(10),
                        value: (_currentIndex + 1) / texts.length,
                        minHeight: 5,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 68,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      count(_currentIndex).toString() +
                          '/' +
                          texts.length.toString(),
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
