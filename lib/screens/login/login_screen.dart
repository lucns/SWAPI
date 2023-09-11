// @developed by @lucns

// Tela de login

import 'dart:developer';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:lucns_swapi/utils/app_colors.dart';
import 'package:lucns_swapi/screens/login/fragment_higher.dart';
import 'package:lucns_swapi/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  bool isDarkTheme;

  LoginScreen({Key? key})
      : isDarkTheme = false,
        super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool imageOpacityGo = false;
  Timer? timer;
  FragmentHigher? fragmentHigher;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void _scheduleOpacity() {
    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer(const Duration(milliseconds: 1500), () {
      setState(() {
        if (imageOpacityGo) {
          imageOpacityGo = false;
        } else {
          imageOpacityGo = true;
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000), () { // Força a status bar e navigation bar ficarem na cor coerente.
      Utils.changeBarsColors(
          false,
          widget.isDarkTheme,
          true,
          widget.isDarkTheme ? Brightness.light : Brightness.dark,
          Brightness.light);
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null) {
      timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    _scheduleOpacity();

    if (fragmentHigher == null) {
      fragmentHigher = FragmentHigher(isDarkTheme: widget.isDarkTheme);
      _prefs.then((SharedPreferences prefs) {
        bool? isDarkTheme = prefs.getBool('is_dark_theme');
        if (isDarkTheme != null && widget.isDarkTheme != isDarkTheme) {
          setState(() {
            widget.isDarkTheme = isDarkTheme;
          });
          Utils.DARK_THEME = widget.isDarkTheme;
        }
        fragmentHigher!.setDarkTheme(widget.isDarkTheme);
        Utils.changeBarsColors(
            false,
            widget.isDarkTheme,
            true,
            widget.isDarkTheme ? Brightness.light : Brightness.dark,
            Brightness.light);
      });
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: widget.isDarkTheme
            ? AppColors.appBackgroundDark
            : AppColors.appBackground,
        body: Column(children: [
          fragmentHigher ?? const SizedBox(),
          Expanded(
              child: SizedBox(
                  width: double.infinity,
                  child: DecoratedBox(
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                      child: Stack(children: [
                        Align(
                            alignment: Alignment.center,
                            child: AnimatedOpacity(
                                opacity: imageOpacityGo ? 1 : 0.3,
                                duration: const Duration(milliseconds: 1000),
                                child: Image(
                                    image: ResizeImage(
                                        AssetImage(widget.isDarkTheme
                                            ? 'assets/images/sw_logo_dark.png'
                                            : 'assets/images/sw_logo_white.png'),
                                        width: 100,
                                        height: 44)))),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Text("Desafio SWAPI",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: widget.isDarkTheme
                                        ? Colors.white
                                        : Colors.black))),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: RawMaterialButton(
                                onPressed: () {
                                  setState(() {
                                    widget.isDarkTheme = !widget.isDarkTheme;
                                    Utils.DARK_THEME = widget.isDarkTheme;
                                  });
                                  fragmentHigher!
                                      .setDarkTheme(widget.isDarkTheme);
                                  _prefs.then((SharedPreferences prefs) {
                                    prefs.setBool(
                                        'is_dark_theme', widget.isDarkTheme);
                                  });
                                },
                                elevation: 0,
                                constraints: const BoxConstraints(),
                                shape: const CircleBorder(),
                                fillColor: Colors.transparent,
                                splashColor: Colors.white.withOpacity(0.4),
                                highlightColor: Colors.white.withOpacity(0.4),
                                highlightElevation: 0,
                                padding: const EdgeInsets.all(16),
                                child: Icon(
                                    widget.isDarkTheme
                                        ? Icons.brightness_5
                                        : Icons.brightness_4,
                                    size: 28,
                                    color: widget.isDarkTheme
                                        ? Colors.white.withOpacity(0.75)
                                        : Colors.white)))
                      ]))))
        ]));
  }
}
