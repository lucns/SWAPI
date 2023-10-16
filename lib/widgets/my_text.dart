// @developed by @lucns

// Widget de Texto costumizado para padronização

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lucns_swapi2/utils/app_colors.dart';
import 'package:lucns_swapi2/widgets/widget_states_store.dart';

class MyText extends StatefulWidget {
  String text;
  Function()? onClick;
  TextStyle? style;
  TextAlign? textAlign;
  TextOverflow? overflow;
  int? maxLines;
  bool isDarkTheme;
  final WidgetStatesStore myStore = WidgetStatesStore();

  MyText(
      {Key? key,
      required this.text,
      this.style,
      this.textAlign,
      this.overflow,
      this.maxLines,
      this.onClick,
      this.isDarkTheme = false})
      : super(key: key) {
    myStore.isDarkTheme = isDarkTheme;
    myStore.onClickListener = onClick ?? () {};
    myStore.text = text;
  }

  void setText(String text) {
    myStore.text = text;
  }

  void setEnabled(bool isEnabled) {
    myStore.isEnabled = isEnabled;
  }

  void setOnClickListener(Function() onClick) {
    myStore.setOnClickListener(onClick);
  }

  void setDarkTheme(bool isDarkTheme) {
    myStore.setIsDarkTheme(isDarkTheme);
  }

  @override
  State<MyText> createState() => _MyTextState();
}

class _MyTextState extends State<MyText> {
  _MyTextState();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () {
      widget.myStore.onClickListener.call();
    }, child: Observer(builder: (_) {
      return Text(
        widget.myStore.text ?? "",
        textAlign: widget.textAlign,
        maxLines: widget.maxLines,
        style: widget.style ??
            TextStyle(
                color: widget.myStore.isDarkTheme
                    ? (widget.myStore.isEnabled
                        ? AppColors.textNormalDark
                        : AppColors.textDisabledDark)
                    : (widget.myStore.isEnabled
                        ? AppColors.textNormalSecondary
                        : AppColors.textDisabledSecondary),
                fontSize: 14,
                fontWeight: FontWeight.w300),
      );
    }));
  }
}
