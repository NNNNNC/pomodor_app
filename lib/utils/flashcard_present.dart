import 'package:carousel_slider/carousel_slider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_app/utils/flashcard_box.dart';

class FlashcardPresent extends StatefulWidget {
  const FlashcardPresent({super.key});

  @override
  State<FlashcardPresent> createState() => FlashcardPresentState();
}

class FlashcardPresentState extends State<FlashcardPresent> {
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
        controller.nextPage(duration: const Duration(milliseconds: 400));
      });
    }
  }

  void previous() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex = (_currentIndex - 1);
        controller.previousPage(duration: const Duration(milliseconds: 400));
      });
    }
  }

  TextEditingController _cardSetNameController =
      TextEditingController(text: 'Card Set Name');
  bool _isEnable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 40,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 35, right: 35),
              child: Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isEnable = true;
                    });
                  },
                  child: TextField(
                    cursorColor: const Color.fromRGBO(192, 192, 192, 1),
                    controller: _cardSetNameController,
                    enabled: _isEnable,
                    style: Theme.of(context).textTheme.titleLarge,
                    decoration: const InputDecoration(
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
            ),
            const SizedBox(
              height: 30.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Flashcard 0${_currentIndex + 1}',
                    style: const TextStyle(fontSize: 19),
                  ),
                  Icon(
                    Icons.shuffle,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48.0,
                    vertical: 18.0,
                  ),
                  child: Expanded(
                    child: Center(
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
                                ),
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                            enableInfiniteScroll: false,
                            height: 360,
                            viewportFraction: 1,
                            initialPage: 0,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentIndex = index;
                              });
                            }),
                      ),
                    ),
                  ),
                ),
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
                              color: Theme.of(context).colorScheme.secondary)),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 5,
                      width: 280,
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
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 55,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${_currentIndex + 1}' + '/' + texts.length.toString(),
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff3a3939)),
                onPressed: () {
                  _controller.toggleCard();
                },
                child: SizedBox(
                  width: 258,
                  height: 53,
                  child: Center(
                    child: Text(
                      'FLIP CARD',
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 36.0),
              child: Center(
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey[400],
                    size: 36,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
