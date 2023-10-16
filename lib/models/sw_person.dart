import 'package:lucns_swapi2/models/sw_item_base.dart';

class SwPerson extends MyModel {
  SwPerson();

  SwPerson.fromJson(Map<String, dynamic> json) {
    setTopStart = json['name'];
    setBottomEnd = "Genero: ${json['gender']}";
    setBottomStart = "Ano de nascimento: ${json['birth_year']}";
    setCenterStart = "Altura: ${json['height']}cm";
  }

  @override
  SwPerson fromJson(Map<String, dynamic> json) {
    return SwPerson.fromJson(json);
  }
}
