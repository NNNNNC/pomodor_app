import 'package:hive/hive.dart';

part 'selectedModel.g.dart';

@HiveType(typeId: 4, adapterName: 'KeyAdapter')
class SelectedModel extends HiveObject {
  SelectedModel({
    this.selectedTopic,
    this.selectedProfile,
    this.isDarkMode,
  });

  @HiveField(0)
  int? selectedTopic;

  @HiveField(1)
  int? selectedProfile;

  @HiveField(2)
  bool? isDarkMode;
}
