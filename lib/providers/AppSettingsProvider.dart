import 'package:dopamemes/exports/ModelExports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AppSettingProvider with ChangeNotifier {
  AppSettingProvider() {
    print("appasetting consstructor");
    openHiveBox();
  }

  AppSettingsModel defVal;
  AppSettingsModel settings;

  Box<AppSettingsModel> appSettingBox;

  openHiveBox() {
    appSettingBox = Hive.box<AppSettingsModel>("SETTING");
    defVal = AppSettingsModel();
    settings = appSettingBox.get("AppSettings", defaultValue: defVal);
  }

  setData(AppSettingsModel updatedModel) {
    settings = updatedModel;
    appSettingBox.put("AppSettings", settings);
    notifyListeners();
  }

  ThemeMode getTheme() {
    if (settings.isSystemThemeSelected) {
      return ThemeMode.system;
    } else if (settings.isDarkTheme) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }

  bool isMute() {
    return settings.isMute ? true : false;
  } 
  bool isShowNFSW() {
    return settings.showNSFW ? true : false;
  }
  bool isShowNfswOverLay() {
    return settings.showNfswOverlay ? true : false;
  }bool isAutolay() {
    return settings.isAutoPlayVideos ? true : false;
  }
}
