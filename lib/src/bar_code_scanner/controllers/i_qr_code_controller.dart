import 'dart:async';

import 'package:qr_code_scanner_and_generator/src/shared/models/bar_code_model.dart';

enum CameraFacingEnum {
  back,
  front,
  unknown;
}

abstract class IBarcodeController {
  CameraFacingEnum get cameraFacing => CameraFacingEnum.unknown;
  Future<void> pauseCamera();
  Future<void> resumeCamera();
  Future<void> toggleFlash();
  Future<CameraFacingEnum> flipCamera() async => CameraFacingEnum.back;
  Future<bool?> getFlashStatus() async => false;
  Future<CameraFacingEnum> getCameraStatus() async => CameraFacingEnum.back;
  Stream<BarcodeModel>? get barcodeStream => const Stream.empty();
}
