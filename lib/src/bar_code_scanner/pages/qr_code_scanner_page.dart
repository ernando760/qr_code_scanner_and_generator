import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:qr_code_scanner_and_generator/src/bar_code_scanner/controllers/code_scanner_controller.dart';
import 'package:qr_code_scanner_and_generator/src/bar_code_scanner/controllers/custom_qr_view_code_controller.dart';
import 'package:qr_code_scanner_and_generator/src/bar_code_scanner/mixins/barcode_scanner_state_mixin.dart';
import 'package:qr_code_scanner_and_generator/src/bar_code_scanner/widgets/flash_button_widget.dart';
import 'package:qr_code_scanner_and_generator/src/injector/app_injector.dart';
import 'package:qr_code_scanner_and_generator/src/bar_code_scanner/widgets/flip_camera_button_widget.dart';

class QrCodeScannerPage extends StatefulWidget {
  const QrCodeScannerPage({super.key});

  @override
  State<QrCodeScannerPage> createState() => _QrCodeScannerPageState();
}

class _QrCodeScannerPageState extends State<QrCodeScannerPage>
    with BarcodeScannerMixin, AutomaticKeepAliveClientMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  final CodeScannerController controller =
      appModule.get<CodeScannerController>();

  Future<void> _listener() async {
    controller.codeListener();
    await scannerlisten(controller);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    controller.addListener(_listener);
  }

  @override
  void dispose() {
    controller.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return Stack(
              children: [
                QRView(
                  key: qrKey,
                  overlay: QrScannerOverlayShape(
                    borderRadius: 10,
                    borderWidth: 6,
                  ),
                  onQRViewCreated: (qrViewController) async {
                    final customQrViewCodeController =
                        CustomQrViewCodeController(qrViewController);
                    controller.onCreated(customQrViewCodeController);
                  },
                ),
                Positioned(
                    left: 20,
                    top: 20,
                    child: FlashButtonWidget(
                      controller: controller.flashController,
                    )),
                Positioned(
                    right: 20,
                    top: 20,
                    child: FlipCameraButtonWidget(
                      controller: controller.cameraController,
                    )),
              ],
            );
          }),
    );
  }
}
