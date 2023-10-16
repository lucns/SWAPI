// @developed by @lucns

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lucns_swapi2/utils/app_colors.dart';
import 'package:flutter/services.dart';
import 'package:lucns_swapi2/widgets/widget_states_store.dart';

class MyFieldText extends StatefulWidget {
  final String hintText;
  final TextInputAction action;
  TextInputType inputType;
  List<TextInputFormatter>? inputFormatters;
  bool isTouched, isDarkTheme;
  TextCapitalization? textCapitalization;
  Function(String value)? onInput;
  final WidgetStatesStore myStore = WidgetStatesStore();

  MyFieldText(
      {Key? key,
      required this.hintText,
      required this.action,
      required this.inputType,
      this.isDarkTheme = false,
      this.textCapitalization,
      this.inputFormatters,
      this.isTouched = false,
      this.onInput})
      : super(key: key) {
    myStore.isDarkTheme = isDarkTheme;
    myStore.inputType = inputType;
    myStore.isTouched = isTouched;
  }

  void setOnTextChangedListener(Function(String s) onInput) {
    this.onInput = onInput;
  }

  bool isEnabled() {
    return myStore.isEnabled;
  }

  void setEnabled(bool isEnabled) {
    myStore.isEnabled = isEnabled;
  }

  String getText() {
    return myStore.text ?? "";
  }

  @override
  State<MyFieldText> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyFieldText> {
  final TextEditingController myController = TextEditingController();

  String? lastText;

  _MyTextFieldState();

  @override
  void initState() {
    myController.addListener(() {
      if (widget.myStore.isEnabled && myController.text != lastText) {
        lastText = myController.text;
        widget.myStore.text = myController.text;
        if (widget.onInput != null) {
          widget.onInput!(myController.text);
        }
      }
    });
    super.initState();
  }

  String getText() {
    return myController.text;
  }

  void setText(String text) {
    myController.text = text;
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double fontSize = 22;
    return Focus(
        debugLabel: 'MyFieldText',
        child: Builder(builder: (BuildContext context) {
          final FocusNode focusNode = Focus.of(context);
          final bool hasFocus = focusNode.hasFocus;
          return Observer(builder: (_) {
            return TextField(
              enabled: widget.myStore.isEnabled,
              inputFormatters: widget.inputFormatters,
              controller: myController,
              textCapitalization:
                  widget.textCapitalization ?? TextCapitalization.none,
              textInputAction: widget.action,
              keyboardType: widget.inputType,
              obscureText:
                  widget.myStore.inputType == TextInputType.visiblePassword &&
                      !widget.myStore.isTouched,
              cursorColor: widget.myStore.isDarkTheme
                  ? AppColors.fieldTextCursorDark
                  : AppColors.fieldTextCursor,
              style: TextStyle(
                  color: widget.myStore.isDarkTheme
                      ? (widget.myStore.isEnabled
                          ? AppColors.fieldTextTextDark
                          : AppColors.textDisabledDark)
                      : (widget.myStore.isEnabled
                          ? AppColors.fieldTextText
                          : AppColors.textDisabled),
                  fontSize: fontSize),
              decoration: InputDecoration(
                  suffixIcon: widget.myStore.inputType ==
                          TextInputType.visiblePassword
                      ? GestureDetector(
                          onLongPressUp: () =>
                              {widget.myStore.isTouched = false},
                          onTapDown: (_) => {widget.myStore.isTouched = true},
                          onTapUp: (_) => {widget.myStore.isTouched = false},
                          child: Container(
                            width: 36,
                            height: 36,
                            //color: Colors.red,
                            constraints: const BoxConstraints(),
                            padding: const EdgeInsets.all(16),
                            child: Icon(
                              widget.myStore.isTouched
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 16,
                              color: widget.myStore.isEnabled
                                  ? AppColors.white
                                  : AppColors.fieldTextHint,
                            ),
                          ))
                      : null,
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(90.0)),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(90.0)),
                    borderSide: BorderSide.none,
                  ),
                  disabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(90.0)),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: widget.myStore.isDarkTheme
                      ? (widget.myStore.isEnabled
                          ? (hasFocus
                              ? AppColors.fieldTextFocusedBackgroundDark
                              : AppColors.fieldTextBackgroundDark)
                          : AppColors.fieldTextDisabledBackgroundDark)
                      : (widget.myStore.isEnabled
                          ? (hasFocus
                              ? AppColors.fieldTextFocusedBackground
                              : AppColors.fieldTextBackground)
                          : AppColors.fieldTextDisabledBackground),
                  filled: true,
                  hintStyle: TextStyle(
                      color: widget.myStore.isDarkTheme
                          ? (widget.myStore.isEnabled
                              ? AppColors.fieldTextHintDark
                              : AppColors.textDisabledDark)
                          : (widget.myStore.isEnabled
                              ? AppColors.fieldTextHint
                              : AppColors.textDisabled),
                      fontSize: fontSize,
                      fontWeight: FontWeight.w400),
                  hintText: widget.hintText,
                  contentPadding: const EdgeInsets.only(
                      top: 0, bottom: 0, left: 16, right: 16)),
            );
          });
        }));
  }
}

class CpfFormatter extends TextInputFormatter {
  bool isUpdating = false;
  String old = "";
  final String DEFAULT_MASK = "###.###.###-##";

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length == 14) return newValue;
    if (newValue.text.length == 15) return oldValue;
    String str = unmask(newValue.text);
    String mascara = "";
    if (isUpdating) {
      old = str;
      isUpdating = false;
      return newValue;
    }
    int i = 0;
    for (int a = 0; a < DEFAULT_MASK.length; a++) {
      if ((DEFAULT_MASK[a] != '#' && str.length > old.length) ||
          (DEFAULT_MASK[a] != '#' &&
              str.length < old.length &&
              str.length != i)) {
        mascara += DEFAULT_MASK[a];
        continue;
      }
      try {
        mascara += str[i];
      } catch (e) {
        break;
      }
      i++;
    }
    isUpdating = true;
    return TextEditingValue(
        text: mascara,
        selection: TextSelection.collapsed(offset: mascara.length));
  }

  String unmask(String s) {
    return s.replaceAll(RegExp(r'[^0-9]'), '');
  }
}
