// @developed by @lucns

// Butão costumizado para padronização

//import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lucns_swapi2/store/swapi_store.dart';
import 'package:lucns_swapi2/utils/app_colors.dart';
import 'package:lucns_swapi2/widgets/widget_states_store.dart';

class MyButton extends StatefulWidget {
  bool isDarkTheme;
  bool isEnabled;
  String textButton;
  Function()? onClick;
  WidgetStatesStore myStore = WidgetStatesStore();

  MyButton(
      {Key? key,
      required this.textButton,
      this.onClick,
      this.isDarkTheme = false,
      this.isEnabled = true})
      : super(key: key) {
    myStore.isDarkTheme = isDarkTheme;
    myStore.setOnClickListener(onClick ?? () {});
    myStore.isEnabled = isEnabled;
  }

  @override
  State<MyButton> createState() => _MyButtonState();

  void setOnClickListener(Function() onClick) {
    myStore.setOnClickListener(onClick);
  }

  void setText(String text) {
    myStore.setText(text);
  }

  void setEnabled(bool isEnabled) {
    myStore.setIEnabled(isEnabled);
  }
}

class _MyButtonState extends State<MyButton> {
  _MyButtonState();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      MaterialStateProperty<Color> colorsStateBackground =
          MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return widget.isDarkTheme
                ? AppColors.buttonDisabledDark
                : AppColors.buttonDisabled;
          }
          return widget.isDarkTheme
              ? AppColors.buttonNormalDark
              : AppColors.buttonNormal;
        },
      );

      return SizedBox(
        width: 220,
        height: 48,
        child: ElevatedButton(
            style: ButtonStyle(
                //foregroundColor: colorsStateText,
                overlayColor: MaterialStateProperty.resolveWith((states) {
                  return Colors.white.withOpacity(0.5);
                }),
                backgroundColor: colorsStateBackground,
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(56),
                        side: const BorderSide(color: Colors.transparent)))),
            onPressed: widget.myStore.isEnabled
                ? widget.myStore.onClickListener
                : null,
            child: Text(widget.textButton,
                style: TextStyle(
                    color: widget.myStore.isEnabled
                        ? AppColors.white
                        : AppColors.textDisabledDark,
                    fontSize: 18,
                    fontWeight: FontWeight.w300))),
      );
    });
  }
}
