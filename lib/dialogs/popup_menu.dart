// @Developed by @lucns

//import 'dart:developer';
import 'package:lucns_swapi2/dialogs/popup_window.dart';
import 'package:flutter/material.dart';
import 'package:lucns_swapi2/utils/app_colors.dart';
import 'package:lucns_swapi2/utils/utils.dart';

class PopupMenu extends PopupWindow {
  PopupMenu({required super.context})
      : super(position: Utils.menuPosition(context), isCancelable: true);

  void showMenu(
      List<PopupMenuItem> items, Function(int index) onOptionSelected) {
    List<Widget> views = <Widget>[];
    for (var i = 0; i < items.length; i++) {
      views.add(_getWidgetItem(items[i], () {
        dismiss();
        onOptionSelected(i);
      }));
    }
    showWindow(Column(mainAxisSize: MainAxisSize.min, children: views));
  }

  List<PopupMenuItem> generateIds(List<String> titles) {
    List<PopupMenuItem> list = <PopupMenuItem>[];
    for (var i = 0; i < titles.length; i++) {
      list.add(PopupMenuItem(text: titles[i], id: i));
    }
    return list;
  }

  Widget _getWidgetItem(PopupMenuItem item, Function() onClickListener) {
    return Container(
        height: 36,
        constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
        child: TextButton(
            style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(AppColors.ripple),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(color: Colors.transparent)))),
            onPressed: item.isEnabled
                ? () {
                    onClickListener();
                  }
                : null,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(item.text,
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 16,
                      color: item.isEnabled
                          ? Colors.white
                          : Colors.white.withOpacity(0.5))),
            )));
  }
}

class PopupMenuItem {
  final int id;
  final String text;
  bool isEnabled;

  PopupMenuItem({required this.text, required this.id, this.isEnabled = true});
}
