// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_sw.dart';

// ignore_for_file: type=lint
class $FilmsTableTable extends FilmsTable
    with TableInfo<$FilmsTableTable, Film> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FilmsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _textTopStartMeta =
      const VerificationMeta('textTopStart');
  @override
  late final GeneratedColumn<String> textTopStart = GeneratedColumn<String>(
      'text_top_start', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _textCenterStartMeta =
      const VerificationMeta('textCenterStart');
  @override
  late final GeneratedColumn<String> textCenterStart = GeneratedColumn<String>(
      'text_center_start', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _textBottomStartMeta =
      const VerificationMeta('textBottomStart');
  @override
  late final GeneratedColumn<String> textBottomStart = GeneratedColumn<String>(
      'text_bottom_start', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _textBottomEndMeta =
      const VerificationMeta('textBottomEnd');
  @override
  late final GeneratedColumn<String> textBottomEnd = GeneratedColumn<String>(
      'text_bottom_end', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, textTopStart, textCenterStart, textBottomStart, textBottomEnd];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'films_table';
  @override
  VerificationContext validateIntegrity(Insertable<Film> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('text_top_start')) {
      context.handle(
          _textTopStartMeta,
          textTopStart.isAcceptableOrUnknown(
              data['text_top_start']!, _textTopStartMeta));
    } else if (isInserting) {
      context.missing(_textTopStartMeta);
    }
    if (data.containsKey('text_center_start')) {
      context.handle(
          _textCenterStartMeta,
          textCenterStart.isAcceptableOrUnknown(
              data['text_center_start']!, _textCenterStartMeta));
    } else if (isInserting) {
      context.missing(_textCenterStartMeta);
    }
    if (data.containsKey('text_bottom_start')) {
      context.handle(
          _textBottomStartMeta,
          textBottomStart.isAcceptableOrUnknown(
              data['text_bottom_start']!, _textBottomStartMeta));
    } else if (isInserting) {
      context.missing(_textBottomStartMeta);
    }
    if (data.containsKey('text_bottom_end')) {
      context.handle(
          _textBottomEndMeta,
          textBottomEnd.isAcceptableOrUnknown(
              data['text_bottom_end']!, _textBottomEndMeta));
    } else if (isInserting) {
      context.missing(_textBottomEndMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Film map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Film(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      textTopStart: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text_top_start'])!,
      textCenterStart: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}text_center_start'])!,
      textBottomStart: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}text_bottom_start'])!,
      textBottomEnd: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}text_bottom_end'])!,
    );
  }

  @override
  $FilmsTableTable createAlias(String alias) {
    return $FilmsTableTable(attachedDatabase, alias);
  }
}

class Film extends DataClass implements Insertable<Film> {
  final int id;
  final String textTopStart;
  final String textCenterStart;
  final String textBottomStart;
  final String textBottomEnd;
  const Film(
      {required this.id,
      required this.textTopStart,
      required this.textCenterStart,
      required this.textBottomStart,
      required this.textBottomEnd});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['text_top_start'] = Variable<String>(textTopStart);
    map['text_center_start'] = Variable<String>(textCenterStart);
    map['text_bottom_start'] = Variable<String>(textBottomStart);
    map['text_bottom_end'] = Variable<String>(textBottomEnd);
    return map;
  }

  FilmsTableCompanion toCompanion(bool nullToAbsent) {
    return FilmsTableCompanion(
      id: Value(id),
      textTopStart: Value(textTopStart),
      textCenterStart: Value(textCenterStart),
      textBottomStart: Value(textBottomStart),
      textBottomEnd: Value(textBottomEnd),
    );
  }

  factory Film.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Film(
      id: serializer.fromJson<int>(json['id']),
      textTopStart: serializer.fromJson<String>(json['textTopStart']),
      textCenterStart: serializer.fromJson<String>(json['textCenterStart']),
      textBottomStart: serializer.fromJson<String>(json['textBottomStart']),
      textBottomEnd: serializer.fromJson<String>(json['textBottomEnd']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'textTopStart': serializer.toJson<String>(textTopStart),
      'textCenterStart': serializer.toJson<String>(textCenterStart),
      'textBottomStart': serializer.toJson<String>(textBottomStart),
      'textBottomEnd': serializer.toJson<String>(textBottomEnd),
    };
  }

  Film copyWith(
          {int? id,
          String? textTopStart,
          String? textCenterStart,
          String? textBottomStart,
          String? textBottomEnd}) =>
      Film(
        id: id ?? this.id,
        textTopStart: textTopStart ?? this.textTopStart,
        textCenterStart: textCenterStart ?? this.textCenterStart,
        textBottomStart: textBottomStart ?? this.textBottomStart,
        textBottomEnd: textBottomEnd ?? this.textBottomEnd,
      );
  @override
  String toString() {
    return (StringBuffer('Film(')
          ..write('id: $id, ')
          ..write('textTopStart: $textTopStart, ')
          ..write('textCenterStart: $textCenterStart, ')
          ..write('textBottomStart: $textBottomStart, ')
          ..write('textBottomEnd: $textBottomEnd')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, textTopStart, textCenterStart, textBottomStart, textBottomEnd);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Film &&
          other.id == this.id &&
          other.textTopStart == this.textTopStart &&
          other.textCenterStart == this.textCenterStart &&
          other.textBottomStart == this.textBottomStart &&
          other.textBottomEnd == this.textBottomEnd);
}

class FilmsTableCompanion extends UpdateCompanion<Film> {
  final Value<int> id;
  final Value<String> textTopStart;
  final Value<String> textCenterStart;
  final Value<String> textBottomStart;
  final Value<String> textBottomEnd;
  const FilmsTableCompanion({
    this.id = const Value.absent(),
    this.textTopStart = const Value.absent(),
    this.textCenterStart = const Value.absent(),
    this.textBottomStart = const Value.absent(),
    this.textBottomEnd = const Value.absent(),
  });
  FilmsTableCompanion.insert({
    this.id = const Value.absent(),
    required String textTopStart,
    required String textCenterStart,
    required String textBottomStart,
    required String textBottomEnd,
  })  : textTopStart = Value(textTopStart),
        textCenterStart = Value(textCenterStart),
        textBottomStart = Value(textBottomStart),
        textBottomEnd = Value(textBottomEnd);
  static Insertable<Film> custom({
    Expression<int>? id,
    Expression<String>? textTopStart,
    Expression<String>? textCenterStart,
    Expression<String>? textBottomStart,
    Expression<String>? textBottomEnd,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (textTopStart != null) 'text_top_start': textTopStart,
      if (textCenterStart != null) 'text_center_start': textCenterStart,
      if (textBottomStart != null) 'text_bottom_start': textBottomStart,
      if (textBottomEnd != null) 'text_bottom_end': textBottomEnd,
    });
  }

  FilmsTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? textTopStart,
      Value<String>? textCenterStart,
      Value<String>? textBottomStart,
      Value<String>? textBottomEnd}) {
    return FilmsTableCompanion(
      id: id ?? this.id,
      textTopStart: textTopStart ?? this.textTopStart,
      textCenterStart: textCenterStart ?? this.textCenterStart,
      textBottomStart: textBottomStart ?? this.textBottomStart,
      textBottomEnd: textBottomEnd ?? this.textBottomEnd,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (textTopStart.present) {
      map['text_top_start'] = Variable<String>(textTopStart.value);
    }
    if (textCenterStart.present) {
      map['text_center_start'] = Variable<String>(textCenterStart.value);
    }
    if (textBottomStart.present) {
      map['text_bottom_start'] = Variable<String>(textBottomStart.value);
    }
    if (textBottomEnd.present) {
      map['text_bottom_end'] = Variable<String>(textBottomEnd.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FilmsTableCompanion(')
          ..write('id: $id, ')
          ..write('textTopStart: $textTopStart, ')
          ..write('textCenterStart: $textCenterStart, ')
          ..write('textBottomStart: $textBottomStart, ')
          ..write('textBottomEnd: $textBottomEnd')
          ..write(')'))
        .toString();
  }
}

class $PlanetsTableTable extends PlanetsTable
    with TableInfo<$PlanetsTableTable, Planet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlanetsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _textTopStartMeta =
      const VerificationMeta('textTopStart');
  @override
  late final GeneratedColumn<String> textTopStart = GeneratedColumn<String>(
      'text_top_start', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _textCenterStartMeta =
      const VerificationMeta('textCenterStart');
  @override
  late final GeneratedColumn<String> textCenterStart = GeneratedColumn<String>(
      'text_center_start', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _textBottomStartMeta =
      const VerificationMeta('textBottomStart');
  @override
  late final GeneratedColumn<String> textBottomStart = GeneratedColumn<String>(
      'text_bottom_start', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _textBottomEndMeta =
      const VerificationMeta('textBottomEnd');
  @override
  late final GeneratedColumn<String> textBottomEnd = GeneratedColumn<String>(
      'text_bottom_end', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, textTopStart, textCenterStart, textBottomStart, textBottomEnd];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'planets_table';
  @override
  VerificationContext validateIntegrity(Insertable<Planet> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('text_top_start')) {
      context.handle(
          _textTopStartMeta,
          textTopStart.isAcceptableOrUnknown(
              data['text_top_start']!, _textTopStartMeta));
    } else if (isInserting) {
      context.missing(_textTopStartMeta);
    }
    if (data.containsKey('text_center_start')) {
      context.handle(
          _textCenterStartMeta,
          textCenterStart.isAcceptableOrUnknown(
              data['text_center_start']!, _textCenterStartMeta));
    } else if (isInserting) {
      context.missing(_textCenterStartMeta);
    }
    if (data.containsKey('text_bottom_start')) {
      context.handle(
          _textBottomStartMeta,
          textBottomStart.isAcceptableOrUnknown(
              data['text_bottom_start']!, _textBottomStartMeta));
    } else if (isInserting) {
      context.missing(_textBottomStartMeta);
    }
    if (data.containsKey('text_bottom_end')) {
      context.handle(
          _textBottomEndMeta,
          textBottomEnd.isAcceptableOrUnknown(
              data['text_bottom_end']!, _textBottomEndMeta));
    } else if (isInserting) {
      context.missing(_textBottomEndMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Planet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Planet(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      textTopStart: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text_top_start'])!,
      textCenterStart: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}text_center_start'])!,
      textBottomStart: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}text_bottom_start'])!,
      textBottomEnd: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}text_bottom_end'])!,
    );
  }

  @override
  $PlanetsTableTable createAlias(String alias) {
    return $PlanetsTableTable(attachedDatabase, alias);
  }
}

class Planet extends DataClass implements Insertable<Planet> {
  final int id;
  final String textTopStart;
  final String textCenterStart;
  final String textBottomStart;
  final String textBottomEnd;
  const Planet(
      {required this.id,
      required this.textTopStart,
      required this.textCenterStart,
      required this.textBottomStart,
      required this.textBottomEnd});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['text_top_start'] = Variable<String>(textTopStart);
    map['text_center_start'] = Variable<String>(textCenterStart);
    map['text_bottom_start'] = Variable<String>(textBottomStart);
    map['text_bottom_end'] = Variable<String>(textBottomEnd);
    return map;
  }

  PlanetsTableCompanion toCompanion(bool nullToAbsent) {
    return PlanetsTableCompanion(
      id: Value(id),
      textTopStart: Value(textTopStart),
      textCenterStart: Value(textCenterStart),
      textBottomStart: Value(textBottomStart),
      textBottomEnd: Value(textBottomEnd),
    );
  }

  factory Planet.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Planet(
      id: serializer.fromJson<int>(json['id']),
      textTopStart: serializer.fromJson<String>(json['textTopStart']),
      textCenterStart: serializer.fromJson<String>(json['textCenterStart']),
      textBottomStart: serializer.fromJson<String>(json['textBottomStart']),
      textBottomEnd: serializer.fromJson<String>(json['textBottomEnd']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'textTopStart': serializer.toJson<String>(textTopStart),
      'textCenterStart': serializer.toJson<String>(textCenterStart),
      'textBottomStart': serializer.toJson<String>(textBottomStart),
      'textBottomEnd': serializer.toJson<String>(textBottomEnd),
    };
  }

  Planet copyWith(
          {int? id,
          String? textTopStart,
          String? textCenterStart,
          String? textBottomStart,
          String? textBottomEnd}) =>
      Planet(
        id: id ?? this.id,
        textTopStart: textTopStart ?? this.textTopStart,
        textCenterStart: textCenterStart ?? this.textCenterStart,
        textBottomStart: textBottomStart ?? this.textBottomStart,
        textBottomEnd: textBottomEnd ?? this.textBottomEnd,
      );
  @override
  String toString() {
    return (StringBuffer('Planet(')
          ..write('id: $id, ')
          ..write('textTopStart: $textTopStart, ')
          ..write('textCenterStart: $textCenterStart, ')
          ..write('textBottomStart: $textBottomStart, ')
          ..write('textBottomEnd: $textBottomEnd')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, textTopStart, textCenterStart, textBottomStart, textBottomEnd);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Planet &&
          other.id == this.id &&
          other.textTopStart == this.textTopStart &&
          other.textCenterStart == this.textCenterStart &&
          other.textBottomStart == this.textBottomStart &&
          other.textBottomEnd == this.textBottomEnd);
}

class PlanetsTableCompanion extends UpdateCompanion<Planet> {
  final Value<int> id;
  final Value<String> textTopStart;
  final Value<String> textCenterStart;
  final Value<String> textBottomStart;
  final Value<String> textBottomEnd;
  const PlanetsTableCompanion({
    this.id = const Value.absent(),
    this.textTopStart = const Value.absent(),
    this.textCenterStart = const Value.absent(),
    this.textBottomStart = const Value.absent(),
    this.textBottomEnd = const Value.absent(),
  });
  PlanetsTableCompanion.insert({
    this.id = const Value.absent(),
    required String textTopStart,
    required String textCenterStart,
    required String textBottomStart,
    required String textBottomEnd,
  })  : textTopStart = Value(textTopStart),
        textCenterStart = Value(textCenterStart),
        textBottomStart = Value(textBottomStart),
        textBottomEnd = Value(textBottomEnd);
  static Insertable<Planet> custom({
    Expression<int>? id,
    Expression<String>? textTopStart,
    Expression<String>? textCenterStart,
    Expression<String>? textBottomStart,
    Expression<String>? textBottomEnd,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (textTopStart != null) 'text_top_start': textTopStart,
      if (textCenterStart != null) 'text_center_start': textCenterStart,
      if (textBottomStart != null) 'text_bottom_start': textBottomStart,
      if (textBottomEnd != null) 'text_bottom_end': textBottomEnd,
    });
  }

  PlanetsTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? textTopStart,
      Value<String>? textCenterStart,
      Value<String>? textBottomStart,
      Value<String>? textBottomEnd}) {
    return PlanetsTableCompanion(
      id: id ?? this.id,
      textTopStart: textTopStart ?? this.textTopStart,
      textCenterStart: textCenterStart ?? this.textCenterStart,
      textBottomStart: textBottomStart ?? this.textBottomStart,
      textBottomEnd: textBottomEnd ?? this.textBottomEnd,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (textTopStart.present) {
      map['text_top_start'] = Variable<String>(textTopStart.value);
    }
    if (textCenterStart.present) {
      map['text_center_start'] = Variable<String>(textCenterStart.value);
    }
    if (textBottomStart.present) {
      map['text_bottom_start'] = Variable<String>(textBottomStart.value);
    }
    if (textBottomEnd.present) {
      map['text_bottom_end'] = Variable<String>(textBottomEnd.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlanetsTableCompanion(')
          ..write('id: $id, ')
          ..write('textTopStart: $textTopStart, ')
          ..write('textCenterStart: $textCenterStart, ')
          ..write('textBottomStart: $textBottomStart, ')
          ..write('textBottomEnd: $textBottomEnd')
          ..write(')'))
        .toString();
  }
}

class $PersonsTableTable extends PersonsTable
    with TableInfo<$PersonsTableTable, Person> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PersonsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _textTopStartMeta =
      const VerificationMeta('textTopStart');
  @override
  late final GeneratedColumn<String> textTopStart = GeneratedColumn<String>(
      'text_top_start', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _textCenterStartMeta =
      const VerificationMeta('textCenterStart');
  @override
  late final GeneratedColumn<String> textCenterStart = GeneratedColumn<String>(
      'text_center_start', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _textBottomStartMeta =
      const VerificationMeta('textBottomStart');
  @override
  late final GeneratedColumn<String> textBottomStart = GeneratedColumn<String>(
      'text_bottom_start', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _textBottomEndMeta =
      const VerificationMeta('textBottomEnd');
  @override
  late final GeneratedColumn<String> textBottomEnd = GeneratedColumn<String>(
      'text_bottom_end', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, textTopStart, textCenterStart, textBottomStart, textBottomEnd];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'persons_table';
  @override
  VerificationContext validateIntegrity(Insertable<Person> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('text_top_start')) {
      context.handle(
          _textTopStartMeta,
          textTopStart.isAcceptableOrUnknown(
              data['text_top_start']!, _textTopStartMeta));
    } else if (isInserting) {
      context.missing(_textTopStartMeta);
    }
    if (data.containsKey('text_center_start')) {
      context.handle(
          _textCenterStartMeta,
          textCenterStart.isAcceptableOrUnknown(
              data['text_center_start']!, _textCenterStartMeta));
    } else if (isInserting) {
      context.missing(_textCenterStartMeta);
    }
    if (data.containsKey('text_bottom_start')) {
      context.handle(
          _textBottomStartMeta,
          textBottomStart.isAcceptableOrUnknown(
              data['text_bottom_start']!, _textBottomStartMeta));
    } else if (isInserting) {
      context.missing(_textBottomStartMeta);
    }
    if (data.containsKey('text_bottom_end')) {
      context.handle(
          _textBottomEndMeta,
          textBottomEnd.isAcceptableOrUnknown(
              data['text_bottom_end']!, _textBottomEndMeta));
    } else if (isInserting) {
      context.missing(_textBottomEndMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Person map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Person(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      textTopStart: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text_top_start'])!,
      textCenterStart: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}text_center_start'])!,
      textBottomStart: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}text_bottom_start'])!,
      textBottomEnd: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}text_bottom_end'])!,
    );
  }

  @override
  $PersonsTableTable createAlias(String alias) {
    return $PersonsTableTable(attachedDatabase, alias);
  }
}

class Person extends DataClass implements Insertable<Person> {
  final int id;
  final String textTopStart;
  final String textCenterStart;
  final String textBottomStart;
  final String textBottomEnd;
  const Person(
      {required this.id,
      required this.textTopStart,
      required this.textCenterStart,
      required this.textBottomStart,
      required this.textBottomEnd});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['text_top_start'] = Variable<String>(textTopStart);
    map['text_center_start'] = Variable<String>(textCenterStart);
    map['text_bottom_start'] = Variable<String>(textBottomStart);
    map['text_bottom_end'] = Variable<String>(textBottomEnd);
    return map;
  }

  PersonsTableCompanion toCompanion(bool nullToAbsent) {
    return PersonsTableCompanion(
      id: Value(id),
      textTopStart: Value(textTopStart),
      textCenterStart: Value(textCenterStart),
      textBottomStart: Value(textBottomStart),
      textBottomEnd: Value(textBottomEnd),
    );
  }

  factory Person.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Person(
      id: serializer.fromJson<int>(json['id']),
      textTopStart: serializer.fromJson<String>(json['textTopStart']),
      textCenterStart: serializer.fromJson<String>(json['textCenterStart']),
      textBottomStart: serializer.fromJson<String>(json['textBottomStart']),
      textBottomEnd: serializer.fromJson<String>(json['textBottomEnd']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'textTopStart': serializer.toJson<String>(textTopStart),
      'textCenterStart': serializer.toJson<String>(textCenterStart),
      'textBottomStart': serializer.toJson<String>(textBottomStart),
      'textBottomEnd': serializer.toJson<String>(textBottomEnd),
    };
  }

  Person copyWith(
          {int? id,
          String? textTopStart,
          String? textCenterStart,
          String? textBottomStart,
          String? textBottomEnd}) =>
      Person(
        id: id ?? this.id,
        textTopStart: textTopStart ?? this.textTopStart,
        textCenterStart: textCenterStart ?? this.textCenterStart,
        textBottomStart: textBottomStart ?? this.textBottomStart,
        textBottomEnd: textBottomEnd ?? this.textBottomEnd,
      );
  @override
  String toString() {
    return (StringBuffer('Person(')
          ..write('id: $id, ')
          ..write('textTopStart: $textTopStart, ')
          ..write('textCenterStart: $textCenterStart, ')
          ..write('textBottomStart: $textBottomStart, ')
          ..write('textBottomEnd: $textBottomEnd')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, textTopStart, textCenterStart, textBottomStart, textBottomEnd);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Person &&
          other.id == this.id &&
          other.textTopStart == this.textTopStart &&
          other.textCenterStart == this.textCenterStart &&
          other.textBottomStart == this.textBottomStart &&
          other.textBottomEnd == this.textBottomEnd);
}

class PersonsTableCompanion extends UpdateCompanion<Person> {
  final Value<int> id;
  final Value<String> textTopStart;
  final Value<String> textCenterStart;
  final Value<String> textBottomStart;
  final Value<String> textBottomEnd;
  const PersonsTableCompanion({
    this.id = const Value.absent(),
    this.textTopStart = const Value.absent(),
    this.textCenterStart = const Value.absent(),
    this.textBottomStart = const Value.absent(),
    this.textBottomEnd = const Value.absent(),
  });
  PersonsTableCompanion.insert({
    this.id = const Value.absent(),
    required String textTopStart,
    required String textCenterStart,
    required String textBottomStart,
    required String textBottomEnd,
  })  : textTopStart = Value(textTopStart),
        textCenterStart = Value(textCenterStart),
        textBottomStart = Value(textBottomStart),
        textBottomEnd = Value(textBottomEnd);
  static Insertable<Person> custom({
    Expression<int>? id,
    Expression<String>? textTopStart,
    Expression<String>? textCenterStart,
    Expression<String>? textBottomStart,
    Expression<String>? textBottomEnd,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (textTopStart != null) 'text_top_start': textTopStart,
      if (textCenterStart != null) 'text_center_start': textCenterStart,
      if (textBottomStart != null) 'text_bottom_start': textBottomStart,
      if (textBottomEnd != null) 'text_bottom_end': textBottomEnd,
    });
  }

  PersonsTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? textTopStart,
      Value<String>? textCenterStart,
      Value<String>? textBottomStart,
      Value<String>? textBottomEnd}) {
    return PersonsTableCompanion(
      id: id ?? this.id,
      textTopStart: textTopStart ?? this.textTopStart,
      textCenterStart: textCenterStart ?? this.textCenterStart,
      textBottomStart: textBottomStart ?? this.textBottomStart,
      textBottomEnd: textBottomEnd ?? this.textBottomEnd,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (textTopStart.present) {
      map['text_top_start'] = Variable<String>(textTopStart.value);
    }
    if (textCenterStart.present) {
      map['text_center_start'] = Variable<String>(textCenterStart.value);
    }
    if (textBottomStart.present) {
      map['text_bottom_start'] = Variable<String>(textBottomStart.value);
    }
    if (textBottomEnd.present) {
      map['text_bottom_end'] = Variable<String>(textBottomEnd.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonsTableCompanion(')
          ..write('id: $id, ')
          ..write('textTopStart: $textTopStart, ')
          ..write('textCenterStart: $textCenterStart, ')
          ..write('textBottomStart: $textBottomStart, ')
          ..write('textBottomEnd: $textBottomEnd')
          ..write(')'))
        .toString();
  }
}

abstract class _$SwDatabase extends GeneratedDatabase {
  _$SwDatabase(QueryExecutor e) : super(e);
  late final $FilmsTableTable filmsTable = $FilmsTableTable(this);
  late final $PlanetsTableTable planetsTable = $PlanetsTableTable(this);
  late final $PersonsTableTable personsTable = $PersonsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [filmsTable, planetsTable, personsTable];
}
