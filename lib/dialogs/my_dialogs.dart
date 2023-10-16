// @Developed by @lucns

/*
  Classe criada para formalizar e gerenciar dialogos padrão.
  Ex: Dialog de espera, dialog de confirmação, etc
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:lucns_swapi2/utils/app_colors.dart';
import 'package:lucns_swapi2/widgets/my_text.dart';

class Dialogs {
  late BuildContext context;
  MyText? textTitle, textDescription;

  Dialogs(this.context);

  void showDialogWindow(Widget content, bool isCancelable) {
    showDialog(
        barrierDismissible: isCancelable,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () => Future.value(false),
              child: CupertinoDialogAction(
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: const EdgeInsets.symmetric(vertical: 24.0),
                      padding: const EdgeInsets.all(24.0),
                      decoration: const BoxDecoration(
                        color: AppColors.dialogBackground,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(36)),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow,
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: content)));
        });
  }

  void showIndeterminateDialog(String title) {
    textTitle = MyText(
        text: title,
        maxLines: 10,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.start);

    showDialogWindow(
        IntrinsicHeight(
            child: Row(children: [
          const Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                  width: 36,
                  child: CircularProgressIndicator(color: Colors.white))),
          const SizedBox(width: 16),
          Flexible(
              child: textTitle ??
                  Text(
                    title,
                    maxLines: 10,
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Colors.white),
                  ))
        ])),
        false);
  }

  void dismiss() {
    Navigator.pop(context);
  }

  void setTextTitle(String title) {
    textTitle!.setText(title);
  }

  void setTextDescription(String description) {
    //textDescription = description;
  }
}

//const CircularProgressIndicator(color: AppColors.textEnabled)
