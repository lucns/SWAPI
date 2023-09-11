// @developed by @lucns

// Butão transparente costumizado para padronização

import 'dart:developer';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class MyButtonTransparent extends StatefulWidget {
  bool isDarkTheme;
  String textButton;
  TextStyle? style;
  Function()? onClick;
  final MyButtonTransparentState widgetState;

  MyButtonTransparent(
      {Key? key,
      required this.textButton,
      this.onClick,
      this.style,
      this.isDarkTheme = false})
      : widgetState = MyButtonTransparentState(onClick),
        super(key: key);

  @override
  State<MyButtonTransparent> createState() {
    return widgetState;
  }

  void setDarkTheme(bool isDarkTheme) {
    this.isDarkTheme = isDarkTheme;
  }

  void setOnClickListener(Function()? onClick) {
    widgetState.setOnClickListener(onClick);
  }

  void setText(String text) {
    widgetState.setText(text);
  }
}

class MyButtonTransparentState extends State<MyButtonTransparent> {
  Function()? onClickListener;

  MyButtonTransparentState(this.onClickListener);

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
    return SizedBox(
      width: 220,
      height: 48,
      child: TextButton(
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(AppColors.buttonNormalDark),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(56),
                      side: const BorderSide(color: Colors.transparent)))),
          onPressed: onClickListener,
          child: Text(widget.textButton,
              style: widget.style ??
                  TextStyle(
                      fontSize: 16,
                      color: widget.isDarkTheme
                          ? (onClickListener == null
                              ? AppColors.textDisabledDark
                              : AppColors.textNormalDark)
                          : (onClickListener == null
                              ? AppColors.textDisabled
                              : AppColors.gray_4)))),
    );
  }
}
