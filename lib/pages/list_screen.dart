// Developed by @lucns

// Tela da lista

import 'dart:async';
//import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lucns_swapi2/models/sw_item_base.dart';
import 'package:lucns_swapi2/store/swapi_store.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:toast/toast.dart';

import 'package:lucns_swapi2/utils/app_colors.dart';
import 'package:lucns_swapi2/utils/utils.dart';
import 'package:lucns_swapi2/dialogs/popup_menu.dart';
import 'package:lucns_swapi2/widgets/my_toolbar.dart';
import 'main_screen.dart';

class ListScreen extends StatefulWidget {
  static const int MOVIES = 1;
  static const int PERSONS = 2;
  static const int PLANETS = 3;

  final int listType;

  ListScreen({Key? key, required this.listType}) : super(key: key);

  @override
  ListScreenState createState() {
    return ListScreenState();
  }
}

class ListScreenState extends State<ListScreen> {
  final SwapiStore myStore = SwapiStore();
  StreamSubscription<ConnectivityResult>? subscription;

  void showMenuWindow() {
    PopupMenu popupMenu = PopupMenu(context: context);
    List<String> titles = [
      myStore.isDarkTheme ? "Tema claro" : "Tema escuro",
      "Atualizar lista"
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
          // update
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    myStore.isDarkTheme = Utils.isDarkTheme();
    Utils.changeBarsColors(false, myStore.isDarkTheme, false, Brightness.light,
        myStore.isDarkTheme ? Brightness.light : Brightness.dark);
    ToastContext().init(context);
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      myStore.isConnected = result != ConnectivityResult.none;
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (subscription != null) subscription!.cancel();
  }

  @override
  Widget build(BuildContext context) {
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
    return WillPopScope(onWillPop: () async {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MainScreen()));
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
                  child: MyToolbar().getView(
                      context,
                      title,
                      () => {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MainScreen()))
                          }, () {
                    showMenuWindow();
                  }),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 24, top: 24, right: 24),
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Aqui estão os ${type} da franquia Star Wars.",
                        style: TextStyle(
                            color: myStore.isDarkTheme
                                ? AppColors.textNormalDark
                                : AppColors.textNormal,
                            fontSize: 18),
                      ),
                      Text(
                        myStore.contentList.isEmpty
                            ? "Quantidade: 0"
                            : (myStore.isLoading
                                ? "Quantidade: ${myStore.contentList.length}, Carregando restante..."
                                : "Quantidade: ${myStore.contentList.length}"),
                        style: TextStyle(
                            color: myStore.isLoading
                                ? AppColors.red
                                : AppColors.gray,
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
      );
    }));
  }

  Widget putContent() {
    if (!myStore.isLoaded &&
        !myStore.isLoading &&
        !myStore.isFailure &&
        myStore.isConnected) {
      myStore.requestListContent(widget.listType);
    } else if (myStore.isLoaded) {
      if (!myStore.isFailure) {
        String type;
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
        if (myStore.isComplete) {
          /*
          Toast.show("Lista atualizada!", duration: Toast.lengthLong);
          Future.delayed(const Duration(seconds: 5), () {
            Toast.show("${myStore.contentList.length} ${type}",
                duration: Toast.lengthLong);
          });
          */
        }
      }
    }

    return Observer(builder: (_) {
      return myStore.isLoaded
          ? _generateListModels()
          : Expanded(
              child: Center(
                  child: myStore.isConnected && !myStore.isFailure
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                              SizedBox(
                                  width: 36,
                                  child: CircularProgressIndicator(
                                      color: myStore.isDarkTheme
                                          ? Colors.white
                                          : AppColors.gray_4)),
                              const SizedBox(width: 16),
                              Text(
                                "Carregando...",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: myStore.isDarkTheme
                                        ? Colors.white
                                        : AppColors.gray_6),
                              )
                            ])
                      : Text(
                          myStore.isFailure
                              ? "Falha na conexão!"
                              : "Sem conexão a internet!",
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red))));
    });
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
            itemCount: myStore.contentList.length,
            itemBuilder: (context, i) {
              int index = i < 10 ? i : i % 10;
              return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: _getListItem(
                      myStore.contentList[i],
                      widget.listType == ListScreen.MOVIES
                          ? imageName
                          : ("${imageName}_$index.png")));
            }));
  }

  Widget _getListItem(MyModel model, String imageName) {
    return Observer(builder: (_) {
      return Material(
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
                Toast.show("${model.textTopStart} clicked!",
                    duration: Toast.lengthShort);
              },
              child: Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(16),
                  //constraints: const BoxConstraints.expand(height: 70),
                  child: _getListItem2(model, imageName))));
    });
  }

  Widget _getListItem2(MyModel model, String imageName) {
    return Observer(builder: (_) {
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
                              color: myStore.isDarkTheme
                                  ? AppColors.textNormalDark
                                  : AppColors.textNormal))),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(model.textCenterStart,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14,
                              color: myStore.isDarkTheme
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
                        color: myStore.isDarkTheme
                            ? AppColors.textNormalDark
                            : AppColors.textNormal))),
            Align(
                alignment: Alignment.bottomLeft,
                child: Text(model.textBottomEnd,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        color: myStore.isDarkTheme
                            ? AppColors.textNormalSecondaryDark
                            : AppColors.textNormalSecondary))),
          ],
        )
      ]);
    });
  }
}
