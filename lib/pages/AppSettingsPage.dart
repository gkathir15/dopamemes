import 'package:clean_settings/clean_settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: GoogleFonts.roboto(),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SettingContainer(sections: [
        SettingSection(title: "Appearence",
        items: [
          SettingRadioItem<String>(
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

        ],),
        SettingSection(title:"Playback",items: [])
      ],),
    );
  }
}
