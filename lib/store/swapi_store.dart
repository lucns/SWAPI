import 'dart:developer';

import 'package:lucns_swapi2/pages/list_screen.dart';
import 'package:lucns_swapi2/repository/requestor_swapi.dart';
import 'package:lucns_swapi2/repository/requestor_db.dart';
import 'package:lucns_swapi2/models/sw_item_base.dart';

import 'package:mobx/mobx.dart';
part 'swapi_store.g.dart';

class SwapiStore = _SwapiStore with _$SwapiStore;

abstract class _SwapiStore with Store {
  // general variables
  @observable
  bool isDarkTheme = false;

  @observable
  bool imageOpacityGo = false;

  @observable
  bool isFailure = false;

  @observable
  bool isLoaded = false;

  @observable
  bool isLoading = false;

  @observable
  bool isConnected = false;

  @observable
  bool isComplete = false;

  @observable
  var contentList = ObservableList<MyModel>();

  @action
  void requestListContent(int listType) {
    isLoading = true;
    void onError(int responseCode) {
      isFailure = true;
    }

    void onPartialResponse(List<MyModel> models) {
      log("onPartialResponse");
      var list = ObservableList<MyModel>();
      if (models.isNotEmpty) {
        for (int i = 0; i < models.length; i++) {
          list.add(models[i]);
        }
        contentList = list;
        isLoaded = true;
        return;
      }
      isFailure = true;
    }

    // request from local db
    RequestorDb requestorDb = RequestorDb();
    Future<void> thread;
    void onFinish() {
      log("onFinish");
      switch (listType) {
        case ListScreen.MOVIES:
          thread = requestorDb.insertFilms(contentList.cast());
          break;
        case ListScreen.PERSONS:
          thread = requestorDb.insertPersons(contentList.cast());
          break;
        default: // planets
          thread = requestorDb.insertPlanets(contentList.cast());
          break;
      }
      thread.then((value) => requestorDb.close());
      isComplete = true;
      isLoading = false;
    }

    // request from internet
    RequestorSwapi api = RequestorSwapi(onError, onPartialResponse, onFinish);

    isLoading = true;
    switch (listType) {
      case ListScreen.MOVIES:
        requestorDb.getFilms().then((l) {
          var list = ObservableList<MyModel>();
          if (l.isNotEmpty) {
            log("films list not empty ${l.length}");
            requestorDb.close();
            for (int i = 0; i < l.length; i++) {
              list.add(l[i]);
            }
            contentList = list;
            isLoaded = true;
            isComplete = true;
            isLoading = false;
            return;
          }
          log("films list empty. Requesting...");
          api.requestFilms();
        });
        break;
      case ListScreen.PERSONS:
        requestorDb.getPersons().then((l) {
          var list = ObservableList<MyModel>();
          if (l.isNotEmpty) {
            requestorDb.close();
            log("persons list not empty ${l.length}");
            for (int i = 0; i < l.length; i++) {
              list.add(l[i]);
            }
            contentList = list;
            isLoaded = true;
            isComplete = true;
            isLoading = false;
            return;
          }
          log("persons list empty. Requesting...");
          api.requestPersons();
        });
        break;
      default: // planets
        requestorDb.getPlanets().then((l) {
          var list = ObservableList<MyModel>();
          if (l.isNotEmpty) {
            requestorDb.close();
            log("planet list not empty ${l.length}");
            for (int i = 0; i < l.length; i++) {
              list.add(l[i]);
            }
            contentList = list;
            isLoaded = true;
            isComplete = true;
            isLoading = false;
            return;
          }
          log("planet list empty. Requesting...");
          api.requestPlanets();
        });
        break;
    }

/*
    SwapiRequestor api = SwapiRequestor(onError, onPartialResponse, onFinish);
    switch (listType) {
      case ListScreen.MOVIES:
        api.requestFilms();
        break;
      case ListScreen.PERSONS:
        api.requestPersons();
        break;
      default: // planets
        api.requestPlanets();
        break;
    }
    */
  }
}
