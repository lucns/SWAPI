// @Developed by @lucns

import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:lucns_swapi2/store/swapi_store.dart';
import 'package:lucns_swapi2/widgets/my_toolbar.dart';
import 'package:lucns_swapi2/utils/app_colors.dart';
import 'package:lucns_swapi2/utils/utils.dart';
import 'package:lucns_swapi2/pages/login_screen.dart';

class ForgottenPasswordScreen extends StatefulWidget {
  ForgottenPasswordScreen({Key? key}) : super(key: key);

  @override
  ForgottenPasswordScreenState createState() => ForgottenPasswordScreenState();
}

class ForgottenPasswordScreenState extends State<ForgottenPasswordScreen> {
  bool isDarkTheme = false;

  @override
  void initState() {
    super.initState();
    isDarkTheme = Utils.isDarkTheme();
    Utils.changeBarsColors(false, isDarkTheme, false, Brightness.light,
        isDarkTheme ? Brightness.light : Brightness.dark);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
          return false;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: isDarkTheme
              ? AppColors.appBackgroundDark
              : AppColors.appBackground,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints.expand(height: 72),
                  child: Container(
                    color: isDarkTheme
                        ? AppColors.appBackgroundDark
                        : AppColors.appBackground,
                    child: MyToolbar().getView(
                        context,
                        "Recuperar senha",
                        () => {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()))
                            }, () {
                      log("aaa");
                    }),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      color: isDarkTheme
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
                    child: Column(
                      children: [
                        Text(
                          "Esta função ainda não está disponível!",
                          style: TextStyle(
                              color: isDarkTheme
                                  ? AppColors.textNormalDark
                                  : AppColors.textNormal,
                              fontSize: 18),
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
