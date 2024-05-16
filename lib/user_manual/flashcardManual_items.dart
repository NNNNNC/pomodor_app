import 'package:pomodoro_app/user_manual/manual_info.dart';

class flashcardManualItems{
  List<manualInfo> items = [
    manualInfo(
      title: 'Welcome to our Flashcard Manual, where you can create your personalized sets of flashcards for efficient learning.',
      image: 'assets/images/flashcard.png'
      ),
    manualInfo(
      title: 'You can add Flashcard Set and Tap the created tile to edit or press delete icon to delete a set of flashcard',
      image: 'assets/images/manual_images/flashcard_manual/flashcard.png'
      ),
    manualInfo(
      title: 'To edit the content of the flashcard you can tap the edit button',
      image: 'assets/images/manual_images/flashcard_manual/edit.png'
      ),
    manualInfo(
      title: 'You can tap check answer to flip the card to also edit the other side of the card',
      image: 'assets/images/manual_images/flashcard_manual/flip.png'
      ),
    manualInfo(
      title: 'You can press the add button to create another flashcard or press the X button to delete a flashcard',
      image: 'assets/images/manual_images/flashcard_manual/add_delete.png'
      ),
    manualInfo(
      title: 'You can also press the Flashcard Set title to edit the flashcard Set name after editing you can press the check button to save',
      image: 'assets/images/manual_images/flashcard_manual/name_save.png'
      ),
  ];
}