// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selectedModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KeyAdapter extends TypeAdapter<SelectedModel> {
  @override
  final int typeId = 4;

  @override
  SelectedModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SelectedModel(
      selectedTopic: fields[0] as int?,
      selectedProfile: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SelectedModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.selectedTopic)
      ..writeByte(1)
      ..write(obj.selectedProfile);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KeyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
