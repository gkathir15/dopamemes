// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CategoryDetails.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryDetailsAdapter extends TypeAdapter<CategoryDetails> {
  @override
  final int typeId = 3;

  @override
  CategoryDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryDetails(
      sId: fields[0] as String,
      displayIcon: fields[1] as String,
      displayName: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryDetails obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.sId)
      ..writeByte(1)
      ..write(obj.displayIcon)
      ..writeByte(3)
      ..write(obj.displayName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
