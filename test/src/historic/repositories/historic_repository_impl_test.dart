import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:qr_code_scanner_and_generator/src/shared/data/db/i_database.dart';
import 'package:qr_code_scanner_and_generator/src/shared/data/db/sqflite/params/sqflite_param.dart';
import 'package:qr_code_scanner_and_generator/src/shared/data/exceptions/repository_exception.dart';
import 'package:qr_code_scanner_and_generator/src/historic/repositories/i_historic_repository.dart';
import 'package:qr_code_scanner_and_generator/src/shared/models/bar_code_model.dart';

import '../../shared/data/db/sqflite/sqflite_database_impl_test.dart';

class HistoricRepositoryImplTest implements IHistoricRepository {
  final IDatabase _database;

  HistoricRepositoryImplTest(this._database);

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

void main() {
  final dateNow = DateTime.now();
  final barcode = BarcodeModel(
      code: "Ernando", format: CodeFormat.qrcode, createdAt: dateNow);
  late IDatabase mockDatabase;
  late IHistoricRepository mockRepository;
  setUpAll(() => mockDatabase = SqfliteDatabaseImplTest());
  setUp(() {
    mockRepository = HistoricRepositoryImplTest(mockDatabase);
  });

  test('Deve Obter todos os barcode do historico', () async {
    debugPrint(
        "================================= GET TEST =================================");
    await mockRepository.saveItemInHistoric(barcode);
    final result = await mockRepository.getAllHistoric();

    final barcodes = result.getRight().toNullable();
    final exception = result.getLeft().toNullable();

    debugPrint("Barcodes: $barcodes");
    debugPrint(
        "Exception => ${exception.runtimeType}(label: ${exception?.label}, messageError: ${exception?.messageError}, stackTrace: ${exception?.stackTrace})");
    expect(barcodes, isNotNull);
    expect(exception, isNull);
  });

  test("Deve salvar um barcode e retornar todos os barcode do historico",
      () async {
    debugPrint(
        "================================= SAVE TEST =================================");
    final result = await mockRepository
        .saveItemInHistoric(barcode.copyWith(code: () => "Alberto"));

    final barcodes = result.getRight().toNullable();
    final exception = result.getLeft().toNullable();

    debugPrint("Barcodes: $barcodes");
    debugPrint(
        "Exception => ${exception.runtimeType}(label: ${exception?.label}, messageError: ${exception?.messageError}, stackTrace: ${exception?.stackTrace})");

    expect(barcodes, isNotNull);
    expect(exception, isNull);
  });

  test("Deve deletar um barcode e retornar todos os barcode do historico",
      () async {
    debugPrint(
        "================================= DELETE TEST =================================");

    final futures = [
      mockRepository.saveItemInHistoric(barcode.copyWith(code: () => "Pedro")),
      mockRepository
          .saveItemInHistoric(barcode.copyWith(code: () => "12e212223"))
    ];

    await Future.wait(futures);

    final result = await mockRepository.deleteItemInHistoric(1);

    final barcodes = result.getRight().toNullable();
    final exception = result.getLeft().toNullable();

    debugPrint("Barcodes: $barcodes");
    debugPrint(
        "Exception => ${exception.runtimeType}(label: ${exception?.label}, messageError: ${exception?.messageError}, stackTrace: ${exception?.stackTrace})");

    expect(barcodes, isNotNull);
    expect(exception, isNull);
  });

  test("Deve atualizar um barcode e retornar todos os barcode do historico",
      () async {
    debugPrint(
        "================================= UPDATE TEST =================================");
    await mockRepository.saveItemInHistoric(barcode);
    final result = await mockRepository.updateItemInHistoric(
        id: 2,
        newData: barcode.copyWith(id: () => 2, code: () => "123.456.789-10"));

    final barcodes = result.getRight().toNullable();
    final exception = result.getLeft().toNullable();

    debugPrint("Barcodes: $barcodes");
    debugPrint(
        "Exception => ${exception.runtimeType}(label: ${exception?.label}, messageError: ${exception?.messageError}, stackTrace: ${exception?.stackTrace})");

    expect(barcodes, isNotNull);
    expect(exception, isNull);
  });
}
