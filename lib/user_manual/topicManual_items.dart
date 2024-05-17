import 'package:pomodoro_app/user_manual/manual_info.dart';

class topicManualItems {
  List<manualInfo> items = [
    manualInfo(
        title:
            'Welcome to our Topic Manual, where you can create your own topics.',
        image: 'assets/images/topic.png'),
    manualInfo(
        title:
            'You can add topics by pressing the floating plus button or you could press the three vertical dot icon to open options to delete a topic',
        image: 'assets/images/manual_images/topic_manual/topics.png'),
    manualInfo(
        title:
            'You can add description to your topic by tapping the edit button',
        image: 'assets/images/manual_images/topic_manual/description.png'),
    manualInfo(
        title:
            'You can also add a checklist of tasks by tapping the + icon and if you want to delete a task just press the trash icon',
        image: 'assets/images/manual_images/topic_manual/task.png'),
    manualInfo(
        title:
            'You can then connect your flashcard set from the flashcard page to make them accessible during pomodoro',
        image: 'assets/images/manual_images/topic_manual/flashcardSelect.png'),
    manualInfo(
        title:
            'You can also press the topic title to edit the topic name, and you can press the check button to save',
        image: 'assets/images/manual_images/topic_manual/name_save.png'),
  ];
}
