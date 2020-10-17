// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppSettingsModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppSettingsModelAdapter extends TypeAdapter<AppSettingsModel> {
  @override
  final int typeId = 5;

  @override
  AppSettingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppSettingsModel()
      ..isSystemThemeSelected = fields[0] as bool
      ..isDarkTheme = fields[1] as bool
      ..isAutoPlayVideos = fields[2] as bool
      ..isMute = fields[3] as bool
      ..showNSFW = fields[4] as bool
      ..showNfswOverlay = fields[5] as bool;
  }

  @override
  void write(BinaryWriter writer, AppSettingsModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.isSystemThemeSelected)
      ..writeByte(1)
      ..write(obj.isDarkTheme)
      ..writeByte(2)
      ..write(obj.isAutoPlayVideos)
      ..writeByte(3)
      ..write(obj.isMute)
      ..writeByte(4)
      ..write(obj.showNSFW)
      ..writeByte(5)
      ..write(obj.showNfswOverlay);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettingsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
