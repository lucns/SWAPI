// Developed by @lucns

// Controle e acesso a SWAPI

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:lucns_swapi/utils/annotator.dart';

class Swapi {
  final urlPeople = "https://swapi.dev/api/people/";
  final urlPlanets = "https://swapi.dev/api/planets/";
  final urlFilms = "https://swapi.dev/api/films/";
  final urlSpecies = "https://swapi.dev/api/species/";
  final urlVehicles = "https://swapi.dev/api/vehicles/";
  final urlStarships = "https://swapi.dev/api/starships/";
  final Map<String, dynamic> mainJson = <String, dynamic>{};

  Swapi();

  // Preenche a lista com os repectivos dados obtidos no pacote JSON
  void fillList(String json, List<MyModel> listModels) {
    List<dynamic> results = jsonDecode(json)["results"];
    for (int i = 0; i < results.length; i++) {
      Map<String, dynamic> filmJson = results[i];
      MyModel m;
      if (listModels is List<Film>) {
        m = Film.fromJson(filmJson);
      } else if (listModels is List<People>) {
        m = People.fromJson(filmJson);
      } else {
        m = Planet.fromJson(filmJson);
      }
      listModels.add(m);
    }
  }

  // gera a requisição dos filmes e controla as funlçoes de resposta (Callbacks)
  void requestFilms(Function(List<Film> films) callback, Function() callback2, Function() callback3) {
    List<Film> list = [];
    _makeRequest(urlFilms, "Films.json", list, () {
      callback(list);
      callback2();
    }, callback3);
  }

  // gera a requisição dos personagens e controla as funlçoes de resposta (Callbacks)
  void requestPeoples(Function(List<People> films) callback, Function() callback2, Function() callback3) {
    List<People> emptyList = [];
    String fileName = "Persons.json";
    Annotator annotator = Annotator(fileName);
    if (annotator.exists()) {
      annotator.getData((json) {
        if (json == null) {
          callback3();
          return;
        }
        fillList(json, emptyList);
        callback(emptyList);
        callback2();
      });
    } else {
      _makeRequestMultiPage(urlPeople, fileName, emptyList, () {
        callback(emptyList);
      }, callback2, callback3);
    }
  }

  // gera a requisição dos planetas e controla as funlçoes de resposta (Callbacks)
  void requestPlanets(
      Function(List<Planet> films) callback, Function() callback2, Function() callback3) {
    List<Planet> emptyList = [];
    String fileName = "Planets.json";
    Annotator annotator = Annotator(fileName);
    if (annotator.exists()) {
      annotator.getData((json) {
        if (json == null) {
          callback3();
          return;
        }
        fillList(json, emptyList);
        callback(emptyList);
        callback2();
      });
    } else {
      _makeRequestMultiPage(urlPlanets, fileName, emptyList, () {
        callback(emptyList);
      }, callback2, callback3);
    }
  }

  // automaticamente acessa as outras paginas caso haja mais de 1 página de personagens ou planetas
  void _makeRequestMultiPage(String url, String fileName, List<MyModel> emptyList, Function() callback, Function() callback2, Function() callback3) {
    Annotator annotator = Annotator(fileName);
      requestGet(url).then((content) {
        if (content.isNotEmpty) {
          Map<String, dynamic> jsonPage = jsonDecode(content);
          List<dynamic> resultsPage = jsonPage["results"];
          if (mainJson.containsKey("results")) {
            List<dynamic> mainJsonResults = mainJson["results"];
            mainJsonResults.addAll(resultsPage);
          } else {
            mainJson["results"] = resultsPage;
          }

          String json = jsonEncode(mainJson);
          emptyList.clear();
          fillList(json, emptyList);

          String? nextPage = jsonPage["next"];
          if (nextPage == null) {
            annotator.setData(json);
            callback2();
            return;
          }
          _makeRequestMultiPage(nextPage, fileName, emptyList, callback, callback2, callback3);
        } else {
          callback3();
          return;
        }
        callback();
      });
  }

  // Carrega apenas uma pagina. Usada pra carregar os filmes.
  void _makeRequest(String url, String fileName, List<MyModel> emptyList,
      Function() callback, Function() callback3) {
    Annotator annotator = Annotator(fileName);
    if (annotator.exists()) {
      annotator.getData((json) {
        if (json == null) {
          callback();
          return;
        }
        fillList(json, emptyList);
        callback();
      });
    } else {
      requestGet(url).then((json) {
        if (json.isNotEmpty) {
          annotator.setData(json);
          fillList(json, emptyList);
          callback();
        } else {
          callback3();
        }
      });
    }
  }

  // Gera a requisição
  Future<String> requestGet(String url) async {
    try {
      return await http.get(Uri.parse(url)).then((response) {
        if (response.statusCode < 300 && response.statusCode >= 200) {
          return response.body;
        }
        return "";
      });
    } catch (e) {
      // connection error or server down
    }
    return "";
  }
}

class People extends MyModel {
  People.fromJson(Map<String, dynamic> json) {
    setTopStart = json['name'];
    setBottomEnd = "Genero: ${json['gender']}";
    setBottomStart = "Ano de nascimento: ${json['birth_year']}";
    setCenterStart = "Altura: ${json['height']}cm";
  }

  @override
  Film fromJson(Map<String, dynamic> json) {
    return Film.fromJson(json);
  }
}

class Planet extends MyModel {
  Planet.fromJson(Map<String, dynamic> json) {
    setTopStart = json['name'];
    setBottomEnd = "Habitantes: ${json['population']}";
    setBottomStart = "Diametro: ${json['diameter']}km";
    setCenterStart = "Clima: ${json['climate']}";
  }

  @override
  Film fromJson(Map<String, dynamic> json) {
    return Film.fromJson(json);
  }
}

class Film extends MyModel {
  Film();

  Film.fromJson(Map<String, dynamic> json) {
    setTopStart = json['title'];
    setBottomEnd = "Sinopse: ${json['opening_crawl']}";
    setBottomStart = "Lançamento: ${json['release_date']}";
    setCenterStart = "Diretor: ${json['director']}";

    textBottomEnd = textBottomEnd.substring(0, textBottomEnd.indexOf("."));
    textBottomEnd += "...";
  }

  @override
  Film fromJson(Map<String, dynamic> json) {
    return Film.fromJson(json);
  }
}

abstract class MyModel { // Classe abstrata pra nao duplicar variaveis e seta-las dinamicamente
  String textTopStart = "Não especificado";
  String textCenterStart = "Não especificado";
  String textBottomStart = "Não especificado";
  String textBottomEnd = "Não especificado";

  fromJson(Map<String, dynamic> json);

  set setTopStart(String s) => textTopStart = s;

  set setCenterStart(String s) => textCenterStart = s;

  set setBottomStart(String s) => textBottomStart = s;

  set setBottomEnd(String s) => textBottomEnd = s;
}
