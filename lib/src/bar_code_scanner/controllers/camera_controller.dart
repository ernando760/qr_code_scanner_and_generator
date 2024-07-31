import 'package:qr_code_scanner_and_generator/src/bar_code_scanner/controllers/i_qr_code_controller.dart';
import 'package:qr_code_scanner_and_generator/src/shared/controllers/base_state_controller.dart';

class CameraController extends BaseController<CameraFacingEnum> {
  CameraController(this._iQrCodeController) : super(CameraFacingEnum.back);
  final IBarcodeController? _iQrCodeController;

  Future<void> flipCamera() async {
    final facing =
        await _iQrCodeController?.flipCamera() ?? CameraFacingEnum.back;
    updateState(facing);
  }

  Future<void> pauseCamera() async => _iQrCodeController?.pauseCamera();

  Future<void> resumeCamera() async => _iQrCodeController?.resumeCamera();

  @override
  String toString() =>
      "$runtimeType(_iQrCodeController: $_iQrCodeController, state: $state)";
}
