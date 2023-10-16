import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:lucns_swapi2/database/app_users/table_users.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database_users.g.dart';

@DriftDatabase(tables: [UserTable])
class UsersDatabase extends _$UsersDatabase {
  UsersDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'users.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
