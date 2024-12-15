import 'package:pomodoro_app/models/topicModel.dart';

class InitialTopics {
  List<TopicModel> topics = [
    TopicModel(
      name: 'Computer Science Basics',
      cardSet: 0,
      tasks: [
        ['Complete the quiz on binary numbers', false],
        ['Write a short essay on the importance of algorithms', false],
        ['Solve 10 problems on basic data structures', false],
        ['Create a flowchart for a simple program', false],
        ['Build a basic HTML page as a practical exercise', false],
      ],
    ),
    TopicModel(
      name: 'English',
      cardSet: 1,
      tasks: [
        ['Read a short story and highlight unfamiliar words', false],
        ['Create flashcards for 10 new words you learned today', false],
        ['Write a paragraph using at least 5 new vocabulary words', false],
        ['Watch a TED talk and note down interesting vocabulary', false],
        [
          'Practice pronunciation of difficult words using online resources',
          false
        ],
      ],
    ),
    TopicModel(
      name: 'Japanese',
      cardSet: 2,
      tasks: [
        ['Practice writing 10 Hiragana characters', false],
        [
          'Watch a Japanese movie or anime with subtitles and note down new words',
          false
        ],
        ['Engage in a conversation with a language exchange partner', false],
        ['Memorize 10 useful phrases for everyday conversation', false],
        ['Write a short journal entry in Japanese', false],
      ],
    ),
  ];
}
