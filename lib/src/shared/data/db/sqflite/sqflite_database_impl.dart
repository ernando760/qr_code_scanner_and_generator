import 'package:fpdart/fpdart.dart';
import 'package:qr_code_scanner_and_generator/src/shared/data/db/i_database.dart';
import 'package:qr_code_scanner_and_generator/src/shared/data/db/sqflite/params/sqflite_param.dart';
import 'package:qr_code_scanner_and_generator/src/shared/data/exceptions/database_exception.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteDatabaseImpl implements IDatabase {
  Database? _database;

  @override
  bool get isOpen => _database?.isOpen ?? false;

  @override
  Future<void> open({covariant SqfliteOpenDatabaseParam? param}) async {
    try {
      if (param == null) {
        return;
      }

      final path = join(await getDatabasesPath(), param.path);
      _database = await openDatabase(
        path,
        version: param.version,
        onCreate: (db, version) {
          db.execute(param.sql.sql, param.sql.args);
        },
      );
    } on DatabaseException catch (e, s) {
      throw OpenDatabaseException(
          label: "$runtimeType-open",
          messageError: e.result.toString(),
          stackTrace: s);
    }
  }

  @override
  Future<Either<IDatabaseException, CustomResponseDb<T>>> get<T>(
      {required covariant SqfliteCrudParam param}) async {
    try {
      final res = await _database?.query(param.table,
          columns: param.columns,
          distinct: param.distinct,
          groupBy: param.groupBy,
          having: param.having,
          limit: param.limit,
          offset: param.offset,
          orderBy: param.orderBy,
          where: param.where,
          whereArgs: param.whereArgs);
      return Right(CustomResponseDb(data: res as T));
    } on DatabaseException catch (e, s) {
      return Left(CrudDatabaseException(
          label: "$runtimeType-get",
          messageError: e.result.toString(),
          stackTrace: s));
    }
  }

  @override
  Future<Either<IDatabaseException, Unit>> create(
      {required covariant SqfliteCrudParam param}) async {
    try {
      await _database?.insert(param.table, param.values,
          nullColumnHack: param.nullColumnHack,
          conflictAlgorithm: param.conflictAlgorithm);
      return const Right(unit);
    } on DatabaseException catch (e, s) {
      return Left(CrudDatabaseException(
          label: "$runtimeType-save",
          messageError: e.result.toString(),
          stackTrace: s));
    }
  }

  @override
  Future<Either<IDatabaseException, Unit>> delete(
      {required covariant SqfliteCrudParam param}) async {
    try {
      await _database?.delete(param.table,
          where: param.where, whereArgs: param.whereArgs);
      return const Right(unit);
    } on DatabaseException catch (e, s) {
      return Left(CrudDatabaseException(
          label: "$runtimeType-delete",
          messageError: e.result.toString(),
          stackTrace: s));
    }
  }

  @override
  Future<Either<IDatabaseException, Unit>> update(
      {required covariant SqfliteCrudParam param}) async {
    try {
      await _database?.update(param.table, param.values,
          where: param.where,
          whereArgs: param.whereArgs,
          conflictAlgorithm: param.conflictAlgorithm);

      return const Right(unit);
    } on DatabaseException catch (e, s) {
      return Left(CrudDatabaseException(
          label: "$runtimeType-update",
          messageError: e.result.toString(),
          stackTrace: s));
    }
  }

  @override
  Future<void> close() async => await _database?.close();
}
