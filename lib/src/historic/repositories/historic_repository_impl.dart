import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:qr_code_scanner_and_generator/src/shared/data/db/i_database.dart';
import 'package:qr_code_scanner_and_generator/src/shared/data/db/sqflite/params/sqflite_param.dart';
import 'package:qr_code_scanner_and_generator/src/shared/data/exceptions/repository_exception.dart';
import 'package:qr_code_scanner_and_generator/src/historic/repositories/i_historic_repository.dart';
import 'package:qr_code_scanner_and_generator/src/shared/models/bar_code_model.dart';

class HistoricRepositoryImpl implements IHistoricRepository {
  final IDatabase _database;

  HistoricRepositoryImpl(this._database);

  Future<void> _initDatabase() async {
    if (_database.isOpen) {
      return;
    }
    await _database.open(
        param: SqfliteOpenDatabaseParam(
      path: "history.db",
      version: 1,
      sql: SqfliteCrudParam(
          sql:
              "CREATE TABLE Historic (id INTEGER PRIMARY KEY, code TEXT, format TEXT, bytes BLOB, created_at INTEGER)"),
    ));
  }

  @override
  Future<Either<IRepositoryException, List<BarcodeModel>>>
      getAllHistoric() async {
    try {
      await _initDatabase();
      final res = await _database.get<List<Map<String, Object?>>>(
          param: SqfliteCrudParam(
              table: "Historic",
              columns: ["id", "code", "format", "bytes", "created_at"]));

      final result = res
          .map((success) => success.data.map((data) {
                // debugPrint("DATA: $data");
                return BarcodeModel.fromMap(data);
              }).toList())
          .mapLeft((error) => HistoricRepositoryException(
              label: "$runtimeType-getAllHistoric => ${error.label}",
              messageError: error.messageError,
              stackTrace: error.stackTrace));

      return result;
    } catch (e, s) {
      log(e.toString(),
          error: "ERROR $runtimeType-getAllHistoric", stackTrace: s);

      return Left(HistoricRepositoryException(
          label: "$runtimeType-getAllHistory",
          messageError: e.toString(),
          stackTrace: s));
    }
  }

  @override
  Future<Either<IRepositoryException, List<BarcodeModel>>> saveItemInHistoric(
      BarcodeModel barcode) async {
    try {
      await _initDatabase();
      final result = await _database.create(
          param: SqfliteCrudParam(
        table: "Historic",
        values: barcode.toMap(),
      ));

      final error = result
          .mapLeft((error) => HistoricRepositoryException(
              label: "$runtimeType-saveItemInHistoric => ${error.label}",
              messageError: error.messageError,
              stackTrace: error.stackTrace))
          .getLeft()
          .toNullable();
      if (error != null) {
        return left(error);
      }
      final getAllHistoricResult = await getAllHistoric();
      return getAllHistoricResult;
    } catch (e, s) {
      log(e.toString(),
          error: "ERROR $runtimeType-saveItemInHistoric", stackTrace: s);
      return Left(HistoricRepositoryException(
          label: "$runtimeType-saveItemInHistoric",
          messageError: e.toString(),
          stackTrace: s));
    }
  }

  @override
  Future<Either<IRepositoryException, List<BarcodeModel>>> deleteItemInHistoric(
      int id) async {
    try {
      await _initDatabase();
      final result = await _database.delete(
          param: SqfliteCrudParam(
        table: "Historic",
        where: "id = ?",
        whereArgs: [id],
      ));
      final error = result
          .mapLeft((error) => HistoricRepositoryException(
              label: "$runtimeType-deleteItemInHistoric => ${error.label}",
              messageError: error.messageError,
              stackTrace: error.stackTrace))
          .getLeft()
          .toNullable();
      if (error != null) {
        return left(error);
      }
      final getAllHistoricResult = await getAllHistoric();
      return getAllHistoricResult;
    } catch (e, s) {
      log(e.toString(),
          error: "ERROR $runtimeType-deleteItemInHistoric", stackTrace: s);
      return Left(HistoricRepositoryException(
          label: "$runtimeType-deleteItemInHistoric",
          messageError: e.toString(),
          stackTrace: s));
    }
  }

  @override
  Future<Either<IRepositoryException, List<BarcodeModel>>> updateItemInHistoric(
      {required int id, required BarcodeModel newData}) async {
    try {
      await _initDatabase();
      final result = await _database.update(
          param: SqfliteCrudParam(
              table: "Historic",
              values: newData.toMap(),
              where: "id = ?",
              whereArgs: [id]));
      final error = result
          .mapLeft((error) => HistoricRepositoryException(
              label: "$runtimeType-updateItemInHistoric => ${error.label}",
              messageError: error.messageError,
              stackTrace: error.stackTrace))
          .getLeft()
          .toNullable();
      if (error != null) {
        return left(error);
      }
      final getAllHistoricResult = await getAllHistoric();
      return getAllHistoricResult;
    } catch (e, s) {
      log(e.toString(),
          error: "ERROR $runtimeType-updateItemInHistoric", stackTrace: s);
      return Left(HistoricRepositoryException(
          label: "$runtimeType-updateItemInHistoric",
          messageError: e.toString(),
          stackTrace: s));
    }
  }
}
