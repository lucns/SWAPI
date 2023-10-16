// @developes by @lucns

//import 'dart:developer';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_colors.dart';

class Utils {
  static late String DATA_PATH;
  static bool _initialized = false;
  static bool _initializing = false;
  static late SharedPreferences _preferences;

  static initializeUtils(Function() onInitialized) async {
    if (_initialized) {
      onInitialized();
      return;
    }
    if (_initializing) return;
    _initializing = true;
    _initialized = true;
    DATA_PATH =
        await getApplicationDocumentsDirectory().then((value) => value.path);
    await SharedPreferences.getInstance().then((SharedPreferences prefs) {
      _preferences = prefs;
      onInitialized();
    });
  }

  static SharedPreferences getPrefs() {
    return _preferences;
  }

  static double getWidthDisplay() {
    return WidgetsBinding
        .instance.platformDispatcher.views.first.physicalSize.width;
  }

  static double getHeightDisplay() {
    return WidgetsBinding
        .instance.platformDispatcher.views.first.physicalSize.height;
  }

  static Alignment menuPosition(context) {
    double displayHeight = MediaQuery.of(context).size.height;
    double proportionY = 56 / displayHeight; // 56dp = toolbar height
    double b = (proportionY * 2) - 1;
    return Alignment(1, b);
  }

  static Alignment coordinatesToRelative(context, w, h, x, y) {
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;
    double proportionX = (x + (w / 2)) / displayWidth;
    double proportionY = (y + (h / 2)) / displayHeight;
    double a = (proportionX * 2) - 1;
    double b = (proportionY * 2) - 1;
    return Alignment(a, b);
  }

  static Alignment percentageToRelative(
      context, w, h, xPercentage, yPercentage) {
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;
    double x = (xPercentage / 100) * displayWidth;
    double y = (yPercentage / 100) * displayHeight;

    double proportionX = (x) / displayWidth;
    double proportionY = (y) / displayHeight;
    double a = (proportionX * 2) - 1;
    double b = (proportionY * 2) - 1;
    return Alignment(a, b);
  }

  static bool isDarkTheme() {
    return getPrefs().getBool("is_dark_theme") ?? false;
  }

  static setIsDarkTheme(bool isDarkTheme) {
    getPrefs().setBool("is_dark_theme", isDarkTheme);
  }

  static changeBarsColors(bool inDialog, bool isDarkTheme, bool isLoginScreen,
      Brightness statusBar, Brightness navigationBar) {
    //log("inDialog:$inDialog isDarkTheme:$isDarkTheme isLoginScreen:$isLoginScreen");
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: isLoginScreen
            ? (inDialog
                ? (isDarkTheme
                    ? AppColors.fragmentBackgroundInDialogDark
                    : AppColors.fragmentBackgroundInDialog)
                : (isDarkTheme
                    ? AppColors.fragmentBackgroundDark
                    : AppColors.fragmentBackground))
            : (inDialog
                ? (isDarkTheme
                    ? AppColors.appBackgroundInDialogDark
                    : AppColors.appBackgroundInDialog)
                : (isDarkTheme
                    ? AppColors.appBackgroundDark
                    : AppColors.appBackground)),
        systemNavigationBarColor: isLoginScreen
            ? (inDialog
                ? (isDarkTheme
                    ? AppColors.appBackgroundInDialogDark
                    : AppColors.appBackgroundInDialog)
                : (isDarkTheme
                    ? AppColors.appBackgroundDark
                    : AppColors.appBackground))
            : (inDialog
                ? (isDarkTheme
                    ? AppColors.fragmentBackgroundInDialogDark
                    : AppColors.fragmentBackgroundInDialog)
                : (isDarkTheme
                    ? AppColors.fragmentBackgroundDark
                    : AppColors.fragmentBackground)),
        statusBarIconBrightness: statusBar,
        systemNavigationBarIconBrightness: navigationBar));
  }
}
