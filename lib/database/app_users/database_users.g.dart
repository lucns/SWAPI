// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_users.dart';

// ignore_for_file: type=lint
class $UserTableTable extends UserTable with TableInfo<$UserTableTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cpfMeta = const VerificationMeta('cpf');
  @override
  late final GeneratedColumn<String> cpf = GeneratedColumn<String>(
      'cpf', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [id, name, cpf, password, isActive];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_table';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('cpf')) {
      context.handle(
          _cpfMeta, cpf.isAcceptableOrUnknown(data['cpf']!, _cpfMeta));
    } else if (isInserting) {
      context.missing(_cpfMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    } else if (isInserting) {
      context.missing(_isActiveMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      cpf: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cpf'])!,
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
    );
  }

  @override
  $UserTableTable createAlias(String alias) {
    return $UserTableTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String name;
  final String cpf;
  final String password;
  final bool isActive;
  const User(
      {required this.id,
      required this.name,
      required this.cpf,
      required this.password,
      required this.isActive});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['cpf'] = Variable<String>(cpf);
    map['password'] = Variable<String>(password);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  UserTableCompanion toCompanion(bool nullToAbsent) {
    return UserTableCompanion(
      id: Value(id),
      name: Value(name),
      cpf: Value(cpf),
      password: Value(password),
      isActive: Value(isActive),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      cpf: serializer.fromJson<String>(json['cpf']),
      password: serializer.fromJson<String>(json['password']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'cpf': serializer.toJson<String>(cpf),
      'password': serializer.toJson<String>(password),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  User copyWith(
          {int? id,
          String? name,
          String? cpf,
          String? password,
          bool? isActive}) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        cpf: cpf ?? this.cpf,
        password: password ?? this.password,
        isActive: isActive ?? this.isActive,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('cpf: $cpf, ')
          ..write('password: $password, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, cpf, password, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.name == this.name &&
          other.cpf == this.cpf &&
          other.password == this.password &&
          other.isActive == this.isActive);
}

class UserTableCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> cpf;
  final Value<String> password;
  final Value<bool> isActive;
  const UserTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.cpf = const Value.absent(),
    this.password = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  UserTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String cpf,
    required String password,
    required bool isActive,
  })  : name = Value(name),
        cpf = Value(cpf),
        password = Value(password),
        isActive = Value(isActive);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? cpf,
    Expression<String>? password,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (cpf != null) 'cpf': cpf,
      if (password != null) 'password': password,
      if (isActive != null) 'is_active': isActive,
    });
  }

  UserTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? cpf,
      Value<String>? password,
      Value<bool>? isActive}) {
    return UserTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      cpf: cpf ?? this.cpf,
      password: password ?? this.password,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (cpf.present) {
      map['cpf'] = Variable<String>(cpf.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('cpf: $cpf, ')
          ..write('password: $password, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

abstract class _$UsersDatabase extends GeneratedDatabase {
  _$UsersDatabase(QueryExecutor e) : super(e);
  late final $UserTableTable userTable = $UserTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [userTable];
}
