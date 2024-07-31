import 'package:fpdart/fpdart.dart';
import 'package:qr_code_scanner_and_generator/src/shared/data/exceptions/repository_exception.dart';
import 'package:qr_code_scanner_and_generator/src/shared/models/bar_code_model.dart';

abstract class IHistoricRepository {
  Future<Either<IRepositoryException, List<BarcodeModel>>> getAllHistoric();
  Future<Either<IRepositoryException, List<BarcodeModel>>> saveItemInHistoric(
      BarcodeModel barcodeModel);
  Future<Either<IRepositoryException, List<BarcodeModel>>> deleteItemInHistoric(
      int id);
  Future<Either<IRepositoryException, List<BarcodeModel>>> updateItemInHistoric(
      {required int id, required BarcodeModel newData});
}
