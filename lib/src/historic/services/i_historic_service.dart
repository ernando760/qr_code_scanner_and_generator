import 'package:fpdart/fpdart.dart';
import 'package:qr_code_scanner_and_generator/src/shared/data/exceptions/service_exception.dart';
import 'package:qr_code_scanner_and_generator/src/shared/models/bar_code_model.dart';

abstract class IHistoricService {
  Future<Either<IServiceException, List<BarcodeModel>>> getAllHistoric();
  Future<Either<IServiceException, List<BarcodeModel>>> saveItemInHistoric(
      BarcodeModel barcodeModel);
  Future<Either<IServiceException, List<BarcodeModel>>> deleteItemInHistoric(
      int? id);
  Future<Either<IServiceException, List<BarcodeModel>>> updateItemInHistoric(
      {required int? id, required BarcodeModel newData});
}
