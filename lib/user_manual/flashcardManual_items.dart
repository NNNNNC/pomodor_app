import 'package:pomodoro_app/user_manual/manual_info.dart';

class flashcardManualItems {
  List<manualInfo> items = [
    manualInfo(
        title:
            'Welcome to the Flashcard Manual, where you can learn to create your personalized sets of flashcards for efficient learning.',
        image: 'assets/images/flashcard.png'),
    manualInfo(
        title:
            'You can add flashcard sets by tapping the floating plus button, and tapping the created tile will navigate you to the edit page.',
        image: 'assets/images/manual_images/flashcard_manual/flashcard.png'),
    manualInfo(
        title: 'You could lock the editing by tapping the pencil icon',
        image: 'assets/images/manual_images/flashcard_manual/edit.png'),
    manualInfo(
        title:
            'You can tap check answer to flip the card to also edit the other side of the card',
        image: 'assets/images/manual_images/flashcard_manual/flip.png'),
    manualInfo(
        title:
            'You can press the add button to create another flashcard or press the X button to delete a flashcard',
        image: 'assets/images/manual_images/flashcard_manual/add_delete.png'),
    manualInfo(
        title:
            'You can also press the Flashcard Set title to edit the flashcard Set name, and after editing you can press the check button to save',
        image: 'assets/images/manual_images/flashcard_manual/name_save.png'),
  ];
}
