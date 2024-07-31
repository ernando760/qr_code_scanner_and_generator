import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/src/either.dart';
import 'package:fpdart/src/unit.dart';
import 'package:qr_code_scanner_and_generator/src/shared/data/db/i_database.dart';
import 'package:qr_code_scanner_and_generator/src/shared/data/db/sqflite/params/sqflite_param.dart';
import 'package:qr_code_scanner_and_generator/src/shared/data/exceptions/database_exception.dart';
import 'package:qr_code_scanner_and_generator/src/shared/models/bar_code_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SqfliteDatabaseImplTest implements IDatabase {
  Database? _database;

  @override
  bool get isOpen => _database?.isOpen ?? false;

  @override
  Future<void> open({covariant SqfliteOpenDatabaseParam? param}) async {
    try {
      sqfliteFfiInit();
      if (_database != null || param == null) {
        return;
      }

      _database = await databaseFactoryFfi.openDatabase(
        inMemoryDatabasePath,
        options: OpenDatabaseOptions(
          version: param.version,
          onCreate: (db, version) async {
            await db.execute(param.sql.sql, param.sql.args);
          },
        ),
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

void main() {
  final dateNow = DateTime.now();
  late IDatabase mockDatabase;

  setUp(() async {
    mockDatabase = SqfliteDatabaseImplTest();
    await mockDatabase.open(
        param: SqfliteOpenDatabaseParam(
      path: "test.db",
      version: 1,
      sql: SqfliteCrudParam(
          sql:
              "CREATE TABLE Historic (id INTEGER PRIMARY KEY, code TEXT, format TEXT, bytes BLOB)"),
    ));

    await mockDatabase.delete(
        param: SqfliteCrudParam(sql: "DELETE FROM Historic"));
  });

  tearDown(() async {
    await mockDatabase.close();
  });
  test("Deve Obter todos os barcode da tabela historico do banco de dados",
      () async {
    final barcode = BarcodeModel(
        code: "Ernando", format: CodeFormat.qrcode, createdAt: dateNow);
    final saveFutures = [
      mockDatabase.create(
          param: SqfliteCrudParam(
        table: "Historic",
        values: barcode.toMap(),
      )),
      mockDatabase.create(
          param: SqfliteCrudParam(
        table: "Historic",
        values: barcode
            .copyWith(code: () => "Pedro", format: () => CodeFormat.codabar)
            .toMap(),
      ))
    ];

    await Future.wait(saveFutures);

    final result = await mockDatabase.get<List<Map<String, Object?>>>(
        param: SqfliteCrudParam(
            table: "Historic", columns: ["id", "code", "format", "bytes"]));

    final success = result.getRight().toNullable();
    final error = result.getLeft().toNullable();

    final barcodes =
        success?.data.map((data) => BarcodeModel.fromMap(data)).toList() ?? [];

    debugPrint("Success data ${success?.data}");
    debugPrint("Success mapped data $barcodes");
    debugPrint("Error ${error?.messageError}");

    expect(success, isNotNull);
    expect(barcodes, isA<List<BarcodeModel>>());
    expect(success?.data.length, equals(2));
    expect(success?.data, isA<List<Map<String, Object?>>>());
    expect(error, isNull);
  });

  test("Deve inserir um barcode na tabela historico do banco de dados",
      () async {
    final barcode = BarcodeModel(
        code: "Ernando", format: CodeFormat.qrcode, createdAt: dateNow);

    final result = await mockDatabase.create(
        param: SqfliteCrudParam(
      table: "Historic",
      values: barcode.toMap(),
    ));

    final success = result.getRight().toNullable();
    final error = result.getLeft().toNullable();

    debugPrint("Success $success");
    debugPrint("Error ${error?.messageError}");
    expect(success, isNotNull);
    expect(success, equals(unit));
    expect(error, isNull);
  });

  test("Deve Deletar um barcode na tabela historico do banco de dados",
      () async {
    final barcode = BarcodeModel(
        id: 1, code: "Ernando", format: CodeFormat.qrcode, createdAt: dateNow);

    await mockDatabase.create(
        param: SqfliteCrudParam(
      table: "Historic",
      values: barcode.toMap(),
    ));

    final result = await mockDatabase.delete(
        param: SqfliteCrudParam(
      table: "Historic",
      where: "id = ?",
      whereArgs: [barcode.id],
    ));

    final success = result.getRight().toNullable();
    final error = result.getLeft().toNullable();

    debugPrint("Success $success");
    debugPrint("Error ${error?.messageError}");
    expect(success, isNotNull);
    expect(success, equals(unit));
    expect(error, isNull);
  });

  test("Deve Atualizar um barcode na tabela historico do banco de dados",
      () async {
    var barcode = BarcodeModel(
        id: 1, code: "Ernando", format: CodeFormat.qrcode, createdAt: dateNow);

    await mockDatabase.create(
        param: SqfliteCrudParam(
      table: "Historic",
      values: barcode.toMap(),
    ));
    barcode = barcode.copyWith(
        id: () => 1, code: () => "Pedro", format: () => CodeFormat.codabar);

    final result = await mockDatabase.update(
        param: SqfliteCrudParam(
      table: "Historic",
      values: barcode.toMap(),
      where: "id = ?",
      whereArgs: [barcode.id],
    ));

    final getAllHistoricResult =
        await mockDatabase.get<List<Map<String, Object?>>>(
            param: SqfliteCrudParam(
      table: "Historic",
      where: "id = ?",
      whereArgs: [barcode.id],
    ));

    final getAllHistoricRight = getAllHistoricResult.getRight().toNullable();
    final getAllHistoricLeft = getAllHistoricResult.getLeft().toNullable();

    debugPrint("Success getAllHistoricRight ${getAllHistoricRight?.data}");
    debugPrint("Error getAllHistoricRight ${getAllHistoricLeft?.messageError}");

    final success = result.getRight().toNullable();
    final error = result.getLeft().toNullable();

    debugPrint("Success $success");
    debugPrint("Error ${error?.messageError}");
    expect(success, isNotNull);
    expect(success, equals(unit));
    expect(error, isNull);
  });
}
