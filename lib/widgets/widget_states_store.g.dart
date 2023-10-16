// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widget_states_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WidgetStatesStore on _WidgetStatesStore, Store {
  late final _$isDarkThemeAtom =
      Atom(name: '_WidgetStatesStore.isDarkTheme', context: context);

  @override
  bool get isDarkTheme {
    _$isDarkThemeAtom.reportRead();
    return super.isDarkTheme;
  }

  @override
  set isDarkTheme(bool value) {
    _$isDarkThemeAtom.reportWrite(value, super.isDarkTheme, () {
      super.isDarkTheme = value;
    });
  }

  late final _$textAtom =
      Atom(name: '_WidgetStatesStore.text', context: context);

  @override
  String? get text {
    _$textAtom.reportRead();
    return super.text;
  }

  @override
  set text(String? value) {
    _$textAtom.reportWrite(value, super.text, () {
      super.text = value;
    });
  }

  late final _$isTouchedAtom =
      Atom(name: '_WidgetStatesStore.isTouched', context: context);

  @override
  bool get isTouched {
    _$isTouchedAtom.reportRead();
    return super.isTouched;
  }

  @override
  set isTouched(bool value) {
    _$isTouchedAtom.reportWrite(value, super.isTouched, () {
      super.isTouched = value;
    });
  }

  late final _$isEnabledAtom =
      Atom(name: '_WidgetStatesStore.isEnabled', context: context);

  @override
  bool get isEnabled {
    _$isEnabledAtom.reportRead();
    return super.isEnabled;
  }

  @override
  set isEnabled(bool value) {
    _$isEnabledAtom.reportWrite(value, super.isEnabled, () {
      super.isEnabled = value;
    });
  }

  late final _$inputTypeAtom =
      Atom(name: '_WidgetStatesStore.inputType', context: context);

  @override
  TextInputType? get inputType {
    _$inputTypeAtom.reportRead();
    return super.inputType;
  }

  @override
  set inputType(TextInputType? value) {
    _$inputTypeAtom.reportWrite(value, super.inputType, () {
      super.inputType = value;
    });
  }

  late final _$onClickListenerAtom =
      Atom(name: '_WidgetStatesStore.onClickListener', context: context);

  @override
  dynamic Function() get onClickListener {
    _$onClickListenerAtom.reportRead();
    return super.onClickListener;
  }

  @override
  set onClickListener(dynamic Function() value) {
    _$onClickListenerAtom.reportWrite(value, super.onClickListener, () {
      super.onClickListener = value;
    });
  }

  late final _$_WidgetStatesStoreActionController =
      ActionController(name: '_WidgetStatesStore', context: context);

  @override
  void setIsDarkTheme(bool b) {
    final _$actionInfo = _$_WidgetStatesStoreActionController.startAction(
        name: '_WidgetStatesStore.setIsDarkTheme');
    try {
      return super.setIsDarkTheme(b);
    } finally {
      _$_WidgetStatesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setText(String s) {
    final _$actionInfo = _$_WidgetStatesStoreActionController.startAction(
        name: '_WidgetStatesStore.setText');
    try {
      return super.setText(s);
    } finally {
      _$_WidgetStatesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsTouched(bool b) {
    final _$actionInfo = _$_WidgetStatesStoreActionController.startAction(
        name: '_WidgetStatesStore.setIsTouched');
    try {
      return super.setIsTouched(b);
    } finally {
      _$_WidgetStatesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIEnabled(bool b) {
    final _$actionInfo = _$_WidgetStatesStoreActionController.startAction(
        name: '_WidgetStatesStore.setIEnabled');
    try {
      return super.setIEnabled(b);
    } finally {
      _$_WidgetStatesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setInputType(TextInputType b) {
    final _$actionInfo = _$_WidgetStatesStoreActionController.startAction(
        name: '_WidgetStatesStore.setInputType');
    try {
      return super.setInputType(b);
    } finally {
      _$_WidgetStatesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOnClickListener(dynamic Function() o) {
    final _$actionInfo = _$_WidgetStatesStoreActionController.startAction(
        name: '_WidgetStatesStore.setOnClickListener');
    try {
      return super.setOnClickListener(o);
    } finally {
      _$_WidgetStatesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isDarkTheme: ${isDarkTheme},
text: ${text},
isTouched: ${isTouched},
isEnabled: ${isEnabled},
inputType: ${inputType},
onClickListener: ${onClickListener}
    ''';
  }
}
