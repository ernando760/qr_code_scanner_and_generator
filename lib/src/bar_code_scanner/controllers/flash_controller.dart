import 'dart:developer';

import 'package:qr_code_scanner_and_generator/src/bar_code_scanner/controllers/i_qr_code_controller.dart';
import 'package:qr_code_scanner_and_generator/src/shared/controllers/base_state_controller.dart';

class FlashController extends BaseController<bool> {
  FlashController(this._iQrCodeController) : super(false);
  final IBarcodeController? _iQrCodeController;

  Future<void> toggleFlash() async {
    await _iQrCodeController?.toggleFlash();
    final flash = await _iQrCodeController?.getFlashStatus() ?? false;
    log("flash: $flash");
    updateState(flash);
  }

  @override
  String toString() =>
      "$runtimeType(_iQrCodeController: $_iQrCodeController, state: $state)";
}
