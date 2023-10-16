import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:lucns_swapi2/api/api_rest.dart';
import 'package:lucns_swapi2/models/sw_film.dart';
import 'package:lucns_swapi2/models/sw_item_base.dart';
import 'package:lucns_swapi2/models/sw_person.dart';
import 'package:lucns_swapi2/models/sw_planet.dart';

class ApiRequestor {
  ApiRest api = ApiRest(Dio());
  int responseCode = 0;
  final Function(int) onError;
  final Function(List<MyModel>) onPartialResponse;
  final Function() onFinish;
  ApiRequestor(this.onError, this.onPartialResponse, this.onFinish);
  int get getResponseCode => responseCode;

  // ----------- Funcoes base ---------------//

  // Converte o JSON para lista de objetos do tipo Filme, Personagem ou Planeta
  void fillList(String json, List<MyModel> listModels) {
    List<dynamic> results = jsonDecode(json)["results"];
    for (int i = 0; i < results.length; i++) {
      Map<String, dynamic> jsonMap = results[i];
      MyModel m;
      if (listModels is List<SwFilm>) {
        m = SwFilm.fromJson(jsonMap);
      } else if (listModels is List<SwPerson>) {
        m = SwPerson.fromJson(jsonMap);
      } else {
        m = SwPlanet.fromJson(jsonMap);
      }
      listModels.add(m);
    }
  }

/* 
* Esta funcao abaixo requisita todas as paginas da api, em sequencia, de forma automatica. 
* Assim consegue puxar todos os 82 personagens e 60 planetas.
* Ja que as apis so retornam somente 10 items por requisicao. 
* Basta passar como parametro o path da url. Ex: /?page=2, /?page=3, /page=4...
* Dentro do JSON retornado havera uma chave chamada "next".
* No valor da chave "next" contem a url da proxima onde esta o restante do conteudo JSON.
* Entao essa funcao ira realizar novas requisicoes a api enquanto haver um valor nao nulo na chave "next".
*/
  void requestMultiPages(String urlPath, List<MyModel> emptyList, Function(bool) onUpdate, Function() onError) {
    void request(String pageNumber) {
      requestGet("$urlPath$pageNumber", (content) {
        if (content.isNotEmpty) {
          Map<String, dynamic> jsonPage = jsonDecode(content);
          if (jsonPage.containsKey("results")) {
            fillList(content, emptyList);
            onUpdate(true);
            String? nextPage = jsonPage["next"];
            if (nextPage == null) {
              onUpdate(false);
              return;
            }
            String path = nextPage.substring(nextPage.lastIndexOf("/"));
            request(path);
          } else {
            onUpdate(false);
          }
        } else {
          onError();
        }
      });
    }

    request("");
  }

  void requestPage(String urlPath, List<MyModel> emptyList, Function() onFinish, Function() onError) {
    requestGet(urlPath, (content) {
      if (content.isNotEmpty) {
        Map<String, dynamic> jsonPage = jsonDecode(content);
        if (jsonPage.containsKey("results")) {
          fillList(content, emptyList);
          onFinish();
        }
      } else {
        onError();
      }
    });
  }

  void requestGet(String urlPath, Function(String s) callback) {
    responseCode = 0;
    try {
      api.dio
          .get(urlPath, options: Options(responseType: ResponseType.plain))
          .then((response) {
        responseCode = response.statusCode ?? 0;
        if (responseCode == 200) {
          callback(response.data.toString());
        } else {
          callback("");
        }
      });
    } catch (error, stack) {
      print(stack);
      callback("");
    }
  }
}
