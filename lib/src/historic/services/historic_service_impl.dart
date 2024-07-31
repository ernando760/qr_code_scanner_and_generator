import 'package:fpdart/fpdart.dart';
import 'package:qr_code_scanner_and_generator/src/shared/data/exceptions/service_exception.dart';
import 'package:qr_code_scanner_and_generator/src/historic/repositories/i_historic_repository.dart';
import 'package:qr_code_scanner_and_generator/src/historic/services/i_historic_service.dart';
import 'package:qr_code_scanner_and_generator/src/shared/models/bar_code_model.dart';

class HistoricServiceImpl implements IHistoricService {
  final IHistoricRepository _repository;

  HistoricServiceImpl(this._repository);
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
