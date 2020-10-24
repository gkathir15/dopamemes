import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'config.dart' as config;


var kLightTheme = ThemeData(
  
  bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.black, modalBackgroundColor: Colors.black87),
  canvasColor: const Color(0xffFAFAFA),
  primaryColor: Colors.white,
  brightness: Brightness.light,
  accentColor: config.Colors().accentColor(1),
  focusColor: config.Colors().mainColor(1),
  hintColor: config.Colors().secondColor(1),
  
);

var kDarkTheme = ThemeData(
  bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.black, modalBackgroundColor: Colors.black),
  canvasColor: Color(0xff212528),
  primaryColor: Color(0xFF181818),
  brightness: Brightness.dark,
  accentColor: config.Colors().accentDarkColor(1),
  focusColor: config.Colors().mainDarkColor(1),
  hintColor: config.Colors().secondDarkColor(1),
  
);
