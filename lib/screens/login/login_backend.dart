// @developed by @lucns

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

import 'package:lucns_swapi/utils/utils.dart';
import 'package:lucns_swapi/views/my_text_field.dart';
import 'package:lucns_swapi/views/my_button_transparent.dart';
import 'package:lucns_swapi/views/my_text.dart';
import 'package:lucns_swapi/views/my_button.dart';
import 'package:lucns_swapi/screens/forgotten_password/forgotten_password_screen.dart';
import 'package:lucns_swapi/screens/new_account/new_account_screen.dart';
import 'package:lucns_swapi/dialogs/my_dialogs.dart';
import 'package:lucns_swapi/database/user_controller.dart';
import 'package:lucns_swapi/utils/annotator.dart';
import 'package:lucns_swapi/screens/main/main_screen.dart';

class LoginBackend {
  final BuildContext context;
  MyFieldText? userFieldText, passwordFieldText;
  MyText? textForgottenPassword, textInvalidData;
  MyButton? button;
  MyButtonTransparent? buttonTransparent;
  late Dialogs dialog;

  LoginBackend(this.context) {
    dialog = Dialogs(context: context);
  }

  void setWidgets(userFieldText, passwordFieldText, textForgottenPassword,
      textInvalidData, button, buttonTransparent) {
    this.userFieldText = userFieldText;
    this.passwordFieldText = passwordFieldText;
    this.textForgottenPassword = textForgottenPassword;
    this.textInvalidData = textInvalidData;
    this.button = button;
    this.buttonTransparent = buttonTransparent;
  }

  void initializeSystem() {
    ToastContext().init(context);

    userFieldText!.setOnTextChangedListener((String text) {
      if (userFieldText!.isEnabled()) {
        textInvalidData!.setText("");
        _changeButton();
      }
    });

    passwordFieldText!.setOnTextChangedListener((String text) {
      if (passwordFieldText!.isEnabled()) {
        textInvalidData!.setText("");
        _changeButton();
      }
    });

    textForgottenPassword!.setOnClickListener(() {
      _openForgottenPasswordScreen();
    });

    buttonTransparent!.setOnClickListener(() => {_openNewAccountScreen()});
    // Future.delayed(const Duration(milliseconds: 1000),() => {});
  }

  void _changeButton() {
    String textUser = userFieldText!.getText();
    String textPassword = passwordFieldText!.getText();
    if (textUser.length == 14 && textPassword.length > 3) {
      button!.setOnClickListener(() {
        button!.setText("Acessando...");
        userFieldText!.setEnabled(false);
        passwordFieldText!.setEnabled(false);
        textForgottenPassword!.setEnabled(false);
        button!.setOnClickListener(null);
        buttonTransparent!.setOnClickListener(null);

        dialog.showIndeterminateDialog("Acesando...");
        Utils.changeBarsColors(true, Utils.DARK_THEME, true, Brightness.light,
            Utils.DARK_THEME ? Brightness.light : Brightness.dark);
        _checkUserExists(textUser, textPassword);
      });
    } else {
      button!.setOnClickListener(null);
    }
  }

  void _checkUserExists(String cpf, String password) async {
    UserController controller = UserController();
    User? user = await controller.getUsers().then((value) {
      for (User user in value) {
        if (user.cpf == cpf) return user;
      }
      return null;
    });
    Future.delayed(const Duration(seconds: 1), () {
      dialog.dismiss();
      Utils.changeBarsColors(false, Utils.DARK_THEME, true,
          Utils.DARK_THEME ? Brightness.light : Brightness.dark, Brightness.light);

      if (user == null) {
        Toast.show("CPF inválido", duration: Toast.lengthLong);
        button!.setText("Acessar");
        textInvalidData!.setText("Usuário não encontrado");
        userFieldText!.setEnabled(true);
        passwordFieldText!.setEnabled(true);
        textForgottenPassword!.setEnabled(true);
        buttonTransparent!.setOnClickListener(() => {_openNewAccountScreen()});
        _changeButton();
      } else if (user.password == password) {
        controller.selectUser(user);
        Utils.changeBarsColors(false, Utils.DARK_THEME, false, Brightness.light, Utils.DARK_THEME ? Brightness.light : Brightness.dark);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MainScreen(isDarkTheme: Utils.DARK_THEME)));
      } else {
        Toast.show("Senha inválida", duration: Toast.lengthLong);
        button!.setText("Acessar");
        textInvalidData!.setText("Senha inválida");
        userFieldText!.setEnabled(true);
        passwordFieldText!.setEnabled(true);
        textForgottenPassword!.setEnabled(true);
        buttonTransparent!.setOnClickListener(() => {_openNewAccountScreen()});
        _changeButton();
      }
    });
  }

  void _openForgottenPasswordScreen() {
    Utils.changeBarsColors(false, Utils.DARK_THEME, false, Brightness.light, Utils.DARK_THEME ? Brightness.light : Brightness.dark);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ForgottenPasswordScreen()));
  }

  void _openNewAccountScreen() {
    Utils.changeBarsColors(false, Utils.DARK_THEME, false, Brightness.light, Utils.DARK_THEME ? Brightness.light : Brightness.dark);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => NewAccountScreen()));
  }
}
