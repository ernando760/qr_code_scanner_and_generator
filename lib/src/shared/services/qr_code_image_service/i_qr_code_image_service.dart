import 'dart:io';
import 'dart:typed_data';

import 'package:fpdart/fpdart.dart';
import 'package:qr_code_scanner_and_generator/src/shared/services/exceptions/qr_code_image_exception.dart';

enum MimeType { jpg, png }

abstract class IQrcodeImageService {
  Future<Either<QrCodeImageException, File>> getQrcodeImage(
      {required String name, MimeType miniType = MimeType.png});
  Future<Either<QrCodeImageException, File>> saveQrcode(
      {required String name,
      required Uint8List bytes,
      MimeType miniType = MimeType.png});
}
