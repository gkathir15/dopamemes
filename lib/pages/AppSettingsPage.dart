import 'package:clean_settings/clean_settings.dart';
import 'package:dopamemes/model/AppSettingsModel.dart';
import 'package:dopamemes/providers/AppSettingsProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wiredash/wiredash.dart';

class AppSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppSettingProvider _appSettingsProvider =
        Provider.of<AppSettingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: GoogleFonts.roboto(),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SettingContainer(
        sections: [
          SettingSection(
            title: "Appearence",
            items: [
              SettingRadioItem<String>(
                priority: ItemPriority.normal,
                title: 'Theme',
                displayValue: selectedTheme(_appSettingsProvider),
                selectedValue: selectedTheme(_appSettingsProvider),
                items: [
                  SettingRadioValue('Light', 'Light'),
                  SettingRadioValue('Dark', 'Dark'),
                  SettingRadioValue('System Default', 'System Default'),
                ],
                onChanged: (v) => {
                  if (v == "System Default")
                    {_appSettingsProvider.settings.isSystemThemeSelected = true}
                  else if (v == "Dark")
                    {
                      _appSettingsProvider.settings.isSystemThemeSelected =
                          false,
                      _appSettingsProvider.settings.isDarkTheme = true
                    }
                  else
                    {
                      _appSettingsProvider.settings.isSystemThemeSelected =
                          false,
                      _appSettingsProvider.settings.isDarkTheme = false
                    },
                  _appSettingsProvider.setData(_appSettingsProvider.settings),
                },
              ),
            ],
          ),
          SettingSection(title: " Media Playback", items: [
            SettingSwitchItem(
              priority: ItemPriority.normal,
              title: "Autoplay",
              value: _appSettingsProvider.settings.isAutoPlayVideos,
              onChanged: (value) {
                _appSettingsProvider.settings.isAutoPlayVideos = value;
                _appSettingsProvider.setData(_appSettingsProvider.settings);
              },
              description: "Automatically play videos",
            ),
            SettingSwitchItem(
                priority: ItemPriority.normal,
                title: "Volume Mute",
                value: _appSettingsProvider.settings.isMute,
                onChanged: (value) {
                  _appSettingsProvider.settings.isMute = value;
                  _appSettingsProvider.setData(_appSettingsProvider.settings);
                },
                description: "Mute videos"),
          ]),
          SettingSection(title: " NFSW Content", items: [
            SettingSwitchItem(
              priority: ItemPriority.normal,
              title: "Allow NFSW content",
              value: _appSettingsProvider.settings.showNSFW,
              onChanged: (value) {
                _appSettingsProvider.settings.showNSFW = value;
                _appSettingsProvider.setData(_appSettingsProvider.settings);
              },
              description: "Iam 18+ show NFSW",
            ),
            SettingSwitchItem(
                priority: ItemPriority.normal,
                title: "Hide NFSW content",
                value: _appSettingsProvider.settings.showNfswOverlay,
                onChanged: (value) {
                  _appSettingsProvider.settings.showNfswOverlay = value;
                  _appSettingsProvider.setData(_appSettingsProvider.settings);
                },
                description: "Show NFSW content"),

                SettingSection(items: [
                  InkWell(onTap: () {
                Wiredash.of(context).show();
              },
                                      child: Padding(
                padding: const EdgeInsets.all( 15.0),
                child: Text("Connect with Us"),
              ),
                  ),
                ],title: "Feedback",),
          
          ])
        ],
      ),
    );
  }

  String selectedTheme(AppSettingProvider provider) {
    if (provider.settings.isSystemThemeSelected) {
      return "System Default";
    } else if (provider.settings.isDarkTheme) {
      return "Dark Theme";
    } else {
      return "Light Theme";
    }
  }
}
