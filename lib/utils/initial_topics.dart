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
    TopicModel(
      name: 'Java Basics',
      cardSet: 3,
      tasks: [
        ['Read Chapter 1 of "Java Programming for Beginners"', false],
        ['Complete online tutorials on Java syntax and basics', false],
        ['Explore Java documentation and learn about basic data types', false],
        [
          'Solve coding challenges on variables, operators, and control flow',
          false
        ],
        [
          'Work on a small Java project, such as a calculator or todo list application',
          false
        ],
      ],
    ),
    TopicModel(
      name: 'Mathematics',
      cardSet: 4,
      tasks: [
        ['Review and practice solving equations with one variable', false],
        ['Study properties and operations of matrices', false],
        ['Explore the concept of limits and continuity in calculus', false],
        ['Learn about vectors and vector operations', false],
        ['Study properties of logarithms and exponential functions', false],
      ],
    ),
    TopicModel(
      name: 'Philippine History',
      cardSet: 5,
      tasks: [
        [
          'Research and present on the pre-colonial civilizations in the Philippines',
          false
        ],
        [
          'Read primary sources on the Spanish colonization period and summarize key events',
          false
        ],
        [
          'Watch documentaries on the Philippine Revolution against Spanish rule',
          false
        ],
        [
          'Study the American occupation period and its impact on Philippine society',
          false
        ],
        [
          'Explore the Japanese occupation of the Philippines during World War II',
          false
        ],
      ],
    ),
  ];
}
