// @Developed by @lucns

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:lucns_swapi2/controllers/user_controller2.dart';
import 'package:lucns_swapi2/pages/list_screen.dart';
import 'package:lucns_swapi2/store/swapi_store.dart';
import 'package:lucns_swapi2/utils/app_colors.dart';
import 'package:lucns_swapi2/utils/utils.dart';
import 'package:lucns_swapi2/pages/login_screen.dart';
import 'package:lucns_swapi2/widgets/my_toolbar.dart';
import 'package:lucns_swapi2/dialogs/popup_menu.dart';

final SwapiStore myStore = SwapiStore();

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  UserController database = UserController();

  void _onBackPressed() {
    database.hasLoggedUser().then((value) {
      if (value) {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        } else {
          SystemNavigator.pop();
        }
      } else {
        database.close().then((value) => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen())));
      }
    });
  }

  void showMenuWindow() {
    PopupMenu popupMenu = PopupMenu(context: context);
    List<String> titles = [
      myStore.isDarkTheme ? "Tema claro" : "Tema escuro",
      "Sair"
    ];
    popupMenu.showMenu(popupMenu.generateIds(titles), (index) {
      switch (index) {
        case 0:
          myStore.isDarkTheme = !myStore.isDarkTheme;
          Utils.changeBarsColors(
              false,
              myStore.isDarkTheme,
              false,
              Brightness.light,
              myStore.isDarkTheme ? Brightness.light : Brightness.dark);
          Utils.setIsDarkTheme(myStore.isDarkTheme);
          break;
        case 1:
          database.logoutUser().then((value) {
            _onBackPressed();
          });
          break;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    database.close();
  }

  @override
  void initState() {
    myStore.isDarkTheme = Utils.isDarkTheme();
    Utils.changeBarsColors(false, myStore.isDarkTheme, false, Brightness.light,
        myStore.isDarkTheme ? Brightness.light : Brightness.dark);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async {
      _onBackPressed();
      return false;
    }, child: Observer(builder: (_) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: myStore.isDarkTheme
            ? AppColors.appBackgroundDark
            : AppColors.appBackground,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints.expand(height: 72),
                child: Container(
                  color: myStore.isDarkTheme
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
                        color: myStore.isDarkTheme
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
                      child: const MainScreenCards())),
            ],
          ),
        ),
      );
    }));
  }
}

class MainScreenCards extends StatefulWidget {
  const MainScreenCards({Key? key}) : super(key: key);

  @override
  MainScreenCardsState createState() => MainScreenCardsState();
}

class MainScreenCardsState extends State<MainScreenCards> {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Column(children: [
        Material(
            color: myStore.isDarkTheme
                ? AppColors.cardBackgroundDark
                : AppColors.cardBackground,
            elevation: 4,
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            child: InkWell(
                splashColor: AppColors.appBackground.withOpacity(0.4),
                highlightColor: AppColors.appBackground.withOpacity(0.4),
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                onTap: () {
                  _openListScreen(ListScreen.MOVIES);
                },
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
                  color: myStore.isDarkTheme
                      ? AppColors.cardBackgroundDark
                      : AppColors.cardBackground,
                  elevation: 4,
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  child: InkWell(
                      splashColor: AppColors.appBackground.withOpacity(0.4),
                      highlightColor: AppColors.appBackground.withOpacity(0.4),
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                      onTap: () {
                        _openListScreen(ListScreen.PERSONS);
                      },
                      child: Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.all(16),
                          constraints: const BoxConstraints.expand(height: 110),
                          child: _getHorizontalSmallCard(
                              "Personagens",
                              "Lista de personagens da saga.",
                              "persons_0.png"))))),
          const SizedBox(width: 16),
          Expanded(
              child: Material(
                  color: myStore.isDarkTheme
                      ? AppColors.cardBackgroundDark
                      : AppColors.cardBackground,
                  elevation: 4,
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  child: InkWell(
                      splashColor: AppColors.appBackground.withOpacity(0.4),
                      highlightColor: AppColors.appBackground.withOpacity(0.4),
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                      onTap: () {
                        _openListScreen(ListScreen.PLANETS);
                      },
                      child: Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.all(16),
                          constraints: const BoxConstraints.expand(height: 110),
                          child: _getHorizontalSmallCard("Planetas",
                              "Lista de planetas da saga.", "planet_0.png")))))
        ]),
      ]);
    });
  }

  Row _getHorizontalCard(String title, String description, String imageName) {
    return Row(children: [
      Align(
          alignment: Alignment.topLeft,
          child: Image(
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
                color: myStore.isDarkTheme
                    ? AppColors.textNormalDark
                    : AppColors.textNormal)),
        Text(description,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 14,
                color: myStore.isDarkTheme
                    ? AppColors.textNormalSecondaryDark
                    : AppColors.textNormalSecondary))
      ])),
    ]);
  }

  Row _getHorizontalSmallCard(
      String title, String description, String imageName) {
    return Row(children: [
      Align(
          alignment: Alignment.topLeft,
          child: Image(
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
                color: myStore.isDarkTheme
                    ? AppColors.textNormalDark
                    : AppColors.textNormal)),
        Flexible(
            child: Text(description,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 14,
                    color: myStore.isDarkTheme
                        ? AppColors.textNormalSecondaryDark
                        : AppColors.textNormalSecondary)))
      ])),
    ]);
  }

  void _openListScreen(int type) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => ListScreen(listType: type)));
  }
}
