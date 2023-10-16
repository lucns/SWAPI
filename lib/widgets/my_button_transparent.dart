// @developed by @lucns

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lucns_swapi2/utils/app_colors.dart';
import 'package:lucns_swapi2/widgets/widget_states_store.dart';

class MyButtonTransparent extends StatefulWidget {
  bool isDarkTheme;
  String textButton;
  TextStyle? style;
  Function()? onClick;
  final WidgetStatesStore myStore = WidgetStatesStore();

  MyButtonTransparent(
      {Key? key,
      required this.textButton,
      this.onClick,
      this.style,
      this.isDarkTheme = false})
      : super(key: key);

  void setIsDarkTheme(bool isDarkTheme) {
    myStore.setIsDarkTheme(isDarkTheme);
  }

  @override
  State<MyButtonTransparent> createState() => _MyButtonTransparentState();

  void setOnClickListener(Function() onClick) {
    myStore.setOnClickListener(onClick);
  }

  void setText(String text) {
    myStore.setText(text);
  }

  void setEnabled(bool isEnabled) {
    myStore.isEnabled = isEnabled;
  }
}

class _MyButtonTransparentState extends State<MyButtonTransparent> {
  _MyButtonTransparentState();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 220,
        height: 48,
        child: Observer(builder: (_) {
          return TextButton(
              style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(AppColors.buttonNormalDark),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(56),
                          side: const BorderSide(color: Colors.transparent)))),
              onPressed: widget.myStore.isEnabled
                  ? widget.myStore.onClickListener
                  : null,
              child: Text(widget.textButton,
                  style: widget.style ??
                      TextStyle(
                          fontSize: 16,
                          color: widget.isDarkTheme
                              ? (widget.myStore.isEnabled
                                  ? AppColors.textNormalDark
                                  : AppColors.textDisabledDark)
                              : (widget.myStore.isEnabled
                                  ? AppColors.gray_4
                                  : AppColors.textDisabled))));
        }));
  }
}
