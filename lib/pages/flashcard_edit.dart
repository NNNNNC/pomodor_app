import 'package:carousel_slider/carousel_slider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pomodoro_app/main.dart';
import 'package:pomodoro_app/models/flashcardModel.dart';
import 'package:pomodoro_app/utils/add_tile_dialog.dart';
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
  late TextEditingController _questionController;
  late TextEditingController _answerController;

  FlipCardController _controller = FlipCardController();

  int _currentIndex = 0;

  List<Map<String, String>> _undoStack = [];

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

  void _undo() {
    if (_undoStack.isNotEmpty) {
      setState(() {
        // Retrieve the last deleted flashcard
        Map<String, String> deletedCard = _undoStack.removeLast();
        // Add the deleted flashcard back to the list
        flashcard.cards.add(deletedCard);
        // Update the UI
        widget.onUpdate(flashcard.cards.length, flashcard.cardSetName);
      });
    }
  }

  void _createFlashcard(String question, String answer) {
    setState(() {
      // Add a new question and answer flashcard to the list
      Map<String, String> newCard = {
        'Question': question,
        'Answer': answer,
      };
      flashcard.cards.add(newCard);
      widget.onUpdate(flashcard.cards.length, flashcard.cardSetName);
    });
    Navigator.pop(context);
    _questionController.clear();
    _answerController.clear();
  }

  void _deleteFlashcard() {
    if (flashcard.cards.length > 1) {
      setState(() {
        Map<String, String> deletedCard = flashcard.cards.removeLast();
        _undoStack.add(deletedCard);
        _currentIndex = (_currentIndex >= flashcard.cards.length)
            ? flashcard.cards.length - 1
            : _currentIndex;
        widget.onUpdate(flashcard.cards.length, flashcard.cardSetName);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Flashcard deleted'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: _undo,
          ),
        ),
      );
    }
  }

  late Flashcard flashcard;
  late TextEditingController _nameController;

  @override
  void initState() {
    flashcard = flashcardBox.getAt(widget.flashCardIndex)!;
    _nameController = TextEditingController(text: flashcard.cardSetName);
    _questionController = TextEditingController();
    _answerController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _questionController.dispose();
    _answerController.dispose();
    _undoStack.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: SizedBox(
          height: 50,
          width: 50,
          child: FloatingActionButton(
            heroTag: 'flashcard edit',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return add_tile_dialog(
                    controller: _questionController,
                    AnswerController: _answerController,
                    onPressed: () => _createFlashcard(
                      _questionController.text,
                      _answerController.text,
                    ),
                    isFlashcardQuestion: true,
                  );
                },
              );
            },
            child: const Icon(
              Icons.add,
              size: 45,
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 35, right: 35, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        cursorColor: Colors.white,
                        controller: _nameController,
                        style: Theme.of(context).textTheme.titleLarge,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          flashcard.cardSetName = _nameController.text;
                          flashcard.save();
                          widget.onUpdate(
                              flashcard.cards.length, flashcard.cardSetName);
                          flashcard.save();
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.check,
                          size: 30,
                          color: Theme.of(context).colorScheme.secondary,
                        ))
                  ],
                ),
              ),
              Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CarouselSlider.builder(
                          carouselController: controller,
                          itemCount: flashcard.cards.length,
                          itemBuilder: (context, index, realIndex) {
                            final card = flashcard.cards[index];
                            final question = card['Question'];
                            final answer = card['Answer'];
                            return Container(
                              height: MediaQuery.of(context).size.height * 2,
                              width: MediaQuery.of(context).size.width * 0.75,
                              child: FlipCard(
                                  controller: _controller,
                                  direction: FlipDirection.HORIZONTAL,
                                  front: FlashcardBox(
                                    isFlashcardEdit: true,
                                    cardContent: question,
                                    flipButton: TextButton(
                                        onPressed: () {
                                          _controller.toggleCard();
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text('Check Answer ',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall),
                                            Icon(
                                              Icons.arrow_forward,
                                              size: 15,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            ),
                                          ],
                                        )),
                                    onUpdateContent: (editQuestion) {
                                      setState(() {
                                        flashcard.cards[index]['Question'] =
                                            editQuestion;
                                        flashcard.save();
                                      });
                                    },
                                    isQuestion: true,
                                  ),
                                  back: FlashcardBox(
                                    isFlashcardEdit: true,
                                    cardContent: answer,
                                    flipButton: TextButton(
                                        onPressed: () {
                                          _controller.toggleCard();
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text('Check Question ',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall),
                                            Icon(
                                              Icons.arrow_forward,
                                              size: 15,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            ),
                                          ],
                                        )),
                                    onUpdateContent: (editAnswer) {
                                      setState(() {
                                        flashcard.cards[index]['Answer'] =
                                            editAnswer;
                                        flashcard.save();
                                      });
                                    },
                                  )),
                            );
                          },
                          options: CarouselOptions(
                              enableInfiniteScroll: false,
                              height: 425,
                              viewportFraction: 1,
                              initialPage: 0,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              })),
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
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  )),
                              IconButton(
                                  onPressed: next,
                                  icon: Icon(Icons.arrow_forward_ios,
                                      size: 25,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary)),
                            ],
                          ))
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 30,
                          top: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: _deleteFlashcard,
                                icon: Icon(
                                  size: 25,
                                  Icons.close,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                )),
                            SizedBox(
                              height: 3.5,
                              width: 280,
                              child: LinearProgressIndicator(
                                borderRadius: BorderRadius.circular(10),
                                value: (_currentIndex + 1) /
                                    flashcard.cards.length,
                                minHeight: 5,
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).colorScheme.secondary),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 50,
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
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(),
            ],
          ),
        ));
  }
}
