import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lucns_swapi2/store/swapi_store.dart';
import 'package:lucns_swapi2/utils/app_colors.dart';
import 'package:lucns_swapi2/widgets/my_button.dart';

import 'package:toast/toast.dart';

final SwapiStore myStore = SwapiStore();

class TestScreen extends StatefulWidget {
  TestScreen({Key? key});

  @override
  TestScreenState createState() => TestScreenState();
}

class TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    log("build");
    return Observer(
        builder: (_) => Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: myStore.isDarkTheme
                ? AppColors.fragmentBackgroundDark
                : AppColors.fragmentBackground,
            body: Container(
                width: double.infinity,
                height: double.infinity,
                //color: Colors.white,
                child: Center(
                    child: MyButton(
                        textButton: 'Click me',
                        onClick: () {
                          Toast.show('Button clicked',
                              duration: Toast.lengthLong);
                          myStore.isDarkTheme = !myStore.isDarkTheme;
                        })))));
  }
}
