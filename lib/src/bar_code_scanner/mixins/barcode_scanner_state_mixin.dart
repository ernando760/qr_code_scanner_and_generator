import 'package:flutter/material.dart';
import 'package:qr_code_scanner_and_generator/src/bar_code_scanner/controllers/code_scanner_controller.dart';
import 'package:qr_code_scanner_and_generator/src/bar_code_scanner/pages/qr_code_scanner_page.dart';
import 'package:qr_code_scanner_and_generator/src/bar_code_scanner/states/code_scanner_state.dart';
import 'package:qr_code_scanner_and_generator/src/shared/widgets/bottom_sheet_barcode_result_widget.dart';
import 'package:qr_code_scanner_and_generator/src/historic/controllers/historic_controller.dart';
import 'package:qr_code_scanner_and_generator/src/injector/app_injector.dart';

mixin BarcodeScannerMixin on State<QrCodeScannerPage> {
  Future<void> scannerlisten(CodeScannerController controller) async {
    if (controller.state is ScannedBarcodeCodeScannerState) {
      if (controller.state.barcode.code != null) {
        await Future.wait([
          controller.pauseCamera(),
          appModule
              .get<HistoricController>()
              .saveItemInHistoric(controller.state.barcode),
          controller.resumeCamera()
        ]);

        if (mounted) {
          Scaffold.of(context)
              .showBottomSheet((context) => BottomSheetBarcodeResultWidget(
                    barcode: controller.state.barcode,
                  ));
        }
      }
    }
  }
}
