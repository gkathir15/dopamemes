import 'package:hive/hive.dart';

part 'AppSettingsModel.g.dart';

@HiveType(typeId: 5)
class AppSettingsModel {

  AppSettingsModel();

  @HiveField(0)
  bool isSystemThemeSelected = true;
  @HiveField(1)
  bool isDarkTheme = false;
  @HiveField(2)
  bool isAutoPlayVideos = true;
  @HiveField(3)
  bool isMute = true;
  @HiveField(4)
  bool showNSFW = false;
  @HiveField(5)
  bool showNfswOverlay = true;
}
