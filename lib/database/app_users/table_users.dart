import 'package:drift/drift.dart';

// dart run build_runner build
// dart run build_runner watch

@DataClassName('User')
class UserTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get cpf => text()();
  TextColumn get password => text()();
  BoolColumn get isActive => boolean()();
}
