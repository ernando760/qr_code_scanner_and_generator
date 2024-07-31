import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_code_scanner_and_generator/src/historic/controllers/historic_controller.dart';
import 'package:qr_code_scanner_and_generator/src/historic/repositories/historic_repository_impl.dart';
import 'package:qr_code_scanner_and_generator/src/historic/services/historic_service_impl.dart';
import 'package:qr_code_scanner_and_generator/src/shared/models/bar_code_model.dart';
import 'package:qr_code_scanner_and_generator/src/historic/states/historic_state.dart';

import '../../../mocks/mocks.dart';
import '../../shared/data/db/sqflite/sqflite_database_impl_test.dart';

void main() {
  final barcode = BarcodeModel(
      code: "ernando", format: CodeFormat.qrcode, createdAt: DateTime.now());
  late HistoricController controller;

  setUp(() async {
    controller = HistoricController(
        HistoricServiceImpl(HistoricRepositoryImpl(SqfliteDatabaseImplTest())));
  });

  test(
      "Deve o obter um estado sucesso quando obter todo o historico de barcode",
      () async {
    expect(controller.state, equals(InitialHistoricState()));
    await controller.saveItemInHistoric(barcode);
    await controller.getAllHistoric();
    expect(controller.state, isA<SuccessHistoricState>());
    debugPrint("${controller.state}");
  });

  test("Deve o obter um estado sucesso quando salvar um barcode no historico",
      () async {
    await controller.saveItemInHistoric(barcode);
    expect(controller.state, isA<SuccessHistoricState>());
    debugPrint("${controller.state}");
  });

  test("Deve o obter um estado sucesso quando deletar um barcode no historico",
      () async {
    await controller.saveItemInHistoric(barcode);
    await controller.saveItemInHistoric(BarcodeModel(
        code: "Pedro", format: CodeFormat.qrcode, createdAt: DateTime.now()));
    await controller.deleteItemInHistoric(1);
    expect(controller.state, isA<SuccessHistoricState>());
    debugPrint("${controller.state}");
  });

  test(
      "Deve o obter um estado sucesso quando atualizar um barcode no historico",
      () async {
    await controller.saveItemInHistoric(
        barcode.copyWith(code: () => "Pedro", format: () => CodeFormat.qrcode));
    await controller.updateItemInHistoric(
        2, barcode.copyWith(id: () => 2, code: () => "Maria"));
    expect(controller.state, isA<SuccessHistoricState>());
    debugPrint("${controller.state}");
  });

  test(
      "Deve o obter um estado sucesso quando filtrar os barcodes por datas no historico",
      () {
    controller.filterBarcodeBydate(barcodes);
  });
}
