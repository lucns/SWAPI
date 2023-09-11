// @Developed by @lucns

// Tela dos cards

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucns_swapi/database/user_controller.dart';
import 'package:lucns_swapi/screens/main/main_screen_cards.dart';
import 'package:lucns_swapi/utils/annotator.dart';

import 'package:lucns_swapi/utils/app_colors.dart';
import 'package:lucns_swapi/utils/utils.dart';
import 'package:lucns_swapi/screens/login/login_screen.dart';
import 'package:lucns_swapi/views/my_toolbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../dialogs/popup_menu.dart';

class MainScreen extends StatefulWidget {
  bool isDarkTheme;

  MainScreen({Key? key, this.isDarkTheme = false}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void _onBackPressed() {
    if (UserController().hasSelection()) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      } else {
        SystemNavigator.pop();
      }
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen()));
    }
  }

  void showMenuWindow() {
    PopupMenu popupMenu = PopupMenu(context: context);
    List<String> titles = [widget.isDarkTheme ? "Tema claro" : "Tema escuro", "Sair"];
    popupMenu.showMenu(popupMenu.generateIds(titles), (index) {
      switch(index) {
        case 0:
          setState(() {
            widget.isDarkTheme = !widget.isDarkTheme;
          });
          Utils.DARK_THEME = widget.isDarkTheme;
          _prefs.then((SharedPreferences prefs) {
            prefs.setBool('is_dark_theme', widget.isDarkTheme);
          });
          Utils.changeBarsColors(false, widget.isDarkTheme, false, Brightness.light, widget.isDarkTheme ? Brightness.light : Brightness.dark);
          break;
        case 1:
          UserController().deselect();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000), () {
      Utils.changeBarsColors(false, widget.isDarkTheme, false, Brightness.light, widget.isDarkTheme ? Brightness.light : Brightness.dark);
    });
  }

  @override
  Widget build(BuildContext context) {
    MainScreenCards mainScreenCards =
    MainScreenCards();
    _prefs.then((SharedPreferences prefs) {
      bool? isDarkTheme = prefs.getBool('is_dark_theme');
      if (isDarkTheme != null && widget.isDarkTheme != isDarkTheme) {
        setState(() {
          widget.isDarkTheme = isDarkTheme;
        });
        Utils.DARK_THEME = widget.isDarkTheme;
        Utils.changeBarsColors(false, widget.isDarkTheme, false, Brightness.light, widget.isDarkTheme ? Brightness.light : Brightness.dark);
      }
    });

    return WillPopScope(
        onWillPop: () async {
          _onBackPressed();
          return false;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: widget.isDarkTheme
              ? AppColors.appBackgroundDark
              : AppColors.appBackground,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints.expand(height: 72),
                  child: Container(
                    color: widget.isDarkTheme
                        ? AppColors.appBackgroundDark
                        : AppColors.appBackground,
                    child: MyToolbar().getView(context, "Star Wars - API", () {
                      _onBackPressed();
                    }, () {
                      showMenuWindow();
                    }),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      color: widget.isDarkTheme
                          ? AppColors.fragmentBackgroundDark
                          : AppColors.fragmentBackground,
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(56),
                          topLeft: Radius.circular(56)),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.shadow,
                          spreadRadius: 4,
                          blurRadius: 4,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: mainScreenCards,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
