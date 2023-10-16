// Developed by @lucns

//import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucns_swapi2/controllers/user_controller2.dart';
import 'package:lucns_swapi2/pages/login_screen.dart';
import 'package:lucns_swapi2/pages/main_screen.dart';

import 'package:lucns_swapi2/utils/utils.dart';
import 'package:lucns_swapi2/utils/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
              background: AppColors.fragmentBackgroundDark,
              seedColor: AppColors.accent),
          useMaterial3: true,
        ),
        home: const SplashScreen()
        //home: const SplashScreen()
        //home: const NewAccountScreen()
        //home: const ForgottenPasswordScreen()
        // home: LoginScreen()
        //home: const MainScreen()

        );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.initializeUtils(() {
      //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const NewAccountScreen()));

      UserController c = UserController();
      c.hasLoggedUser().then((value) {
        c.close();
        Widget nextScreen = value ? const MainScreen() : const LoginScreen();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => nextScreen));
      });
      //MaterialPageRoute(builder: (context) => TestScreen()));
    });
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.fragmentBackgroundDark,
      child: const Image(
          image: ResizeImage(AssetImage('assets/images/sw_logo_yellow.png'),
              width: 100, height: 44)),
    );
  }
}
