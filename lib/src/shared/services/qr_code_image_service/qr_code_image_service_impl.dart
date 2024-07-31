import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:fpdart/fpdart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_code_scanner_and_generator/src/shared/services/exceptions/qr_code_image_exception.dart';
import 'package:qr_code_scanner_and_generator/src/shared/services/permissions_service/i_permission_service.dart';
import 'package:qr_code_scanner_and_generator/src/shared/services/qr_code_image_service/i_qr_code_image_service.dart';

class QrCodeImageServiceImpl extends IQrcodeImageService {
  final IPermissionService _permission;

  QrCodeImageServiceImpl(this._permission);

  @override
  Future<Either<QrCodeImageException, File>> getQrcodeImage(
      {required String name, MimeType miniType = MimeType.png}) async {
    try {
      final status = await _permission.request(AppTypePermission.storage);

      if (status.isdenied) {
        return Left(QrCodeImageException(
            label: "$runtimeType-saveQrcode",
            messageError: "A permissão foi negada"));
      }

      if (name.isEmpty) {
        return Left(QrCodeImageException(
            label: "$runtimeType-getQrcodeImage",
            messageError: "O nome do arquivo está vazio"));
      }

      final directory = await getApplicationDocumentsDirectory();
      final imagePath = "${directory.path}/$name.${miniType.name}";
      final imageFile = File(imagePath);

      return Right(imageFile);
    } catch (e, s) {
      return Left(QrCodeImageException(
          label: "$runtimeType-getQrcodeImage",
          messageError: e.toString(),
          stackTrace: s));
    }
  }

  @override
  Future<Either<QrCodeImageException, File>> saveQrcode(
      {required String name,
      required Uint8List bytes,
      MimeType miniType = MimeType.png}) async {
    try {
      final status = await _permission.request(AppTypePermission.storage);
      if (status.isdenied) {
        return Left(QrCodeImageException(
            label: "$runtimeType-saveQrcode",
            messageError: "A permissão foi negada"));
      }

      if (name.isEmpty) {
        return Left(QrCodeImageException(
            label: "$runtimeType-saveQrcode",
            messageError: "O nome do arquivo está vazio"));
      }

      final directory = await getApplicationDocumentsDirectory();
      final imagePath =
          "${directory.path}/${name}_${Random().nextInt(100)}.png";
      final imageFile = File(imagePath);
      await imageFile.writeAsBytes(bytes);

      final params = SaveFileDialogParams(
        sourceFilePath: imageFile.path,
      );

      final finalPath = await FlutterFileDialog.saveFile(params: params);
      if (finalPath != null) {
        return Right(imageFile);
      }

      return Left(QrCodeImageException(
          label: "$runtimeType-saveQrcode",
          messageError: "O qrcode não foi salvo"));
    } catch (e, s) {
      return Left(QrCodeImageException(
          label: "$runtimeType-saveQrcode",
          messageError: e.toString(),
          stackTrace: s));
    }
  }
}
