abstract class MyModel {
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
