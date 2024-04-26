import 'package:carousel_slider/carousel_slider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_app/main.dart';
import 'package:pomodoro_app/models/flashcardModel.dart';
import 'package:pomodoro_app/utils/flashcard_box.dart';

class flashcard_edit extends StatefulWidget {
  final int flashCardIndex;
  final Function(int, String) onUpdate;

  const flashcard_edit(
      {super.key, required this.flashCardIndex, required this.onUpdate});

  @override
  State<flashcard_edit> createState() => _flashcard_editState();
}

class _flashcard_editState extends State<flashcard_edit> {
  final controller = CarouselController();

  FlipCardController _controller = FlipCardController();

  int _currentIndex = 0;

  void next() {
    if (_currentIndex < flashcard.cards.length - 1) {
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

  late TextEditingController _cardSetNameController;
  late Flashcard flashcard;
  bool _isEnable = false;

  @override
  void initState() {
    super.initState();
    flashcard = flashcardBox.getAt(widget.flashCardIndex)!;
    _cardSetNameController = TextEditingController(text: flashcard.cardSetName);
  }

  @override
  void dispose() {
    _cardSetNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: 'flashcard edit',
          onPressed: () {
            setState(() {
              // Add a new question and answer flashcard to the list
              Map<String, String> newCard = {
                'question': 'New question',
                'answer': 'New answer',
              };
              flashcard.cards.add(newCard);
              widget.onUpdate(flashcard.cards.length, flashcard.cardSetName);
            });
          },
          child: const Icon(
            Icons.add,
            size: 45,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: 50,
            bottom: 0,
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
                          cursorColor: const Color.fromRGBO(192, 192, 192, 1),
                          controller: _cardSetNameController,
                          enabled: _isEnable,
                          style: Theme.of(context).textTheme.titleLarge,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            flashcard.cardSetName = value;
                            widget.onUpdate(
                                flashcard.cards.length, flashcard.cardSetName);
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
                          flashcard.save();
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
                          itemCount: flashcard.cards.length,
                          itemBuilder: (context, index, realIndex) {
                            final card = flashcard.cards[index];
                            final question = card['question'] ?? '';
                            final answer = card['answer'] ?? '';
                            return FlipCard(
                                controller: _controller,
                                direction: FlipDirection.HORIZONTAL,
                                front: FlashcardBox(
                                  cardContent: question,
                                  flipButton: TextButton(
                                      onPressed: () {
                                        _controller.toggleCard();
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
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
                                  onUpdateContent: (editQuestion) {
                                    setState(() {
                                      flashcard.cards[index]['question'] =
                                          editQuestion;
                                    });
                                  },
                                ),
                                back: FlashcardBox(
                                  cardContent: answer,
                                  flipButton: TextButton(
                                      onPressed: () {
                                        _controller.toggleCard();
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
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
                                  onUpdateContent: (editAnswer) {
                                    setState(() {
                                      flashcard.cards[index]['answer'] =
                                          editAnswer;
                                    });
                                  },
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
                padding: const EdgeInsets.only(right: 30, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          if (flashcard.cards.length > 1) {
                            setState(() {
                              flashcard.cards.removeLast();
                              _currentIndex =
                                  (_currentIndex >= flashcard.cards.length)
                                      ? flashcard.cards.length - 1
                                      : _currentIndex;
                              widget.onUpdate(flashcard.cards.length,
                                  flashcard.cardSetName);
                            });
                          }
                        },
                        icon: Icon(
                          size: 30,
                          Icons.close,
                          color: Theme.of(context).colorScheme.secondary,
                        )),
                    SizedBox(
                      height: 5,
                      width: 280,
                      child: LinearProgressIndicator(
                        borderRadius: BorderRadius.circular(10),
                        value: (_currentIndex + 1) / flashcard.cards.length,
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
                      '${_currentIndex + 1}' +
                          '/' +
                          flashcard.cards.length.toString(),
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
