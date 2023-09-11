// @developed by @lucns

// Campo de texto costumizado para padronização

import 'dart:developer';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'package:flutter/services.dart';

class MyFieldText extends StatefulWidget {
  final String fixedText;
  final TextInputAction action;
  TextInputType inputType;
  List<TextInputFormatter>? inputFormatters;
  bool stateEnabled, isTouched, isDarkTheme;
  TextCapitalization? textCapitalization;
  Function(String value)? onInput;
  final MyTextFieldState widgetState;

  MyFieldText(
      {Key? key,
      required this.fixedText,
      required this.action,
      required this.inputType,
      this.isDarkTheme = false,
      this.textCapitalization,
      this.inputFormatters,
      this.stateEnabled = true,
      this.isTouched = false,
      this.onInput})
      : widgetState = MyTextFieldState(onInput ?? (String s) {}),
        super(key: key);

  @override
  State<MyFieldText> createState() {
    return widgetState;
  }

  void setOnTextChangedListener(Function(String value) listener) {
    widgetState.setOnTextChangedListener(listener);
  }

  bool isEnabled() {
    return widgetState.isEnabled();
  }

  void setEnabled(bool enable) {
    widgetState.setEnabled(enable);
  }

  String getText() {
    return widgetState.getText();
  }

  void setText(String text) {
    widgetState.setText(text);
  }
}

class MyTextFieldState extends State<MyFieldText> {
  final TextEditingController myController = TextEditingController();
  Function(String text) onTextChangedListener;
  String? lastText;

  MyTextFieldState(this.onTextChangedListener);

  @override
  void initState() {
    myController.addListener(() {
      if (widget.stateEnabled && myController.text != lastText) {
        lastText = myController.text;
        onTextChangedListener(myController.text);
      }
    });
    super.initState();
  }

  void setOnTextChangedListener(Function(String text) listener) {
    onTextChangedListener = listener;
  }

  bool isEnabled() {
    return widget.stateEnabled;
  }

  void setEnabled(bool enable) {
    setState(() {
      widget.stateEnabled = enable;
    });
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
          return TextField(
            enabled: widget.stateEnabled,
            inputFormatters: widget.inputFormatters,
            controller: myController,
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.none,
            textInputAction: widget.action,
            keyboardType: widget.inputType,
            obscureText: widget.inputType == TextInputType.visiblePassword &&
                !widget.isTouched,
            cursorColor: widget.isDarkTheme
                ? AppColors.fieldTextCursorDark
                : AppColors.fieldTextCursor,
            style: TextStyle(
                color: widget.isDarkTheme
                    ? (widget.stateEnabled
                        ? AppColors.fieldTextTextDark
                        : AppColors.textDisabledDark)
                    : (widget.stateEnabled
                        ? AppColors.fieldTextText
                        : AppColors.textDisabled),
                fontSize: fontSize),
            decoration: InputDecoration(
                suffixIcon: widget.inputType == TextInputType.visiblePassword
                    ? GestureDetector(
                        onLongPressUp: () => {
                              setState(() => {widget.isTouched = false})
                            },
                        onTapDown: (_) => {
                              setState(() => {widget.isTouched = true})
                            },
                        onTapUp: (_) => {
                              setState(() => {widget.isTouched = false})
                            },
                        child: Container(
                          width: 36,
                          height: 36,
                          //color: Colors.red,
                          constraints: const BoxConstraints(),
                          padding: const EdgeInsets.all(16),
                          child: Icon(
                            widget.isTouched
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 16,
                            color: widget.stateEnabled
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
                fillColor: widget.isDarkTheme
                    ? (widget.stateEnabled
                        ? (hasFocus
                            ? AppColors.fieldTextFocusedBackgroundDark
                            : AppColors.fieldTextBackgroundDark)
                        : AppColors.fieldTextDisabledBackgroundDark)
                    : (widget.stateEnabled
                        ? (hasFocus
                            ? AppColors.fieldTextFocusedBackground
                            : AppColors.fieldTextBackground)
                        : AppColors.fieldTextDisabledBackground),
                filled: true,
                hintStyle: TextStyle(
                    color: widget.isDarkTheme
                        ? (widget.stateEnabled
                            ? AppColors.fieldTextHintDark
                            : AppColors.textDisabledDark)
                        : (widget.stateEnabled
                            ? AppColors.fieldTextHint
                            : AppColors.textDisabled),
                    fontSize: fontSize,
                    fontWeight: FontWeight.w400),
                hintText: widget.fixedText,
                contentPadding: const EdgeInsets.only(
                    top: 0, bottom: 0, left: 16, right: 16)),
          );
        }));
  }
}

class CpfFormatter extends TextInputFormatter {
  bool isUpdating = false;
  String old = "";
  final String DEFAULT_MASK = "###.###.###-##";

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
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
