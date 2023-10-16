import 'package:drift/drift.dart';

class TableBase extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get textTopStart => text()();
  TextColumn get textCenterStart => text()();
  TextColumn get textBottomStart => text()();
  TextColumn get textBottomEnd => text()();
}
