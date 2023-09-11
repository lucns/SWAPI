// Developed by @lucns

// Fragmento da tela de login onde estão os campos de texto e botoes

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:lucns_swapi/utils/app_colors.dart';
import 'package:lucns_swapi/utils/utils.dart';
import 'package:lucns_swapi/views/my_text_field.dart';
import 'package:lucns_swapi/views/my_button.dart';
import 'package:lucns_swapi/views/my_text.dart';
import 'package:lucns_swapi/screens/login/login_backend.dart';
import 'package:lucns_swapi/views/my_button_transparent.dart';

class FragmentHigher extends StatefulWidget {
  bool isDarkTheme;
  final FragmentHigherState widgetState;

  FragmentHigher({Key? key, required this.isDarkTheme}) : widgetState = FragmentHigherState(), super(key: key);

  void setDarkTheme(bool isDarkTheme) {
    this.isDarkTheme = isDarkTheme;
    widgetState.setDarkTheme(isDarkTheme);
  }

  @override
  FragmentHigherState createState() {
    return widgetState;
  }
}

class FragmentHigherState extends State<FragmentHigher> {

  LoginBackend? loginBackend;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loginBackend!.initializeSystem();
    });
  }

  void setDarkTheme(bool isDarkTheme) {
    setState(() {
      widget.isDarkTheme = isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness:
          widget.isDarkTheme ? Brightness.light : Brightness.dark,
      statusBarColor: widget.isDarkTheme
          ? AppColors.fragmentBackgroundDark
          : AppColors.fragmentBackground,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor: widget.isDarkTheme
          ? AppColors.appBackgroundDark
          : AppColors.appBackground,
      systemNavigationBarDividerColor: null,
    ));
    loginBackend = LoginBackend(context);
    MyButton button = MyButton(
      textButton: "Acessar",
      isDarkTheme: widget.isDarkTheme,
    );
    MyText textForgottenPassword =
        MyText(text: "Esqueci minha senha", isDarkTheme: widget.isDarkTheme);
    MyButtonTransparent buttonTransparent = MyButtonTransparent(
        isDarkTheme: widget.isDarkTheme, textButton: "Primeiro acesso");
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
    MyText textInvalidData = MyText(
        text: " ",
        style: const TextStyle(
          color: AppColors.red,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.left);

    loginBackend!.setWidgets(userFieldText, passwordFieldText,
        textForgottenPassword, textInvalidData, button, buttonTransparent);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 24.0),
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: widget.isDarkTheme
            ? AppColors.fragmentBackgroundDark
            : AppColors.fragmentBackground,
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(56), bottomLeft: Radius.circular(56)),
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
        children: [
          MyText(
          text: "Acesso",
          style: TextStyle(
            color: widget.isDarkTheme ? AppColors.white_3 : AppColors.gray_8,
            fontSize: 48,
            fontWeight: FontWeight.w200,
          ),
          textAlign: TextAlign.center),
          const SizedBox(height: 8),
          SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: textInvalidData,
              )),
          const SizedBox(height: 8),
          userFieldText,
          const SizedBox(height: 16),
          passwordFieldText,
          const SizedBox(height: 8),
          SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: textForgottenPassword,
              )),
          const SizedBox(height: 20),
          button,
          const SizedBox(height: 16),
          buttonTransparent
        ],
      ),
    );
  }
}
