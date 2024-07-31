import 'dart:typed_data';

import 'package:qr_code_scanner_and_generator/src/shared/controllers/base_state_controller.dart';
import 'package:qr_code_scanner_and_generator/src/shared/controllers/message_controller.dart';
import 'package:qr_code_scanner_and_generator/src/shared/models/message_model.dart';
import 'package:qr_code_scanner_and_generator/src/shared/services/qr_code_image_service/i_qr_code_image_service.dart';
import 'package:qr_code_scanner_and_generator/src/shared/states/qr_code_image_state.dart';

class QrCodeImageController extends BaseController<QrcodeImageState>
    with MessageController {
  final IQrcodeImageService _service;

  QrCodeImageController(this._service) : super(InitialImageState());

  Future<void> getQrcodeImage(String name) async {
    final res = await _service.getQrcodeImage(name: name);

    final state = res.fold((failure) {
      showMessage(MessageModel.error(message: failure.messageError ?? ""));
    }, (qrcodeFile) => SuccessQrcodeImageState(qrcodeFile: qrcodeFile));

    if (state != null) {
      updateState(state);
    }
  }

  Future<void> saveQrcodeImage(String name, Uint8List bytes) async {
    final res = await _service.saveQrcode(name: name, bytes: bytes);

    final state = res.fold((failure) {
      showMessage(MessageModel.error(message: failure.messageError ?? ""));
    }, (qrcodeFile) {
      showMessage(MessageModel.success(message: "Imagem salva com sucesso"));
      return SuccessQrcodeImageState(qrcodeFile: qrcodeFile);
    });

    if (state != null) {
      updateState(state);
    }
  }
}
