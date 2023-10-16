// @developed by @lucns

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lucns_swapi2/pages/main_screen.dart';
import 'package:toast/toast.dart';

import 'package:lucns_swapi2/utils/utils.dart';
import 'package:lucns_swapi2/widgets/my_text_field.dart';
import 'package:lucns_swapi2/widgets/my_button_transparent.dart';
import 'package:lucns_swapi2/widgets/my_text.dart';
import 'package:lucns_swapi2/widgets/my_button.dart';
import 'package:lucns_swapi2/pages/forgotten_password_screen.dart';
import 'package:lucns_swapi2/pages/new_account_screen.dart';
import 'package:lucns_swapi2/dialogs/my_dialogs.dart';
import 'package:lucns_swapi2/controllers/user_controller2.dart';
import 'package:lucns_swapi2/models/app_user.dart';
//import 'package:lucns_swapi2/pages/main_screen.dart';

class LoginController {
  final BuildContext context;
  MyFieldText? userFieldText, passwordFieldText;
  MyText? textForgottenPassword, textInvalidData;
  MyButton? button;
  MyButtonTransparent? buttonTransparent;
  late Dialogs dialog;

  LoginController(this.context) {
    dialog = Dialogs(context);
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
        button!.setEnabled(false);
        buttonTransparent!.setEnabled(false);

        bool isDarkTheme = Utils.isDarkTheme();
        Utils.changeBarsColors(true, isDarkTheme, true, Brightness.light,
            isDarkTheme ? Brightness.light : Brightness.dark);
        dialog.showIndeterminateDialog("Acesando...");
        _checkUserExists(textUser, textPassword);
        return;
      });
      button!.setEnabled(true);
      buttonTransparent!.setEnabled(true);
    } else {
      buttonTransparent!.setEnabled(true);
      button!.setEnabled(false);
    }
  }

  void _checkUserExists(String cpf, String password) async {
    UserController controller = UserController();
    AppUser user = await controller.getUsers().then((value) {
      for (AppUser user in value) {
        if (user.cpf == cpf) return user;
      }
      return AppUser("", "", "");
    });
    Future.delayed(const Duration(seconds: 1), () {
      dialog.dismiss();
      bool isDarkTheme = Utils.isDarkTheme();
      Utils.changeBarsColors(false, isDarkTheme, true,
          isDarkTheme ? Brightness.light : Brightness.dark, Brightness.light);

      if (user.cpf.isEmpty) {
        Toast.show("CPF inválido", duration: Toast.lengthLong);
        button!.setText("Acessar");
        textInvalidData!.setText("Usuário não encontrado");
        userFieldText!.setEnabled(true);
        passwordFieldText!.setEnabled(true);
        textForgottenPassword!.setEnabled(true);
        buttonTransparent!.setEnabled(true);
        _changeButton();
      } else if (user.password == password) {
        controller.loginUser(user.cpf).then((value) {
          controller.close().then((value) => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const MainScreen())));
        });
        return;
      } else {
        Toast.show("Senha inválida", duration: Toast.lengthLong);
        button!.setText("Acessar");
        textInvalidData!.setText("Senha inválida");
        userFieldText!.setEnabled(true);
        passwordFieldText!.setEnabled(true);
        textForgottenPassword!.setEnabled(true);
        buttonTransparent!.setEnabled(true);
        _changeButton();
      }
      controller.close();
    });
  }

  void _openForgottenPasswordScreen() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => ForgottenPasswordScreen()));
  }

  void _openNewAccountScreen() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const NewAccountScreen()));
  }
}
