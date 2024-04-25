import 'package:hive/hive.dart';

part 'profileModel.g.dart';

@HiveType(typeId: 1, adapterName: 'profileAdapter')
class profileModel extends HiveObject{

  @HiveField(0)
  String name;

  @HiveField(1)
  int focusDuration;

  @HiveField(2)
  int shortBreak;

  @HiveField(3)
  int longBreak;

  @HiveField(4)
  String whiteNoise;

  @HiveField(5)
  String ringtone;
  

  profileModel(
    this.name,
    this.focusDuration,
    this.shortBreak,
    this.longBreak,
    this.whiteNoise,
    this.ringtone,
    );

}