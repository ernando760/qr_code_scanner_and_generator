import 'package:qr_code_scanner_and_generator/src/shared/exceptions/base_exception.dart';

class IDatabaseException extends BaseException {
  IDatabaseException({super.label, super.messageError, super.stackTrace});
}

class OpenDatabaseException extends IDatabaseException {
  OpenDatabaseException({super.label, super.messageError, super.stackTrace});
}

class CrudDatabaseException extends IDatabaseException {
  CrudDatabaseException({super.label, super.messageError, super.stackTrace});
}
