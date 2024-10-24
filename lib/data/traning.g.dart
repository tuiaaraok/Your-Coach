// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'traning.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TraningAdapter extends TypeAdapter<Traning> {
  @override
  final int typeId = 2;

  @override
  Traning read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Traning(
      nameGroup: fields[0] as String?,
      category: fields[1] as String?,
      description: (fields[2] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Traning obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.nameGroup)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TraningAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
