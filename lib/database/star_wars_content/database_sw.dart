import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:lucns_swapi2/database/star_wars_content/table_films.dart';
import 'package:lucns_swapi2/database/star_wars_content/table_planets.dart';
import 'package:lucns_swapi2/database/star_wars_content/table_persons.dart';

part 'database_sw.g.dart';

@DriftDatabase(tables: [FilmsTable, PlanetsTable, PersonsTable])
class SwDatabase extends _$SwDatabase {
  SwDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'star_wars.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
