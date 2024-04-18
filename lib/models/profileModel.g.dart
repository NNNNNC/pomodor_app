// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profileModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class profileAdapter extends TypeAdapter<profileModel> {
  @override
  final int typeId = 1;

  @override
  profileModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return profileModel(
      fields[0] as String,
      fields[1] as int,
      fields[2] as int,
      fields[3] as int,
      fields[4] as String,
      fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, profileModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.focusDuration)
      ..writeByte(2)
      ..write(obj.shortBreak)
      ..writeByte(3)
      ..write(obj.longBreak)
      ..writeByte(4)
      ..write(obj.whiteNoise)
      ..writeByte(5)
      ..write(obj.ringtone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is profileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
