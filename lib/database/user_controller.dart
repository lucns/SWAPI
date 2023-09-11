// @Developed by @lucns

import 'dart:convert';

import 'package:lucns_swapi/utils/annotator.dart';

class UserController extends Annotator {
  UserController() : super("users.json");

  bool hasUserLogged() {
    return Annotator("logged_user.json").exists();
  }

  void registerUser(User user) {
    if (exists()) {
      getData((s) {
        Map<String, dynamic> jsonObjectUsers = jsonDecode(s);
        Map<String, dynamic> jsonObjectUser = <String, dynamic>{};
        jsonObjectUser["cpf"] = user.cpf;
        jsonObjectUser["password"] = user.password;
        jsonObjectUser["name"] = user.name;
        jsonObjectUsers[user.cpf] = jsonObjectUser;
        setData(jsonEncode(jsonObjectUsers));
      });
      return;
    }
    Map<String, dynamic> jsonObjectUsers = <String, dynamic>{};
    Map<String, dynamic> jsonObjectUser = <String, dynamic>{};
    jsonObjectUser["cpf"] = user.cpf;
    jsonObjectUser["password"] = user.password;
    jsonObjectUser["name"] = user.name;
    jsonObjectUsers[user.cpf] = jsonObjectUser;
    setData(jsonEncode(jsonObjectUsers));
  }

  void getSelected(Function(User) callback) {
    Annotator("logged_user.json").getData((s) {
      Map<String, dynamic> jsonObjectUser = jsonDecode(s);
      callback(User.fromJson(jsonObjectUser));
    });
  }

  Future<List<User>> getUsers() async {
    if (!exists()) return [];
    return await read().then((s) {
      Map<String, dynamic> jsonObjectUsers = jsonDecode(s);
      List<User> list = [];
      for (String key in jsonObjectUsers.keys) {
        Map<String, dynamic> json = jsonObjectUsers[key];
        list.add(User.fromJson(json));
      }
      return list;
    });
  }

  void isRegistered(String cpf, Function(bool) callback) {
    getData((s) {
      Map<String, dynamic> jsonObjectUsers = jsonDecode(s);
      callback(jsonObjectUsers.containsKey(cpf));
    });
  }

  void selectUser(User user) {
    Map<String, dynamic> jsonObjectUser = <String, dynamic>{};
    jsonObjectUser["cpf"] = user.cpf;
    jsonObjectUser["password"] = user.cpf;
    jsonObjectUser["name"] = user.name;
    Annotator("logged_user.json").setData(jsonEncode(jsonObjectUser));
  }

  void deselect() {
    Annotator("logged_user.json").delete();
  }

  bool hasSelection() {
    return Annotator("logged_user.json").exists();
  }
}

class User {
  String name = "";
  String cpf = "";
  String password = "";

  User(this.name, this.cpf, this.password);

  User.fromJson(Map<String, dynamic> json) {
    name = json["name"] ?? "";
    cpf = json["cpf"] ?? "";
    password = json["password"] ?? "";
  }
}
