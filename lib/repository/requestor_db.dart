// @Developed by @lucns

import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:lucns_swapi2/models/app_user.dart';
import 'package:lucns_swapi2/database/star_wars_content/database_sw.dart';
import 'package:lucns_swapi2/models/sw_film.dart';
import 'package:lucns_swapi2/models/sw_person.dart';
import 'package:lucns_swapi2/models/sw_planet.dart';

class RequestorDb {
  SwDatabase _database;

  RequestorDb() : _database = SwDatabase();

  Future<void> close() async {
    log("close");
    return await _database.close();
  }

  Future<List<SwFilm>> getFilms() async {
    return await _database.select(_database.filmsTable).get().then((value) {
      List<SwFilm> list = [];
      for (int i = 0; i < value.length; i++) {
        SwFilm model = SwFilm();
        model.textTopStart = value[i].textTopStart;
        model.textCenterStart = value[i].textCenterStart;
        model.textBottomStart = value[i].textBottomStart;
        model.textBottomEnd = value[i].textBottomEnd;
        list.add(model);
      }
      return list;
    });
  }

  Future<List<SwPerson>> getPersons() async {
    return await _database.select(_database.personsTable).get().then((value) {
      List<SwPerson> list = [];
      for (int i = 0; i < value.length; i++) {
        SwPerson model = SwPerson();
        model.textTopStart = value[i].textTopStart;
        model.textCenterStart = value[i].textCenterStart;
        model.textBottomStart = value[i].textBottomStart;
        model.textBottomEnd = value[i].textBottomEnd;
        list.add(model);
      }
      return list;
    });
  }

  Future<List<SwPlanet>> getPlanets() async {
    return await _database.select(_database.planetsTable).get().then((value) {
      List<SwPlanet> list = [];
      for (int i = 0; i < value.length; i++) {
        SwPlanet model = SwPlanet();
        model.textTopStart = value[i].textTopStart;
        model.textCenterStart = value[i].textCenterStart;
        model.textBottomStart = value[i].textBottomStart;
        model.textBottomEnd = value[i].textBottomEnd;
        list.add(model);
      }
      return list;
    });
  }

  Future<void> insertFilms(List<SwFilm> list) async {
    log("insertFilms");
    InsertStatement<$FilmsTableTable, Film> a =
        _database.into(_database.filmsTable);
    for (SwFilm f in list) {
      await a.insert(FilmsTableCompanion.insert(
          textTopStart: f.textTopStart,
          textCenterStart: f.textCenterStart,
          textBottomStart: f.textBottomStart,
          textBottomEnd: f.textBottomEnd));
    }
  }

  Future<void> insertPersons(List<SwPerson> list) async {
    InsertStatement<$PersonsTableTable, Person> a =
        _database.into(_database.personsTable);
    for (SwPerson f in list) {
      await a.insert(PersonsTableCompanion.insert(
          textTopStart: f.textTopStart,
          textCenterStart: f.textCenterStart,
          textBottomStart: f.textBottomStart,
          textBottomEnd: f.textBottomEnd));
    }
  }

  Future<void> insertPlanets(List<SwPlanet> list) async {
    InsertStatement<$PlanetsTableTable, Planet> a =
        _database.into(_database.planetsTable);
    for (SwPlanet f in list) {
      await a.insert(PlanetsTableCompanion.insert(
          textTopStart: f.textTopStart,
          textCenterStart: f.textCenterStart,
          textBottomStart: f.textBottomStart,
          textBottomEnd: f.textBottomEnd));
    }
  }
}
