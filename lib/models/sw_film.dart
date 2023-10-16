import 'package:lucns_swapi2/models/sw_item_base.dart';

class SwFilm extends MyModel {
  SwFilm();

  SwFilm.fromJson(Map<String, dynamic> json) {
    setTopStart = json['title'];
    setBottomEnd = "Sinopse: ${json['opening_crawl']}";
    setBottomStart = "Lançamento: ${json['release_date']}";
    setCenterStart = "Diretor: ${json['director']}";

    textBottomEnd = textBottomEnd.substring(0, textBottomEnd.indexOf("."));
    textBottomEnd += "...";
  }

  @override
  SwFilm fromJson(Map<String, dynamic> json) {
    return SwFilm.fromJson(json);
  }
}
