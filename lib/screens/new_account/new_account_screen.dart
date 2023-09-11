// Developed by @lucns

// Tela de cadastro de novos usuários

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:lucns_swapi/views/my_text_field.dart';
import 'package:lucns_swapi/views/my_button.dart';
import 'package:lucns_swapi/views/my_toolbar.dart';
import 'package:lucns_swapi/screens/login/login_screen.dart';
import 'package:lucns_swapi/utils/app_colors.dart';
import 'package:lucns_swapi/utils/utils.dart';
import 'package:lucns_swapi/dialogs/popup_menu.dart';
import 'package:lucns_swapi/screens/new_account/new_account_backend.dart';

import 'package:shared_preferences/shared_preferences.dart';

class NewAccountScreen extends StatefulWidget {
  bool isDarkTheme;

  NewAccountScreen({Key? key})
      : isDarkTheme = Utils.DARK_THEME,
        super(key: key);

  @override
  NewAccountScreenState createState() => NewAccountScreenState();
}

class NewAccountScreenState extends State<NewAccountScreen> {
  NewAccountBackend? newAccountBackend;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void showMenuWindow() {
    PopupMenu popupMenu = PopupMenu(context: context);
    List<String> titles = [widget.isDarkTheme ? "Tema claro" : "Tema escuro"];
    popupMenu.showMenu(popupMenu.generateIds(titles), (index) {
      setState(() {
        widget.isDarkTheme = !widget.isDarkTheme;
      });
      Utils.DARK_THEME = widget.isDarkTheme;
      Utils.changeBarsColors(false, widget.isDarkTheme, false, Brightness.light, widget.isDarkTheme ? Brightness.light : Brightness.dark);
      _prefs.then((SharedPreferences prefs) {
        prefs.setBool('is_dark_theme', widget.isDarkTheme);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      newAccountBackend!.initializeSystem();
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      Utils.changeBarsColors(false, widget.isDarkTheme, false, Brightness.light,
          widget.isDarkTheme ? Brightness.light : Brightness.dark);
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
        Utils.changeBarsColors(false, widget.isDarkTheme, false, Brightness.light, widget.isDarkTheme ? Brightness.light : Brightness.dark);
      }
    });


    MyFieldText nameFieldText = MyFieldText(
        isDarkTheme: widget.isDarkTheme,
        fixedText: "Nome",
        textCapitalization: TextCapitalization.words,
        action: TextInputAction.next,
        inputType: TextInputType.text,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"))
        ]);
    MyFieldText userFieldText = MyFieldText(
        isDarkTheme: widget.isDarkTheme,
        fixedText: "CPF",
        action: TextInputAction.next,
        inputFormatters: [CpfFormatter()],
        inputType: TextInputType.number);
    MyFieldText passwordFieldText = MyFieldText(
        isDarkTheme: widget.isDarkTheme,
        fixedText: "Senha",
        action: TextInputAction.done,
        inputType: TextInputType.visiblePassword);
    MyButton button =
        MyButton(textButton: "Criar conta", isDarkTheme: widget.isDarkTheme);

    newAccountBackend = NewAccountBackend(context: context);
    newAccountBackend!
        .setWidgets(nameFieldText, userFieldText, passwordFieldText, button);

    return WillPopScope(
        onWillPop: () async {
          Utils.changeBarsColors(
              false,
              widget.isDarkTheme,
              true,
              widget.isDarkTheme ? Brightness.light : Brightness.dark,
              Brightness.light);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
                    child: MyToolbar().getView(context, "Nova Conta", () {
                      Utils.changeBarsColors(
                          false,
                          widget.isDarkTheme,
                          true,
                          widget.isDarkTheme
                              ? Brightness.light
                              : Brightness.dark,
                          Brightness.light);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
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
                    child: Column(
                      children: [
                        const SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                "Todos os campos são obrigatorios.",
                                style: TextStyle(
                                    color: AppColors.red, fontSize: 14),
                              ),
                            )),
                        const SizedBox(
                          height: 16,
                        ),
                        nameFieldText,
                        const SizedBox(
                          height: 16,
                        ),
                        userFieldText,
                        const SizedBox(
                          height: 16,
                        ),
                        passwordFieldText,
                        const SizedBox(height: 20),
                        button,
                        const SizedBox(height: 20),
                        //MyButton(textButton: "Testar", onClick: () => {newAccountBackend.checkUserExists()},),
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
