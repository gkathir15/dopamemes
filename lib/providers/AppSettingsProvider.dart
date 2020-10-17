import 'package:dopamemes/exports/ModelExports.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class AppSettingProvider with ChangeNotifier {
  AppSettingProvider() {
    print("appasetting consstructor");
    openHiveBox();
  }

  Box<AppSettingsModel> _accountHiveBox;

  Future<Box<AppSettingsModel>> openHiveBox() async {
    if (_accountHiveBox.isOpen) {
      return _accountHiveBox;
    } else {
      return _accountHiveBox = await Hive.openBox<AppSettingsModel>("SETTING");
    }
  }
}
