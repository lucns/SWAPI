// @developed by @lucns

// Butão costumizado para padronização

import 'dart:developer';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class MyButton extends StatefulWidget {
  bool isDarkTheme;
  String textButton;
  Function()? onClick;
  final MyButtonState widgetState;

  MyButton(
      {Key? key,
      required this.textButton,
      this.onClick,
      this.isDarkTheme = false})
      : widgetState = MyButtonState(onClick), super(key: key);

  @override
  State<MyButton> createState() {
    return widgetState;
  }

  void setOnClickListener(Function()? onClick) {
    widgetState.setOnClickListener(onClick);
  }

  void setText(String text) {
    widgetState.setText(text);
  }
}

class MyButtonState extends State<MyButton> {

  Function()? onClickListener;
  MyButtonState(this.onClickListener);

  void setOnClickListener(Function()? onClick) {
    setState(() {
      onClickListener = onClick;
    });
  }

  void setText(String text) {
    setState(() {
      widget.textButton = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    MaterialStateProperty<Color> colorsStateBackground =
        MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return widget.isDarkTheme ? AppColors.buttonDisabledDark : AppColors.buttonDisabled;
        }
        return  widget.isDarkTheme ? AppColors.buttonNormalDark : AppColors.buttonNormal;
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
          onPressed: onClickListener,
          child: Text(widget.textButton,
              style: TextStyle(color: onClickListener == null ? AppColors.textDisabledDark : AppColors.white,
                  fontSize: 18, fontWeight: FontWeight.w300))),
    );
  }
}
