// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Posts.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostsAdapter extends TypeAdapter<Posts> {
  @override
  final int typeId = 1;

  @override
  Posts read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Posts(
      sId: fields[0] as String,
      caption: fields[1] as String,
      categoryDetails: fields[2] as CategoryDetails,
      categoryId: fields[3] as String,
      createdAt: fields[4] as int,
      fileUrl: fields[5] as String,
      isMature: fields[6] as String,
      ownerDetails: fields[7] as OwnerDetails,
      ownerId: fields[8] as String,
      postType: fields[9] as String,
      updatedAt: fields[10] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Posts obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.sId)
      ..writeByte(1)
      ..write(obj.caption)
      ..writeByte(2)
      ..write(obj.categoryDetails)
      ..writeByte(3)
      ..write(obj.categoryId)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.fileUrl)
      ..writeByte(6)
      ..write(obj.isMature)
      ..writeByte(7)
      ..write(obj.ownerDetails)
      ..writeByte(8)
      ..write(obj.ownerId)
      ..writeByte(9)
      ..write(obj.postType)
      ..writeByte(10)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
