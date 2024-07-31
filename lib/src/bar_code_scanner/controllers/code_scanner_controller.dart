import 'dart:async';
import 'dart:developer';

import 'package:qr_code_scanner_and_generator/src/bar_code_scanner/controllers/camera_controller.dart';

import 'package:qr_code_scanner_and_generator/src/bar_code_scanner/controllers/flash_controller.dart';
import 'package:qr_code_scanner_and_generator/src/bar_code_scanner/controllers/i_qr_code_controller.dart';
import 'package:qr_code_scanner_and_generator/src/bar_code_scanner/states/code_scanner_state.dart';
import 'package:qr_code_scanner_and_generator/src/shared/controllers/base_state_controller.dart';
import 'package:qr_code_scanner_and_generator/src/shared/models/bar_code_model.dart';

class CodeScannerController extends BaseStateController<CodeScannerState> {
  CodeScannerController() : super(EmptyBarcodeCodeScannerState());

  IBarcodeController? _qrCodeController;
  FlashController? _flashController;
  CameraController? _cameraController;

  FlashController get flashController =>
      _flashController ?? FlashController(null);
  CameraController get cameraController =>
      _cameraController ?? CameraController(null);

  Stream<BarcodeModel>? get barCodeStream =>
      _qrCodeController?.barcodeStream?.asBroadcastStream();

  Future<void> pauseCamera() async => await _cameraController?.pauseCamera();
  Future<void> resumeCamera() async => await _cameraController?.resumeCamera();
  Future<void> flipCamera() async => await _cameraController?.flipCamera();

  Future<void> toggleFlash() async => await _flashController?.toggleFlash();

  void onCreated(IBarcodeController qrCodeController) {
    _qrCodeController ??= qrCodeController;
    _flashController ??= FlashController(qrCodeController);
    _cameraController ??= CameraController(qrCodeController);
    notifyListeners();
  }

  void _barcodeListen(BarcodeModel barcode) {
    updateState(ScannedBarcodeCodeScannerState(barcode: barcode));
    log("$barcode", name: "On listen");
    log("$state", name: "State");
  }

  StreamSubscription<BarcodeModel>? subscriptionBarcode;
  void codeListener() {
    if (_qrCodeController != null && subscriptionBarcode == null) {
      subscriptionBarcode = _qrCodeController!.barcodeStream
          ?.asBroadcastStream()
          .listen(_barcodeListen, onDone: () async {});
    }
  }

  Future<void> stopListening() async {
    await subscriptionBarcode?.cancel();
    subscriptionBarcode = null;
  }
}
