import 'package:lucns_swapi2/api/api_requestor.dart';
import 'package:lucns_swapi2/models/sw_film.dart';
import 'package:lucns_swapi2/models/sw_item_base.dart';
import 'package:lucns_swapi2/models/sw_person.dart';
import 'package:lucns_swapi2/models/sw_planet.dart';

class RequestorSwapi extends ApiRequestor {
  RequestorSwapi(Function(int) onError,
      Function(List<MyModel>) onPartialResponse, Function() onFinish)
      : super(onError, onPartialResponse, onFinish);

  void requestFilms() {
    List<SwFilm> listModels = [];
    requestPage("/films", listModels, () {
      onPartialResponse(listModels);
      onFinish();
    }, () {
      onError(responseCode);
    });
  }

  void requestPersons() {
    List<SwPerson> listModels = [];
    requestMultiPages("/people", listModels, (bool hasResult) {
      if (hasResult) {
        onPartialResponse(listModels);
      } else {
        onFinish();
      }
    }, () {
      onError(responseCode);
    });
  }

  void requestPlanets() {
    List<SwPlanet> listModels = [];
    requestMultiPages("/planets", listModels, (bool hasResult) {
      if (hasResult) {
        onPartialResponse(listModels);
      } else {
        onFinish();
      }
    }, () {
      onError(responseCode);
    });
  }
}
