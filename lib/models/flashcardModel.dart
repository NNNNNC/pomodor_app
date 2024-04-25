import 'package:hive/hive.dart';

part 'flashcardModel.g.dart';

@HiveType(typeId: 0, adapterName: 'flashcardAdapter')
class Flashcard extends HiveObject {
  @HiveField(0)
  String cardSetName;

  @HiveField(1)
  List<Map<String, String>> cards;

  Flashcard({required this.cardSetName, required this.cards});
}
