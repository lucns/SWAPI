// @Developed by @lucns

// Tela de recupareção de senha

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lucns_swapi/views/my_toolbar.dart';
import 'package:lucns_swapi/utils/app_colors.dart';
import 'package:lucns_swapi/utils/utils.dart';
import 'package:lucns_swapi/screens/login/login_screen.dart';

class ForgottenPasswordScreen extends StatefulWidget {
  bool isDarkTheme;
  ForgottenPasswordScreen({Key? key}) : isDarkTheme = Utils.DARK_THEME, super(key: key);

  @override
  ForgottenPasswordScreenState createState() => ForgottenPasswordScreenState();
}

class ForgottenPasswordScreenState extends State<ForgottenPasswordScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000), () {
      Utils.changeBarsColors(false, widget.isDarkTheme, false, Brightness.light, widget.isDarkTheme ? Brightness.light : Brightness.dark);
    });
  }

  @override
  Widget build(BuildContext context) {
    _prefs.then((SharedPreferences prefs) {
      bool? isDarkTheme = prefs.getBool('is_dark_theme');
      if (isDarkTheme != null && widget.isDarkTheme != isDarkTheme) {
        setState(() {
          widget.isDarkTheme = isDarkTheme;
        });
        Utils.DARK_THEME = widget.isDarkTheme;
        Utils.changeBarsColors(
            false, widget.isDarkTheme, false, Brightness.light,
            widget.isDarkTheme ? Brightness.light : Brightness.dark);
      }
    });
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => LoginScreen()));
          return false;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: widget.isDarkTheme ? AppColors.appBackgroundDark : AppColors.appBackground,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints.expand(height: 72),
                  child: Container(
                    color: widget.isDarkTheme ? AppColors.appBackgroundDark : AppColors.appBackground,
                    child: MyToolbar().getView(context, "Recuperar senha",
                            () => {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LoginScreen()))
                        }, () {
                      log("aaa");
                    }),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      color: widget.isDarkTheme ? AppColors.fragmentBackgroundDark : AppColors.fragmentBackground,
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
                    child: Column(
                      children: [
                        Text(
                          "Esta função ainda não está disponível!",
                          style: TextStyle(color: widget.isDarkTheme ? AppColors.textNormalDark : AppColors.textNormal, fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
