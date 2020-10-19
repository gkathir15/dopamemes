import 'package:dopamemes/exports/ModelExports.dart';
import 'package:flutter/cupertino.dart';
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
}
