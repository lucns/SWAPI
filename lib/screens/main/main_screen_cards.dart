// Developed by @lucns

// Fragmento dos cards

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lucns_swapi/utils/app_colors.dart';
import 'package:lucns_swapi/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'list_screen.dart';

class MainScreenCards extends StatefulWidget {
  bool isDarkTheme;

  MainScreenCards({Key? key}) : isDarkTheme = Utils.DARK_THEME, super(key: key);

  @override
  MainScreenState createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreenCards> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    _prefs.then((SharedPreferences prefs) {
      bool? isDarkTheme = prefs.getBool('is_dark_theme');
      if (isDarkTheme != null && widget.isDarkTheme != isDarkTheme) {
        setState(() {
          widget.isDarkTheme = isDarkTheme;
        });
        Utils.DARK_THEME = widget.isDarkTheme;
      }
    });

    return Column(children: [
      Material(
          color: widget.isDarkTheme
              ? AppColors.cardBackgroundDark
              : AppColors.cardBackground,
          elevation: 4,
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          child: InkWell(
              splashColor: AppColors.appBackground.withOpacity(0.4),
              highlightColor: AppColors.appBackground.withOpacity(0.4),
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              onTap: () {_openListScreen(ListScreen.MOVIES);},
              child: Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(16),
                constraints: const BoxConstraints.expand(height: 110),
                child: _getHorizontalCard(
                    "Filmes",
                    "Conheça aqui todos os filmes da saga Star Wars.",
                    "movies.png"),
              ))),
      const SizedBox(height: 16),
      Row(children: [
        Expanded(
            child: Material(
                color: widget.isDarkTheme
                    ? AppColors.cardBackgroundDark
                    : AppColors.cardBackground,
                elevation: 4,
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                child: InkWell(
                    splashColor: AppColors.appBackground.withOpacity(0.4),
                    highlightColor: AppColors.appBackground.withOpacity(0.4),
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                    onTap: () {_openListScreen(ListScreen.PERSONS);},
                    child: Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.all(16),
                        constraints: const BoxConstraints.expand(height: 110),
                        child: _getHorizontalSmallCard("Personagens",
                            "Lista de personagens da saga.", "persons_0.png"))))),
        const SizedBox(width: 16),
        Expanded(
            child: Material(
                color: widget.isDarkTheme
                    ? AppColors.cardBackgroundDark
                    : AppColors.cardBackground,
                elevation: 4,
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                child: InkWell(
                    splashColor: AppColors.appBackground.withOpacity(0.4),
                    highlightColor: AppColors.appBackground.withOpacity(0.4),
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                    onTap: () {_openListScreen(ListScreen.PLANETS);},
                    child: Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.all(16),
                        constraints: const BoxConstraints.expand(height: 110),
                        child: _getHorizontalSmallCard("Planetas",
                            "Lista de planetas da saga.", "planet_0.png")))))
      ]),
    ]);
  }

  Row _getHorizontalCard(String title, String description, String imageName) {
    return Row(children: [
      Align(alignment: Alignment.topLeft, child: Image(
          image: ResizeImage(
              AssetImage(
                ("assets/images/$imageName"),
              ),
              width: 78,
              height: 78))),
      const SizedBox(width: 16),
      Flexible(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 18,
                color: widget.isDarkTheme
                    ? AppColors.textNormalDark
                    : AppColors.textNormal)),
        Text(description,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 14,
                color: widget.isDarkTheme
                    ? AppColors.textNormalSecondaryDark
                    : AppColors.textNormalSecondary))
      ])),
    ]);
  }

  Row _getHorizontalSmallCard(
      String title, String description, String imageName) {
    return Row(children: [
      Align(alignment: Alignment.topLeft, child: Image(
          image: ResizeImage(AssetImage("assets/images/$imageName"),
              width: 36, height: 36))),
      const SizedBox(width: 16),
      Flexible(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
                fontSize: 18,
                color: widget.isDarkTheme
                    ? AppColors.textNormalDark
                    : AppColors.textNormal)),
        Flexible(
            child: Text(description,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 14,
                    color: widget.isDarkTheme
                        ? AppColors.textNormalSecondaryDark
                        : AppColors.textNormalSecondary)))
      ])),
    ]);
  }

  void _openListScreen(int type) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ListScreen(listType: type)));
  }
}
