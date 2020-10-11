// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Categories.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoriesAdapter extends TypeAdapter<Categories> {
  @override
  final int typeId = 4;

  @override
  Categories read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Categories(
      sId: fields[0] as String,
      createdAt: fields[1] as double,
      displayIcon: fields[2] as String,
      displayName: fields[3] as String,
      isMature: fields[4] as bool,
      updatedAt: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Categories obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.sId)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.displayIcon)
      ..writeByte(3)
      ..write(obj.displayName)
      ..writeByte(4)
      ..write(obj.isMature)
      ..writeByte(5)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoriesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
