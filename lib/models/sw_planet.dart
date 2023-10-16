import 'package:lucns_swapi2/models/sw_item_base.dart';

class SwPlanet extends MyModel {
  SwPlanet();

  SwPlanet.fromJson(Map<String, dynamic> json) {
    setTopStart = json['name'];
    setBottomEnd = "Habitantes: ${json['population']}";
    setBottomStart = "Diametro: ${json['diameter']}km";
    setCenterStart = "Clima: ${json['climate']}";
  }

  @override
  SwPlanet fromJson(Map<String, dynamic> json) {
    return SwPlanet.fromJson(json);
  }
}
