import 'package:brasil_datetime/brasil_datetime.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner_and_generator/src/historic/services/i_historic_service.dart';
import 'package:qr_code_scanner_and_generator/src/shared/controllers/message_controller.dart';
import 'package:qr_code_scanner_and_generator/src/shared/models/bar_code_model.dart';
import 'package:qr_code_scanner_and_generator/src/shared/controllers/base_state_controller.dart';
import 'package:qr_code_scanner_and_generator/src/historic/states/historic_state.dart';
import 'package:qr_code_scanner_and_generator/src/shared/models/message_model.dart';

typedef FilterBarcodesByDate = ({String date, List<BarcodeModel> barcodes});

class HistoricController extends BaseStateController<HistoricState>
    with MessageController {
  HistoricController(this._service) : super(InitialHistoricState()) {
    addListener(() {
      debugPrint("STATE: $state");
    });
  }

  final IHistoricService _service;

  Future<void> getAllHistoric() async {
    updateState(LoadingHistoricState());
    final result = await _service.getAllHistoric();

    final state = result.fold(
        (error) => FailureHistoricState(messageError: error.messageError ?? ""),
        (barcodes) {
      final filterBarcodeByDate = filterBarcodeBydate(barcodes);
      return SuccessHistoricState(data: filterBarcodeByDate);
    });

    updateState(state);
  }

  Future<void> saveItemInHistoric(BarcodeModel barcode) async {
    final result = await _service.saveItemInHistoric(barcode);

    final state = result.fold(
        (error) => FailureHistoricState(messageError: error.messageError ?? ""),
        (barcodes) {
      final filterBarcodeByDate = filterBarcodeBydate(barcodes);
      return SuccessHistoricState(data: filterBarcodeByDate);
    });

    updateState(state);
  }

  Future<void> deleteItemInHistoric(int? id) async {
    final result = await _service.deleteItemInHistoric(id);

    final state = result.fold((error) {
      showMessage(MessageModel.error(message: "Erro ao deletar o qr code"));
      return FailureHistoricState(messageError: error.messageError ?? "");
    }, (barcodes) {
      final filterBarcodeByDate = filterBarcodeBydate(barcodes);
      showMessage(
          MessageModel.success(message: "Qr code deletado com sucesso"));
      return SuccessHistoricState(data: filterBarcodeByDate);
    });

    updateState(state);
  }

  Future<void> updateItemInHistoric(int? id, BarcodeModel barcode) async {
    updateState(LoadingHistoricState());

    final result =
        await _service.updateItemInHistoric(id: id, newData: barcode);

    final state = result.fold((error) {
      showMessage(MessageModel.error(message: "Erro ao atualizar o qr code"));
      return FailureHistoricState(messageError: error.messageError ?? "");
    }, (barcodes) {
      final filterBarcodeByDate = filterBarcodeBydate(barcodes);
      showMessage(MessageModel.success(message: "Atualizado com sucesso"));
      return SuccessHistoricState(data: filterBarcodeByDate);
    });

    updateState(state);
  }

  List<FilterBarcodesByDate> filterBarcodeBydate(List<BarcodeModel> barcodes) {
    final Map<String, List<BarcodeModel>> filterBarcodes = {};

    for (var barcode in barcodes) {
      filterBarcodes.addAll({barcode.createdAt.diaMesAnoAbrev(): []});
    }

    for (var key in filterBarcodes.keys) {
      filterBarcodes[key] = barcodes
          .where((bc) => bc.createdAt.diaMesAnoAbrev().compareTo(key) == 0)
          .toList();
    }

    return filterBarcodes.entries
        .map((entry) => (date: entry.key, barcodes: entry.value))
        .toList();
  }
}
