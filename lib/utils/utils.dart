import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {

  static late bool DARK_THEME;
  static late String DATA_PATH;
  static bool _initialized = false;

  static initializeUtils(Function() onInitialized) async {
    if (_initialized) {
      onInitialized();
      return;
    }
      _initialized = true;
      DATA_PATH = await getApplicationDocumentsDirectory().then((value) => value.path);
      DARK_THEME = await SharedPreferences.getInstance().then((SharedPreferences prefs) => prefs.getBool('is_dark_theme') ?? false);
      onInitialized();
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
    double proportionY = 56 / displayHeight;
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
