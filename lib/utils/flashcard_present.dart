import 'package:carousel_slider/carousel_slider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_app/main.dart';
import 'package:pomodoro_app/models/flashcardModel.dart';
import 'package:pomodoro_app/utils/flashcard_box.dart';

class FlashcardPresent extends StatefulWidget {
  final int? topicKey;

  const FlashcardPresent({
    super.key,
    required this.topicKey,
  });

  @override
  State<FlashcardPresent> createState() => FlashcardPresentState();
}

class FlashcardPresentState extends State<FlashcardPresent> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  final FlipCardController _flipCardController = FlipCardController();
  int _currentIndex = 0;

  Key _flipCardKey = UniqueKey();

  Flashcard? flashCard;
  List<Map<String, String>> cardList = [];

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();

    int? cardKey = topicBox.get(widget.topicKey)?.cardSet;
    if (cardKey != null) {
      setState(() {
        flashCard = flashcardBox.get(cardKey);
        cardList = flashCard?.cards ?? [];
        cardList.shuffle();
      });
    }
  }

  void updateKey() {
    setState(() {
      _flipCardKey = UniqueKey();
    });
  }

  void next() {
    if (_currentIndex < cardList.length - 1) {
      setState(() {
        _currentIndex++;
        _carouselController.nextPage(
          duration: const Duration(milliseconds: 400),
        );
      });
    }
  }

  void previous() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _carouselController.previousPage(
          duration: const Duration(milliseconds: 400),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Flashcard Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Text(
                flashCard?.cardSetName ?? '',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize:
                          MediaQuery.of(context).size.width > 600 ? 20 : 16,
                    ),
              ),
            ),
            // Flashcard Details and Shuffle Button
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Flashcard ${_currentIndex + 1}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        cardList.shuffle();
                        updateKey();
                      });
                    },
                    icon: Icon(
                      Icons.shuffle,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
            // Flashcard Carousel
            Column(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48.0,
                        vertical: 18.0,
                      ),
                      child: Center(
                        child: CarouselSlider.builder(
                          carouselController: _carouselController,
                          itemCount: cardList.length,
                          itemBuilder: (context, index, realIndex) {
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: FlipCard(
                                key: _flipCardKey,
                                controller: _flipCardController,
                                direction: FlipDirection.HORIZONTAL,
                                front: FlashcardBox(
                                  isQuestion: true,
                                  cardContent: cardList[index]['Question'],
                                  flipButton: _buildFlipButton(),
                                ),
                                back: FlashcardBox(
                                  cardContent: cardList[index]['Answer'],
                                  flipButton: _buildFlipButton(),
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            enableInfiniteScroll: false,
                            height: MediaQuery.of(context).size.height * 0.45,
                            viewportFraction: 1,
                            initialPage: 0,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
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
                            ),
                          ),
                          IconButton(
                            onPressed: next,
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              size: 25,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Progress Bar
                _buildProgressBar(),
                // Card Counter
                _buildCardCounter(),
                // Flip Card Button
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
                    ),
                    onPressed: () {
                      _flipCardController.toggleCard();
                    },
                    child: SizedBox(
                      width: 258,
                      height: 53,
                      child: Center(
                        child: Text(
                          'FLIP CARD',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Close Button
            Padding(
              padding: const EdgeInsets.only(top: 36.0),
              child: Center(
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey[400],
                    size: 28,
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

  TextButton _buildFlipButton() {
    return TextButton(
      onPressed: () {
        _flipCardController.toggleCard();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Center(
        child: SizedBox(
          height: 5,
          width: 300,
          child: LinearProgressIndicator(
            borderRadius: BorderRadius.circular(10),
            value: (_currentIndex + 1) / cardList.length,
            minHeight: 5,
            backgroundColor: Theme.of(context).colorScheme.primary,
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardCounter() {
    return Padding(
      padding: const EdgeInsets.only(left: 55),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '${_currentIndex + 1}/${cardList.length}',
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
