// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DopeUser.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DopeUserAdapter extends TypeAdapter<DopeUser> {
  @override
  final int typeId = 6;

  @override
  DopeUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DopeUser(
      sId: fields[0] as String,
      age: fields[1] as int,
      createdAt: fields[2] as double,
      displayName: fields[3] as String,
      email: fields[4] as String,
      imageUrl: fields[5] as String,
      uid: fields[6] as String,
      updatedAt: fields[7] as double,
    )..isLoggedIn = fields[9] as bool;
  }

  @override
  void write(BinaryWriter writer, DopeUser obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.sId)
      ..writeByte(1)
      ..write(obj.age)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.displayName)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.imageUrl)
      ..writeByte(6)
      ..write(obj.uid)
      ..writeByte(7)
      ..write(obj.updatedAt)
      ..writeByte(9)
      ..write(obj.isLoggedIn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DopeUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
