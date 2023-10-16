import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'widget_states_store.g.dart';

class WidgetStatesStore = _WidgetStatesStore with _$WidgetStatesStore;

abstract class _WidgetStatesStore with Store {
  // general variables
  @observable
  bool isDarkTheme = false;

  @action
  void setIsDarkTheme(bool b) {
    isDarkTheme = b;
  }

  // widgets variables (only states changeable)
  @observable
  String? text;

  @action
  void setText(String s) {
    text = s;
  }

  @observable
  bool isTouched = false;

  @action
  void setIsTouched(bool b) {
    isTouched = b;
  }

  @observable
  bool isEnabled = true;

  @action
  void setIEnabled(bool b) {
    isEnabled = b;
  }

  @observable
  TextInputType? inputType;

  @action
  void setInputType(TextInputType b) {
    inputType = b;
  }

  @observable
  Function() onClickListener = () {};

  @action
  void setOnClickListener(Function() o) {
    onClickListener = o;
  }
}
