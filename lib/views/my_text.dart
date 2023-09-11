// @developed by @lucns

// Widget de Texto costumizado para padronização

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lucns_swapi/utils/app_colors.dart';

class MyText extends StatefulWidget {
  String text;
  Function()? onClick;
  bool isEnabled = true;
  TextStyle? style;
  TextAlign? textAlign;
  TextOverflow? overflow;
  int? maxLines;
  bool isDarkTheme;
  final MyTextState widgetState;

  MyText(
      {Key? key,
      required this.text,
      this.style,
      this.textAlign,
      this.overflow,
      this.maxLines,
      this.onClick,
      this.isDarkTheme = false})
      : widgetState = MyTextState(onClick), super(key: key);

  void setText(String text) {
    widgetState.setText(text);
  }

  void setEnabled(bool isEnabled) {
    widgetState.setEnabled(isEnabled);
  }

  void setTextColor(Color color) {
    widgetState.setTextColor(color);
  }

  void setOnClickListener(Function() onClick) {
    widgetState.setOnClickListener(onClick);
  }

  void setDarkTheme(bool isDarkTheme) {
    widgetState.setDarkTheme(isDarkTheme);
  }

  @override
  State<MyText> createState() {
    return widgetState;
  }
}

class MyTextState extends State<MyText> {

  Function()? onClickListener;
  MyTextState(this.onClickListener);

  void setOnClickListener(Function()? onClick) {
    setState(() {
      onClickListener = onClick;
    });
  }

  void setText(String text) {
    setState(() {
      widget.text = text;
    });
  }

  void setEnabled(bool enable) {
    setState(() {
      widget.isEnabled = enable;
    });
  }

  void setDarkTheme(bool isDarkTheme) {
    setState(() {
      widget.isDarkTheme = isDarkTheme;
    });
  }

  void setTextColor(Color color) {
    setState(() {
      //widget.style!.color = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (onClickListener != null) onClickListener!.call();
          },
        child: Text(
          widget.text,
          textAlign: widget.textAlign,
          maxLines: widget.maxLines,
          style: widget.style ??
              TextStyle(
                  color: widget.isDarkTheme
                      ? (widget.isEnabled
                          ? AppColors.textNormalDark
                          : AppColors.textDisabledDark)
                      : (widget.isEnabled
                          ? AppColors.textNormalSecondary
                          : AppColors.textDisabledSecondary),
                  fontSize: 14,
                  fontWeight: FontWeight.w300),
        ));
  }
}
