import 'dart:async';

import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner_and_generator/src/bar_code_scanner/controllers/i_qr_code_controller.dart';
import 'package:qr_code_scanner_and_generator/src/shared/models/bar_code_model.dart';

class CustomQrViewCodeController extends IBarcodeController {
  QRViewController? _qrViewController;

  CustomQrViewCodeController._internal(this._qrViewController);

  static CustomQrViewCodeController? _instance;

  factory CustomQrViewCodeController(QRViewController? qrViewController) {
    _instance ??= CustomQrViewCodeController._internal(qrViewController);
    return _instance!;
  }

  CameraFacingEnum _cameraFacing = CameraFacingEnum.unknown;

  @override
  CameraFacingEnum get cameraFacing => _cameraFacing;

  @override
  Future<CameraFacingEnum> flipCamera() async {
    final index = (await _qrViewController?.flipCamera())?.index ?? 0;
    _cameraFacing = CameraFacingEnum.values[index];
    return _cameraFacing;
  }

  @override
  Future<void> pauseCamera() async => _qrViewController?.pauseCamera();

  @override
  Future<void> resumeCamera() async => _qrViewController?.resumeCamera();

  @override
  Future<void> toggleFlash() async => _qrViewController?.toggleFlash();

  @override
  Future<bool?> getFlashStatus() async =>
      await _qrViewController?.getFlashStatus();

  @override
  Future<CameraFacingEnum> getCameraStatus() async {
    final index = (await _qrViewController?.getCameraInfo())?.index ?? 0;
    _cameraFacing = CameraFacingEnum.values[index];
    return _cameraFacing;
  }

  @override
  Stream<BarcodeModel>? get barcodeStream =>
      _qrViewController?.scannedDataStream
          .map((event) => BarcodeModel(
              code: event.code,
              format: _covertCodeFormat(event.format),
              createdAt: DateTime.now()))
          .asBroadcastStream();

  CodeFormat _covertCodeFormat(BarcodeFormat barcodeFormat) {
    return switch (barcodeFormat) {
      BarcodeFormat.aztec => CodeFormat.aztec,
      BarcodeFormat.codabar => CodeFormat.codabar,
      BarcodeFormat.qrcode => CodeFormat.qrcode,
      _ => CodeFormat.unknown
    };
  }

  @override
  String toString() => "$runtimeType(_qrViewController: $_qrViewController)";
}
