// Developed by @lucns

//import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lucns_swapi2/controllers/new_account_controller.dart';
import 'package:lucns_swapi2/store/swapi_store.dart';

import 'package:lucns_swapi2/widgets/my_text_field.dart';
import 'package:lucns_swapi2/widgets/my_button.dart';
import 'package:lucns_swapi2/pages/login_screen.dart';
import 'package:lucns_swapi2/utils/app_colors.dart';
import 'package:lucns_swapi2/utils/utils.dart';
import 'package:lucns_swapi2/dialogs/popup_menu.dart';
import 'package:lucns_swapi2/widgets/my_toolbar.dart';

class NewAccountScreen extends StatefulWidget {
  const NewAccountScreen({Key? key}) : super(key: key);

  @override
  NewAccountScreenState createState() => NewAccountScreenState();
}

class NewAccountScreenState extends State<NewAccountScreen> {
  final SwapiStore myStore = SwapiStore();
  late NewAccountController newAccountController;

  void showMenuWindow() {
    PopupMenu popupMenu = PopupMenu(context: context);
    List<String> titles = [myStore.isDarkTheme ? "Tema claro" : "Tema escuro"];
    popupMenu.showMenu(popupMenu.generateIds(titles), (index) {
      myStore.isDarkTheme = !myStore.isDarkTheme;
      Utils.changeBarsColors(
          false,
          myStore.isDarkTheme,
          false,
          Brightness.light,
          myStore.isDarkTheme ? Brightness.light : Brightness.dark);
      Utils.setIsDarkTheme(myStore.isDarkTheme);
    });
  }

  @override
  void initState() {
    newAccountController = NewAccountController(context);
    myStore.isDarkTheme = Utils.isDarkTheme();
    Utils.changeBarsColors(false, myStore.isDarkTheme, false, Brightness.light,
        myStore.isDarkTheme ? Brightness.light : Brightness.dark);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
      return false;
    }, child: Observer(builder: (_) {
      MyFieldText nameFieldText = MyFieldText(
          isDarkTheme: myStore.isDarkTheme,
          hintText: "Nome",
          textCapitalization: TextCapitalization.words,
          action: TextInputAction.next,
          inputType: TextInputType.text,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"))
          ]);
      MyFieldText userFieldText = MyFieldText(
          isDarkTheme: myStore.isDarkTheme,
          hintText: "CPF",
          action: TextInputAction.next,
          inputFormatters: [CpfFormatter()],
          inputType: TextInputType.number);
      MyFieldText passwordFieldText = MyFieldText(
          isDarkTheme: myStore.isDarkTheme,
          hintText: "Senha",
          action: TextInputAction.done,
          inputType: TextInputType.visiblePassword);
      MyButton button = MyButton(
          textButton: "Criar conta",
          isDarkTheme: myStore.isDarkTheme,
          isEnabled: false);

      newAccountController = NewAccountController(context);
      newAccountController.setWidgets(
          nameFieldText, userFieldText, passwordFieldText, button);
      newAccountController.initializeSystem();

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
                  child: MyToolbar().getView(context, "Nova Conta", () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
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
                  child: Column(
                    children: [
                      const SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              "Todos os campos são obrigatorios.",
                              style:
                                  TextStyle(color: AppColors.red, fontSize: 14),
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
      );
    }));
  }
}
