// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashcardModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class flashcardAdapter extends TypeAdapter<Flashcard> {
  @override
  final int typeId = 0;

  @override
  Flashcard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Flashcard(
      cardSetName: fields[0] as String,
      cards: (fields[1] as List)
          .map((dynamic e) => (e as Map).cast<String, String>())
          .toList(),
    );
  }

  @override
  void write(BinaryWriter writer, Flashcard obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.cardSetName)
      ..writeByte(1)
      ..write(obj.cards);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is flashcardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
