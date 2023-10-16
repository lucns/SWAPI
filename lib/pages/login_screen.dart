// @developed by @lucns

//import 'dart:developer';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:lucns_swapi2/controllers/login_controller.dart';
import 'package:lucns_swapi2/store/swapi_store.dart';
import 'package:lucns_swapi2/widgets/my_text_field.dart';
import 'package:lucns_swapi2/widgets/my_button.dart';
import 'package:lucns_swapi2/widgets/my_text.dart';
import 'package:lucns_swapi2/widgets/my_button_transparent.dart';
import 'package:lucns_swapi2/utils/app_colors.dart';
import 'package:lucns_swapi2/utils/utils.dart';

final SwapiStore myStore = SwapiStore();

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  Timer? timer;
  _FragmentHigher fragmentHigher = _FragmentHigher();

  void _scheduleOpacity() {
    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer(const Duration(milliseconds: 1500), () {
      if (myStore.imageOpacityGo) {
        myStore.imageOpacityGo = false;
      } else {
        myStore.imageOpacityGo = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    myStore.isDarkTheme = Utils.isDarkTheme();
    Utils.changeBarsColors(
        false,
        myStore.isDarkTheme,
        true,
        myStore.isDarkTheme ? Brightness.light : Brightness.dark,
        Brightness.light);
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null) {
      timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      _scheduleOpacity();

      Utils.changeBarsColors(
          false,
          myStore.isDarkTheme,
          true,
          myStore.isDarkTheme ? Brightness.light : Brightness.dark,
          Brightness.light);

      return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: myStore.isDarkTheme
              ? AppColors.appBackgroundDark
              : AppColors.appBackground,
          body: Column(children: [
            fragmentHigher ?? const SizedBox(),
            Expanded(
                child: SizedBox(
                    width: double.infinity,
                    child: DecoratedBox(
                        decoration:
                            const BoxDecoration(color: Colors.transparent),
                        child: Stack(children: [
                          Align(
                              alignment: Alignment.center,
                              child: AnimatedOpacity(
                                  opacity: myStore.imageOpacityGo ? 1 : 0.3,
                                  duration: const Duration(milliseconds: 1000),
                                  child: Image(
                                      image: ResizeImage(
                                          AssetImage(myStore.isDarkTheme
                                              ? 'assets/images/sw_logo_dark.png'
                                              : 'assets/images/sw_logo_white.png'),
                                          width: 100,
                                          height: 44)))),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Text("Desafio SWAPI",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: myStore.isDarkTheme
                                          ? Colors.white
                                          : Colors.black))),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: RawMaterialButton(
                                  onPressed: () {
                                    myStore.isDarkTheme = !myStore.isDarkTheme;
                                    Utils.setIsDarkTheme(myStore.isDarkTheme);
                                  },
                                  elevation: 0,
                                  constraints: const BoxConstraints(),
                                  shape: const CircleBorder(),
                                  fillColor: Colors.transparent,
                                  splashColor: Colors.white.withOpacity(0.4),
                                  highlightColor: Colors.white.withOpacity(0.4),
                                  highlightElevation: 0,
                                  padding: const EdgeInsets.all(16),
                                  child: Icon(
                                      myStore.isDarkTheme
                                          ? Icons.brightness_5
                                          : Icons.brightness_4,
                                      size: 28,
                                      color: myStore.isDarkTheme
                                          ? Colors.white.withOpacity(0.75)
                                          : Colors.white)))
                        ]))))
          ]));
    });
  }
}

class _FragmentHigher extends StatefulWidget {
  const _FragmentHigher({Key? key}) : super(key: key);

  @override
  _FragmentHigherState createState() => _FragmentHigherState();
}

class _FragmentHigherState extends State<_FragmentHigher> {
  late LoginController loginController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      MyButton button = MyButton(
        textButton: "Acessar",
        isDarkTheme: myStore.isDarkTheme,
        isEnabled: false,
      );
      MyText textForgottenPassword =
          MyText(text: "Esqueci minha senha", isDarkTheme: myStore.isDarkTheme);
      MyButtonTransparent buttonTransparent = MyButtonTransparent(
          isDarkTheme: myStore.isDarkTheme, textButton: "Primeiro acesso");
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
      MyText textInvalidData = MyText(
          text: " ",
          style: const TextStyle(
            color: AppColors.red,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.left);

      loginController = LoginController(context);
      loginController.setWidgets(userFieldText, passwordFieldText,
          textForgottenPassword, textInvalidData, button, buttonTransparent);
      loginController.initializeSystem();

      return Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 24.0),
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: myStore.isDarkTheme
              ? AppColors.fragmentBackgroundDark
              : AppColors.fragmentBackground,
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(56),
              bottomLeft: Radius.circular(56)),
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
                  color: myStore.isDarkTheme
                      ? AppColors.white_3
                      : AppColors.gray_8,
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
    });
  }
}
