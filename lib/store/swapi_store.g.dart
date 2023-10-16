// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swapi_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SwapiStore on _SwapiStore, Store {
  late final _$isDarkThemeAtom =
      Atom(name: '_SwapiStore.isDarkTheme', context: context);

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

  late final _$imageOpacityGoAtom =
      Atom(name: '_SwapiStore.imageOpacityGo', context: context);

  @override
  bool get imageOpacityGo {
    _$imageOpacityGoAtom.reportRead();
    return super.imageOpacityGo;
  }

  @override
  set imageOpacityGo(bool value) {
    _$imageOpacityGoAtom.reportWrite(value, super.imageOpacityGo, () {
      super.imageOpacityGo = value;
    });
  }

  late final _$isFailureAtom =
      Atom(name: '_SwapiStore.isFailure', context: context);

  @override
  bool get isFailure {
    _$isFailureAtom.reportRead();
    return super.isFailure;
  }

  @override
  set isFailure(bool value) {
    _$isFailureAtom.reportWrite(value, super.isFailure, () {
      super.isFailure = value;
    });
  }

  late final _$isLoadedAtom =
      Atom(name: '_SwapiStore.isLoaded', context: context);

  @override
  bool get isLoaded {
    _$isLoadedAtom.reportRead();
    return super.isLoaded;
  }

  @override
  set isLoaded(bool value) {
    _$isLoadedAtom.reportWrite(value, super.isLoaded, () {
      super.isLoaded = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_SwapiStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isConnectedAtom =
      Atom(name: '_SwapiStore.isConnected', context: context);

  @override
  bool get isConnected {
    _$isConnectedAtom.reportRead();
    return super.isConnected;
  }

  @override
  set isConnected(bool value) {
    _$isConnectedAtom.reportWrite(value, super.isConnected, () {
      super.isConnected = value;
    });
  }

  late final _$isCompleteAtom =
      Atom(name: '_SwapiStore.isComplete', context: context);

  @override
  bool get isComplete {
    _$isCompleteAtom.reportRead();
    return super.isComplete;
  }

  @override
  set isComplete(bool value) {
    _$isCompleteAtom.reportWrite(value, super.isComplete, () {
      super.isComplete = value;
    });
  }

  late final _$contentListAtom =
      Atom(name: '_SwapiStore.contentList', context: context);

  @override
  ObservableList<MyModel> get contentList {
    _$contentListAtom.reportRead();
    return super.contentList;
  }

  @override
  set contentList(ObservableList<MyModel> value) {
    _$contentListAtom.reportWrite(value, super.contentList, () {
      super.contentList = value;
    });
  }

  late final _$_SwapiStoreActionController =
      ActionController(name: '_SwapiStore', context: context);

  @override
  void requestListContent(int listType) {
    final _$actionInfo = _$_SwapiStoreActionController.startAction(
        name: '_SwapiStore.requestListContent');
    try {
      return super.requestListContent(listType);
    } finally {
      _$_SwapiStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isDarkTheme: ${isDarkTheme},
imageOpacityGo: ${imageOpacityGo},
isFailure: ${isFailure},
isLoaded: ${isLoaded},
isLoading: ${isLoading},
isConnected: ${isConnected},
isComplete: ${isComplete},
contentList: ${contentList}
    ''';
  }
}
