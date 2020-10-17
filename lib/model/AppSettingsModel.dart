import 'package:hive/hive.dart';

part 'AppSettingsModel.g.dart';

@HiveType(typeId: 5)
class AppSettingsModel{
  @HiveField(0)
  bool isSystemThemeSelected;
  @HiveField(1)
  bool isDarkTheme ;
  @HiveField(2)
  bool isAutoPlayVideos ;
  @HiveField(3)
  bool isMute;
  @HiveField(4)
  bool showNSFW;
  @HiveField(5)
  bool showNfswOverlay;


}
