import 'package:dogapp/product/utility/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData projectTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: CupertinoColors.systemBackground,
    fontFamily: ApplicationConstants.FONT_FAMILY,

floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: CupertinoColors.systemBackground,
    foregroundColor: CupertinoColors.systemBlue,
),

bottomNavigationBarTheme:     const BottomNavigationBarThemeData(
    backgroundColor: CupertinoColors.systemBackground,
    selectedIconTheme: IconThemeData(color: CupertinoColors.systemBlue),
    selectedItemColor: CupertinoColors.systemBlue,
    unselectedIconTheme: IconThemeData(color: CupertinoColors.label),
    unselectedItemColor: CupertinoColors.label,
    selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
),
    // APPBAR
    appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent),
);
