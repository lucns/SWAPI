// Developed by @lucns

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucns_swapi/database/user_controller.dart';
import 'package:lucns_swapi/screens/login/login_screen.dart';
import 'package:lucns_swapi/screens/main/main_screen.dart';
import 'package:lucns_swapi/utils/annotator.dart';

import 'package:lucns_swapi/utils/utils.dart';
import 'package:lucns_swapi/utils/app_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.fragmentBackgroundDark,
        systemNavigationBarColor: AppColors.fragmentBackgroundDark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light));

    return MaterialApp(
        color: Colors.black,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              primary: AppColors.appBackground,
              secondary: AppColors.appBackground,
              primaryContainer: AppColors.appBackground,
              secondaryContainer: AppColors.appBackground,
              background: AppColors.appBackground,
              seedColor: AppColors.accent),
          useMaterial3: true,
        ),
        home: SplashScreen()
        //home: const SplashScreen()
        //home: const NewAccountScreen()
        //home: const ForgottenPasswordScreen()
        // home: LoginScreen()
        //home: const MainScreen()

        );
  }
}

class SplashScreen extends StatelessWidget {
  bool initialized;

  SplashScreen({super.key}) : initialized = false;

  @override
  Widget build(BuildContext context) {
    if (!initialized) {
      Utils.initializeUtils(() {
        initialized = true;
        Widget nextScreen =
        UserController().hasUserLogged() ? MainScreen() : LoginScreen(); // Carrega um Splash enquanto carrega o Utils.DATA_PATH
        // Já redireciona pra tela inicial caso haja um usuário logado
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => nextScreen));
      });
    }
    return Container( // SplashScreen
      width: double.infinity,
      height: double.infinity,
      color: AppColors.fragmentBackgroundDark,
      child: const Image(image: ResizeImage(AssetImage('assets/images/sw_logo_yellow.png'), width: 100, height: 44)),
    );
  }
}
