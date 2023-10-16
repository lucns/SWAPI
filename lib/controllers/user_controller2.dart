// @Developed by @lucns

import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:lucns_swapi2/models/app_user.dart';
import 'package:lucns_swapi2/database/app_users/database_users.dart';

class UserController {
  UsersDatabase _database;

  UserController() : _database = UsersDatabase();

  Future<void> close() {
    return _database.close();
  }

  Future<List<AppUser>> getUsers() async {
    return await _database.select(_database.userTable).get().then((value) {
      List<AppUser> users = [];
      for (int i = 0; i < value.length; i++) {
        users.add(_copyFrom(value[i]));
      }
      return users;
    });
  }

  AppUser _copyFrom(User tableUser) {
    return AppUser(tableUser.name, tableUser.cpf, tableUser.password,
        id: tableUser.id, isActive: tableUser.isActive);
  }

  Future<void> registerUser(AppUser user) async {
    await _database.into(_database.userTable).insert(UserTableCompanion.insert(
        name: user.name,
        cpf: user.cpf,
        password: user.password,
        isActive: false));
  }

  Future<bool> isRegistered(String cpf) async {
    return getUsers().then((users) {
      for (int i = 0; i < users.length; i++) {
        if (users[i].cpf == cpf) return true;
      }
      return false;
    });
  }

  Future<bool> hasLoggedUser() async {
    return await getUsers().then((users) {
      for (int i = 0; i < users.length; i++) {
        if (users[i].isActive) return true;
      }
      return false;
    });
  }

  Future<AppUser> getLoggedUser() async {
    return await getUsers().then((users) {
      for (int i = 0; i < users.length; i++) {
        if (users[i].isActive) return users[i];
      }
      return AppUser("", "", "");
    });
  }

  Future<void> loginUser(String cpf) async {
    List<AppUser> users = await getUsers();
    AppUser? login, logout;
    for (AppUser u in users) {
      if (u.cpf == cpf) login = u;
      if (u.isActive) logout = u;
      if (login != null && logout != null) break;
    }
    if (logout != null) {
      await _database.update(_database.userTable).replace(User(
          id: logout.id,
          name: logout.name,
          cpf: logout.cpf,
          password: logout.password,
          isActive: false));
    }
    if (login != null) {
      await _database.update(_database.userTable).replace(User(
          id: login.id,
          name: login.name,
          cpf: login.cpf,
          password: login.password,
          isActive: true));
    }
  }

  Future<void> logoutUser() async {
    AppUser? user = await getUsers().then((users) {
      for (int i = 0; i < users.length; i++) {
        if (users[i].isActive) {
          return users[i];
        }
      }
    });

    if (user == null) return;
    await _database.into(_database.userTable).insertOnConflictUpdate(User(
        id: user.id,
        name: user.name,
        cpf: user.cpf,
        password: user.password,
        isActive: false));
  }

  void printUsers() async {
    await getUsers().then((users) {
      if (users.isEmpty) log("No users!");
      for (int i = 0; i < users.length; i++) {
        log("user[$i] = ${users[i].name}, ${users[i].cpf}, ${users[i].password}, ${users[i].isActive}}");
      }
    });
  }
}
