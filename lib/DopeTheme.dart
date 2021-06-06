import 'package:flutter/material.dart';

import 'config.dart' as config;

var kLightTheme = ThemeData(
    bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Color(0xffDEE8F7),
        modalBackgroundColor: const Color(0xffDEE8F9)),
    canvasColor: const Color(0xffFAFAFA),
    primaryColor: Colors.white,
    brightness: Brightness.light,
    accentColor: config.Colors().accentColor(1),
    focusColor: config.Colors().mainColor(1),
    hintColor: config.Colors().secondColor(1),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: const Color(0xff615DA4)));

var kDarkTheme = ThemeData(
    bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.black, modalBackgroundColor: Colors.black),
    canvasColor: Color(0xff212528),
    primaryColor: Color(0xFF181818),
    brightness: Brightness.dark,
    accentColor: config.Colors().accentDarkColor(1),
    focusColor: config.Colors().mainDarkColor(1),
    hintColor: config.Colors().secondDarkColor(1),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: const Color(0xffD9582A)));
