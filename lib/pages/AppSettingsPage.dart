import 'package:clean_settings/clean_settings.dart';
import 'package:dopamemes/model/AppSettingsModel.dart';
import 'package:dopamemes/providers/AppSettingsProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
                displayValue: ThemeMode.dark.toString(),
                selectedValue: ThemeMode.system.toString(),
                items: [
                  SettingRadioValue('Light', 'Light'),
                  SettingRadioValue('Dark', 'Dark'),
                  SettingRadioValue('System Default', 'System Default'),
                ],
                onChanged: (v) => {},
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
                 _appSettingsProvider.settings.isMute= value;
                _appSettingsProvider.setData(_appSettingsProvider.settings);
                },
                description: "Mute videos"),
          ]),
          SettingSection(title: " NFSW Content", items: [
            SettingSwitchItem(
              priority: ItemPriority.normal,
              title: "Allow NFSW content",
              value: false,
              onChanged: (value) {},
              description: "Iam 18+ show NFSW",
            ),
            SettingSwitchItem(
                priority: ItemPriority.normal,
                title: "Hide NFSW content",
                value: true,
                onChanged: (value) {},
                description: "Show NFSW content"),
          ])
        ],
      ),
    );
  }
}
