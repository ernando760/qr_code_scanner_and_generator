import 'package:qr_code_scanner_and_generator/src/shared/exceptions/base_exception.dart';

abstract class IServiceException extends BaseException {
  IServiceException({super.label, super.messageError, super.stackTrace});
}

class HistoricServiceException extends IServiceException {
  HistoricServiceException({super.label, super.messageError, super.stackTrace});
}
