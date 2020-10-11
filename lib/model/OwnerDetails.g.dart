// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OwnerDetails.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OwnerDetailsAdapter extends TypeAdapter<OwnerDetails> {
  @override
  final int typeId = 2;

  @override
  OwnerDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OwnerDetails(
      sId: fields[0] as String,
      displayName: fields[1] as String,
      imageUrl: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OwnerDetails obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.sId)
      ..writeByte(1)
      ..write(obj.displayName)
      ..writeByte(3)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OwnerDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
