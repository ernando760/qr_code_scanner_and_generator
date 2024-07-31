// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sqflite/sqflite.dart';

import 'package:qr_code_scanner_and_generator/src/shared/data/db/i_database.dart';

class SqfliteOpenDatabaseParam extends IDatabaseParam {
  final String path;
  final int? version;
  final SqfliteCrudParam sql;

  SqfliteOpenDatabaseParam(
      {required this.path, this.version, required this.sql});
}

class SqfliteCrudParam extends IDatabaseParam {
  final String sql;
  final String table;
  final List<Object>? args;
  final bool? distinct;
  final List<String>? columns;
  final String? where;
  final List<Object?>? whereArgs;
  final String? groupBy;
  final String? having;
  final String? orderBy;
  final int? limit;
  final int? offset;
  final Map<String, Object?> values;
  final String? nullColumnHack;
  final ConflictAlgorithm? conflictAlgorithm;

  SqfliteCrudParam({
    this.sql = "",
    this.table = "",
    this.args,
    this.distinct,
    this.columns,
    this.where,
    this.whereArgs,
    this.groupBy,
    this.having,
    this.orderBy,
    this.limit,
    this.offset,
    this.values = const {},
    this.nullColumnHack,
    this.conflictAlgorithm,
  });
}
