// @Developed by @lucns

//import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:lucns_swapi2/utils/app_colors.dart';

class PopupWindow {
  final BuildContext context;
  AlignmentGeometry? position;
  final bool isCancelable;

  PopupWindow(
      {required this.context, this.position, required this.isCancelable});

  void dismiss() {
    Navigator.pop(context);
  }

  void showWindow(Widget content) {
    Widget widget = Align(
        alignment: position ?? Alignment.center,
        child: Container(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          decoration: const BoxDecoration(
            color: AppColors.appBackgroundDark,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                spreadRadius: 4,
                blurRadius: 4,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: content,
        ));

    showDialog(
      barrierDismissible: isCancelable,
      barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return widget;
      },
    );
  }
}

//const CircularProgressIndicator(color: AppColors.textEnabled)
