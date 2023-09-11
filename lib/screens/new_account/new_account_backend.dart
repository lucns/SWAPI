// @developed by @lucns

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lucns_swapi/utils/utils.dart';
import 'package:toast/toast.dart';

import 'package:lucns_swapi/views/my_text_field.dart';
import 'package:lucns_swapi/dialogs/my_dialogs.dart';
import 'package:lucns_swapi/views/my_button.dart';
import 'package:lucns_swapi/screens/login/login_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:lucns_swapi/database/user_controller.dart';

class NewAccountBackend {
  final BuildContext context;
  MyFieldText? nameFieldText, userFieldText, passwordFieldText;
  MyButton? button;
  Dialogs dialog;

  NewAccountBackend({required this.context})
      : dialog = Dialogs(context: context);

  void setWidgets(nameFieldText, userFieldText, passwordFieldText, button) {
    this.nameFieldText = nameFieldText;
    this.userFieldText = userFieldText;
    this.passwordFieldText = passwordFieldText;
    this.button = button;
  }

  void initializeSystem() {
    ToastContext().init(context);

    userFieldText!.setOnTextChangedListener((String text) {
      if (userFieldText!.isEnabled()) _changeButton();
    });

    nameFieldText!.setOnTextChangedListener((String text) {
      if (nameFieldText!.isEnabled()) _changeButton();
    });

    passwordFieldText!.setOnTextChangedListener((String text) {
      if (passwordFieldText!.isEnabled()) _changeButton();
    });
  }

  void _changeButton() {
    String user = userFieldText!.getText();
    String pass = passwordFieldText!.getText();
    String name = nameFieldText!.getText();

    if (name.isNotEmpty && user.length == 14 && pass.length > 3) {
      button!.setOnClickListener(() => {
            button!.setText("Criando..."),
            userFieldText!.setEnabled(false),
            passwordFieldText!.setEnabled(false),
            nameFieldText!.setEnabled(false),
            button!.setOnClickListener(null),
            _checkUserExists(user, pass, name)
          });
    } else {
      button!.setOnClickListener(null);
    }
  }

  void _checkUserExists(String cpf, String pass, String username) async {
    Utils.changeBarsColors(true, Utils.DARK_THEME, false, Brightness.light, Brightness.light);
    dialog.showIndeterminateDialog("Verificando se usuario ja existe...");

    UserController controller = UserController();
    bool userExists = await controller.getUsers().then((value) {
      for (User user in value) {
        if (user.cpf == cpf) return true;
      }
      return false;
    });

    Future.delayed(const Duration(seconds: 1), () {
      // delay apenas pra mostrar o dialog "Verificando se usuario ja existe..."
      if (userExists) {
        Utils.changeBarsColors(
            false, Utils.DARK_THEME, false, Brightness.light, Utils.DARK_THEME ? Brightness.light : Brightness.dark);
        dialog.dismiss();
        Toast.show("Usuario já existe!", duration: Toast.lengthLong);
        Future.delayed(const Duration(seconds: 1), () {
          Toast.show("Tente outro CPF!", duration: Toast.lengthLong);
        });
        button!.setText("Criar conta");

        nameFieldText!.setEnabled(true);
        userFieldText!.setEnabled(true);
        passwordFieldText!.setEnabled(true);
        _changeButton();
        return;
      }
      _createNewUser(cpf, pass, username);
    });
  }

  void _createNewUser(String cpf, String pass, String username) {
    dialog.setTextTitle("Criando nova conta de usuario...");
    UserController().registerUser(User(username, cpf, pass));
    Future.delayed(const Duration(seconds: 1), () {
      Utils.changeBarsColors(
          false,
          Utils.DARK_THEME,
          true,
          Utils.DARK_THEME ? Brightness.light : Brightness.dark,
          Brightness.light);
      dialog.dismiss();
      button!.setText("Conta Criada");
      /*
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Conta criada")
        )),
               */
      Toast.show("Conta criada", duration: Toast.lengthLong);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen()));
    });
  }
}
