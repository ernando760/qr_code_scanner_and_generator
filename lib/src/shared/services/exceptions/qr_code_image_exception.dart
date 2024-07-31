import 'package:qr_code_scanner_and_generator/src/shared/exceptions/base_exception.dart';

class QrCodeImageException extends BaseException {
  QrCodeImageException({super.label, super.messageError, super.stackTrace});
}
