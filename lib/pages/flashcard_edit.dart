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

  void next() {
    if (_currentIndex < texts.length - 1) {
      setState(() {
        _currentIndex = (_currentIndex + 1);
        controller.nextPage(duration: Duration(milliseconds: 400));
      });
    }
  }

  void previous() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex = (_currentIndex - 1);
        controller.previousPage(duration: Duration(milliseconds: 400));
      });
    }
  }

  TextEditingController _cardSetNameController =
      TextEditingController(text: 'Card Set Name');
  bool _isEnable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: 'flashcard edit',
          onPressed: () {
            setState(() {
              texts.add(
                  'New Flashcard'); // Add a new question flashcard to the list
              // someting.add('')
            });
          },
          child: Icon(
            Icons.add,
            size: 45,
          ),
        ),
        body: SingleChildScrollView(
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
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isEnable = true;
                          });
                        },
                        child: TextField(
                          cursorColor: Color.fromRGBO(192, 192, 192, 1),
                          controller: _cardSetNameController,
                          enabled: _isEnable,
                          style: Theme.of(context).textTheme.titleLarge,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            _cardSetNameController.text = value;
                          },
                          onSubmitted: (value) {
                            setState(() {
                              _isEnable = false;
                            });
                          },
                        ),
                      ),
                    ),
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
                                front: FlashcardBox(
                                  cardContent: text,
                                  flipButton: TextButton(
                                      onPressed: () {
                                         _controller.toggleCard();
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Check Answer ',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                            size: 20,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        ],
                                      )),
                                ),
                                back: FlashcardBox(
                                  cardContent: 'Jake Sacay',
                                  flipButton: TextButton(
                                      onPressed: () {
                                         _controller.toggleCard();
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Check Answer ',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                            size: 20,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        ],
                                      )),
                                ));
                          },
                          options: CarouselOptions(
                              enableInfiniteScroll: false,
                              height: 400,
                              viewportFraction: 1,
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
                          if (texts.length > 1) {
                            setState(() {
                              texts.removeLast();
                              _currentIndex = (_currentIndex >= texts.length)
                                  ? texts.length - 1
                                  : _currentIndex;
                            });
                          }
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
                      '${_currentIndex + 1}' + '/' + texts.length.toString(),
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