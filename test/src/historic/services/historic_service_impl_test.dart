import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:qr_code_scanner_and_generator/src/shared/data/exceptions/service_exception.dart';
import 'package:qr_code_scanner_and_generator/src/historic/repositories/i_historic_repository.dart';
import 'package:qr_code_scanner_and_generator/src/historic/services/i_historic_service.dart';
import 'package:qr_code_scanner_and_generator/src/shared/models/bar_code_model.dart';

import '../../shared/data/db/sqflite/sqflite_database_impl_test.dart';
import '../repositories/historic_repository_impl_test.dart';

class HistoricServiceImplTest implements IHistoricService {
  final IHistoricRepository _repository;

  HistoricServiceImplTest(this._repository);
  @override
  Future<Either<IServiceException, List<BarcodeModel>>> getAllHistoric() async {
    final result = await _repository.getAllHistoric();
    return result.mapLeft((error) => HistoricServiceException(
        label: "$runtimeType-getAllHistoric => ${error.label}",
        messageError: error.messageError,
        stackTrace: error.stackTrace));
  }

  @override
  Future<Either<IServiceException, List<BarcodeModel>>> saveItemInHistoric(
      BarcodeModel barcodeModel) async {
    final result = await _repository.saveItemInHistoric(barcodeModel);
    return result.mapLeft((error) => HistoricServiceException(
        label: "$runtimeType-saveItemInHistoric => ${error.label}",
        messageError: error.messageError,
        stackTrace: error.stackTrace));
  }

  @override
  Future<Either<IServiceException, List<BarcodeModel>>> deleteItemInHistoric(
      int? id) async {
    if (id == null) {
      return Left(
          HistoricServiceException(messageError: "O id não pode ser nulo"));
    }
    final result = await _repository.deleteItemInHistoric(id);
    return result.mapLeft((error) => HistoricServiceException(
        label: "$runtimeType-deleteItemInHistoric => ${error.label}",
        messageError: error.messageError,
        stackTrace: error.stackTrace));
  }

  @override
  Future<Either<IServiceException, List<BarcodeModel>>> updateItemInHistoric(
      {required int? id, required BarcodeModel newData}) async {
    if (id == null) {
      return Left(
          HistoricServiceException(messageError: "O id não pode ser nulo"));
    }
    final result =
        await _repository.updateItemInHistoric(id: id, newData: newData);
    return result.mapLeft((error) => HistoricServiceException(
        label: "$runtimeType-updateItemInHistoric => ${error.label}",
        messageError: error.messageError,
        stackTrace: error.stackTrace));
  }
}

void main() {
  final dateNow = DateTime.now();
  final barcode = BarcodeModel(
      code: "Ernando", format: CodeFormat.qrcode, createdAt: dateNow);
  late IHistoricService mockService;

  setUp(() {
    mockService = HistoricServiceImplTest(
        HistoricRepositoryImplTest(SqfliteDatabaseImplTest()));
  });

  test('Deve Obter todos os barcode do historico', () async {
    await mockService.saveItemInHistoric(barcode);
    final result = await mockService.getAllHistoric();

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
    final result = await mockService.saveItemInHistoric(barcode);

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
    await mockService.saveItemInHistoric(barcode);
    await mockService.saveItemInHistoric(barcode.copyWith(code: () => "Pedro"));
    final result = await mockService.deleteItemInHistoric(1);

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
    await mockService.saveItemInHistoric(barcode);
    final result = await mockService.updateItemInHistoric(
        id: 1, newData: barcode.copyWith(id: () => 1));

    final barcodes = result.getRight().toNullable();
    final exception = result.getLeft().toNullable();

    debugPrint("Barcodes: $barcodes");
    debugPrint(
        "Exception => ${exception.runtimeType}(label: ${exception?.label}, messageError: ${exception?.messageError}, stackTrace: ${exception?.stackTrace})");

    expect(barcodes, isNotNull);
    expect(exception, isNull);
  });
}
