import 'package:hive/hive.dart';

part 'topicModel.g.dart';

@HiveType(typeId: 3, adapterName: "TopicAdapter")
class TopicModel extends HiveObject {
  TopicModel({
    this.name,
    this.description,
    this.cardSet,
    this.tasks,
  });

  @HiveField(0)
  String? name;

  @HiveField(1)
  String? description;

  @HiveField(2)
  int? cardSet;

  @HiveField(3)
  List<dynamic>? tasks = [];
}
