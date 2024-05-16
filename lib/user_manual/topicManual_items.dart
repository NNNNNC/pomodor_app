import 'package:pomodoro_app/user_manual/manual_info.dart';

class topicManualItems{
  List<manualInfo> items = [
    manualInfo(
      title: 'Welcome to our Topic Manual, where you can create your topic checklist and select flashcard set.',
      image: 'assets/images/topic.png'
      ),
    manualInfo(
      title: 'You can add Topics and Tap the created tile to edit or press 3 vertical dot icon to open options to delete a topic',
      image: 'assets/images/manual_images/topic_manual/topics.png'
      ),
    manualInfo(
      title: 'You can add description to your topic by tapping the edit button',
      image: 'assets/images/manual_images/topic_manual/description.png'
      ),
    manualInfo(
      title: 'You can also add a checklist of tasks by tapping the + icon and if you want to delete a task just press the delete button',
      image: 'assets/images/manual_images/topic_manual/task.png'
      ),
    manualInfo(
      title: 'You can then select your flashcard set from the flashcard page',
      image: 'assets/images/manual_images/topic_manual/flashcardSelect.png'
      ),
    manualInfo(
      title: 'You can also press the topic title to edit the topic name after editing you can press the check button to save',
      image: 'assets/images/manual_images/topic_manual/name_save.png'
      ),
  ];
}