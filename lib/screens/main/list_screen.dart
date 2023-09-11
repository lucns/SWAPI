// Developed by @lucns

// Tela da lista

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lucns_swapi/swapi_rest/swapi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:toast/toast.dart';

import 'package:lucns_swapi/utils/app_colors.dart';
import 'package:lucns_swapi/utils/utils.dart';
import 'package:lucns_swapi/dialogs/popup_menu.dart';
import 'package:lucns_swapi/views/my_toolbar.dart';

import 'main_screen.dart';

class ListScreen extends StatefulWidget {
  static const int MOVIES = 1;
  static const int PERSONS = 2;
  static const int PLANETS = 3;

  bool isDarkTheme;
  bool isUpdating = true;
  bool isConnected = true;
  bool isLoaded = false;
  bool isFailure = false;
  List<MyModel> contentList = [];
  final int listType;

  ListScreen({Key? key, required this.listType})
      : isDarkTheme = Utils.DARK_THEME,
        super(key: key);

  void setDarkTheme(bool isDarkTheme) {
    this.isDarkTheme = isDarkTheme;
  }

  @override
  ListScreenState createState() {
    return ListScreenState();
  }
}

class ListScreenState extends State<ListScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  StreamSubscription<ConnectivityResult>? subscription;
  bool isLoading = false;

  void showMenuWindow() {
    PopupMenu popupMenu = PopupMenu(context: context);
    List<String> titles = [
      widget.isDarkTheme ? "Tema claro" : "Tema escuro",
      "Atualizar lista"
    ];
    popupMenu.showMenu(popupMenu.generateIds(titles), (index) {
      switch (index) {
        case 0:
          setState(() {
            widget.isDarkTheme = !widget.isDarkTheme;
          });
          _prefs.then((SharedPreferences prefs) {
            prefs.setBool('is_dark_theme', widget.isDarkTheme);
          });
          Utils.changeBarsColors(
              false,
              widget.isDarkTheme,
              false,
              Brightness.light,
              widget.isDarkTheme ? Brightness.light : Brightness.dark);
          break;
        case 1:
          // update
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    ToastContext().init(context);
    Future.delayed(const Duration(milliseconds: 1000), () {
      Utils.changeBarsColors(false, widget.isDarkTheme, false, Brightness.light,
          widget.isDarkTheme ? Brightness.light : Brightness.dark);
    });
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() {
        widget.isConnected = result != ConnectivityResult.none;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (subscription != null) subscription!.cancel();
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
            false,
            widget.isDarkTheme,
            false,
            Brightness.light,
            widget.isDarkTheme ? Brightness.light : Brightness.dark);
      }
    });
    String title, type;
    switch (widget.listType) {
      case ListScreen.MOVIES:
        title = "Filmes";
        type = "filmes";
        break;
      case ListScreen.PERSONS:
        title = "Personagens";
        type = "personagens";
        break;
      default:
        title = "Planetas";
        type = "planetas";
        break;
    }
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainScreen()));
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
                    child: MyToolbar().getView(
                        context,
                        title,
                        () => {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainScreen(
                                          isDarkTheme: widget.isDarkTheme)))
                            }, () {
                      showMenuWindow();
                    }),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 24, top: 24, right: 24),
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Aqui estão os ${type} da franquia Star Wars.",
                          style: TextStyle(
                              color: widget.isDarkTheme
                                  ? AppColors.textNormalDark
                                  : AppColors.textNormal,
                              fontSize: 18),
                        ),
                        Text(widget.contentList.isEmpty ? "Quantidade: 0" : (isLoading ? "Quantidade: ${widget.contentList.length}, Carregando restante..." : "Quantidade: ${widget.contentList.length}"),
                          style: TextStyle(color: isLoading ? AppColors.red : AppColors.gray,
                              fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        //_generateListTest()
                        putContent()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget putContent() {
    if (!isLoading && !widget.isLoaded && !widget.isFailure) {
      isLoading = true;
      onListAvailable(List<MyModel> models) {
        if (models.isNotEmpty) {
          widget.contentList = models;
        }
        setState(() {
          if (models.isEmpty) {
            widget.isFailure = true;
          } else {
            widget.isLoaded = true;
          }
        });
      }

      onFinish() {
        if (!widget.isFailure) {
          String type;;
          switch (widget.listType) {
            case ListScreen.MOVIES:
              type = "filmes";
              break;
            case ListScreen.PERSONS:
              type = "personagens";
              break;
            default:
              type = "planetas";
              break;
          }

          Toast.show("Lista atualizada!", duration: Toast.lengthLong);
          Future.delayed(Duration(seconds: 3), () {
            Toast.show("${widget.contentList.length} ${type}", duration: Toast.lengthLong);
          });
        }
        setState(() {
          isLoading = false;
        });
      }

      onError() {
        setState(() {
          widget.isFailure = true;
          isLoading = false;
        });
      }

      Swapi swapi = Swapi();
      switch (widget.listType) {
        case ListScreen.MOVIES:
          swapi.requestFilms(onListAvailable, onFinish, onError);
          break;
        case ListScreen.PERSONS:
          swapi.requestPeoples(onListAvailable, onFinish, onError);
          break;
        default:
          swapi.requestPlanets(onListAvailable, onFinish, onError);
          break;
      }
    }

    return widget.isLoaded
        ? _generateListModels()
        : Expanded(
            child: Center(
                child: widget.isConnected && !widget.isFailure
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            SizedBox(
                                width: 36,
                                child: CircularProgressIndicator(
                                    color: widget.isDarkTheme ? Colors.white : AppColors.gray_4)),
                            const SizedBox(width: 16),
                            Text(
                              "Carregando...",
                              textAlign: TextAlign.start,
                              style: TextStyle(color: widget.isDarkTheme ? Colors.white : AppColors.gray_6),
                            )
                          ])
                    : Text(widget.isFailure ? "Falha na conexão!" :
                        "Sem conexão a internet!",
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      )));
  }

  Widget _generateListModels() {
    String imageName;
    switch (widget.listType) {
      case ListScreen.MOVIES:
        imageName = "movies.png";
        break;
      case ListScreen.PERSONS:
        imageName = "persons";
        break;
      default:
        imageName = "planet";
        break;
    }
    return Expanded(
        child: ListView.builder(
            itemCount: widget.contentList.length,
            itemBuilder: (context, i) {
              int index = i < 10 ? i : i % 10;
              return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: _getListItem(widget.contentList[i], widget.listType == ListScreen.MOVIES ? imageName : ("${imageName}_$index.png")));
            }));
  }

  Widget _getListItem(MyModel model, String imageName) {
    return Material(
        color: widget.isDarkTheme
            ? AppColors.cardBackgroundDark
            : AppColors.cardBackground,
        elevation: 4,
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        child: InkWell(
            splashColor: AppColors.appBackground.withOpacity(0.4),
            highlightColor: AppColors.appBackground.withOpacity(0.4),
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            onTap: () {
              Toast.show("${model.textTopStart} clicked!", duration: Toast.lengthShort);
            },
            child: Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(16),
                //constraints: const BoxConstraints.expand(height: 70),
                child: _getListItem2(model, imageName))));
  }

  Widget _getListItem2(MyModel model, String imageName) {
    return Column(children: [
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
                image: ResizeImage(AssetImage("assets/images/${imageName}"),
                    width: 40, height: 40)),
            const SizedBox(width: 10),
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(model.textTopStart,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 18,
                            color: widget.isDarkTheme
                                ? AppColors.textNormalDark
                                : AppColors.textNormal))),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(model.textCenterStart,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14,
                            color: widget.isDarkTheme
                                ? AppColors.textNormalSecondaryDark
                                : AppColors.textNormalSecondary))),
              ],
            ))
          ]),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Align(
              alignment: Alignment.topLeft,
              child: Text(model.textBottomStart,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14,
                      color: widget.isDarkTheme
                          ? AppColors.textNormalDark
                          : AppColors.textNormal))),
          Align(
              alignment: Alignment.bottomLeft,
              child: Text(model.textBottomEnd,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14,
                      color: widget.isDarkTheme
                          ? AppColors.textNormalSecondaryDark
                          : AppColors.textNormalSecondary))),
        ],
      )
    ]);
  }
}
