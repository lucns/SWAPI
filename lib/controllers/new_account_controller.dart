// @developed by @lucns

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lucns_swapi2/models/app_user.dart';
import 'package:toast/toast.dart';

import 'package:lucns_swapi2/widgets/my_text_field.dart';
import 'package:lucns_swapi2/dialogs/my_dialogs.dart';
import 'package:lucns_swapi2/widgets/my_button.dart';
import 'package:lucns_swapi2/pages/login_screen.dart';
import 'package:lucns_swapi2/controllers/user_controller2.dart';
import 'package:lucns_swapi2/utils/utils.dart';

class NewAccountController {
  final BuildContext context;
  MyFieldText? nameFieldText, userFieldText, passwordFieldText;
  MyButton? button;
  late Dialogs dialog;

  NewAccountController(this.context) {
    dialog = Dialogs(context);
  }

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
      button!.setOnClickListener(() {
        button!.setText("Criando...");
        userFieldText!.setEnabled(false);
        passwordFieldText!.setEnabled(false);
        nameFieldText!.setEnabled(false);
        button!.setEnabled(false);
        _checkUserExists(user, pass, name);
      });
      button!.setEnabled(true);
    } else {
      button!.setEnabled(false);
    }
  }

  void _checkUserExists(String cpf, String pass, String username) async {
    bool isDarkTheme = Utils.isDarkTheme();
    Utils.changeBarsColors(
        true, isDarkTheme, false, Brightness.light, Brightness.light);
    dialog.showIndeterminateDialog("Verificando se usuario ja existe...");

    UserController controller = UserController();
    bool userExists = await controller.getUsers().then((value) {
      for (AppUser user in value) {
        if (user.cpf == cpf) return true;
      }
      return false;
    });
    controller.close();

    Future.delayed(const Duration(seconds: 1), () {
      // delay apenas pra mostrar o dialog "Verificando se usuario ja existe..."
      if (userExists) {
        Utils.changeBarsColors(false, isDarkTheme, false, Brightness.light,
            isDarkTheme ? Brightness.light : Brightness.dark);
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
    UserController user = UserController();
    //user.printUsers();
    user
        .registerUser(AppUser(username, cpf, pass))
        .then((value) => user.close());
    //user.printUsers();
    user.close();

    Future.delayed(const Duration(seconds: 1), () {
      bool isDarkTheme = Utils.isDarkTheme();
      Utils.changeBarsColors(false, isDarkTheme, true,
          isDarkTheme ? Brightness.light : Brightness.dark, Brightness.light);
      dialog.dismiss();
      button!.setText("Conta Criada");
      /*
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Conta criada")
        )),
               */
      Toast.show("Conta criada", duration: Toast.lengthLong);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    });
  }
}
