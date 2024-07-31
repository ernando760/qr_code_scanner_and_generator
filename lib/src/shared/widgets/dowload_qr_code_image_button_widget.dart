import 'dart:math' as math;
import 'dart:developer' as dev;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_code_scanner_and_generator/src/injector/app_injector.dart';
import 'package:qr_code_scanner_and_generator/src/shared/controllers/qr_code_image_controller.dart';
import 'dart:ui' as ui;

class DowloadQrCodeImageButtonWidget extends StatelessWidget {
  const DowloadQrCodeImageButtonWidget(
      {super.key, this.getBoundary, required this.data});
  // final RenderRepaintBoundary? boundary;
  final String data;

  final RenderRepaintBoundary? Function()? getBoundary;

  @override
  Widget build(BuildContext context) {
    final controller = appModule.get<QrCodeImageController>();

    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)))),
        onPressed: () async {
          final boundary = getBoundary?.call();
          dev.log("$boundary", name: "Boundary");
          if (boundary != null) {
            ui.Image image = await boundary.toImage(pixelRatio: 3.0);

            ByteData? byteData =
                await image.toByteData(format: ui.ImageByteFormat.png);
            final pngBytes = byteData!.buffer.asUint8List();

            final name = "qr_code_${data}_${math.Random().nextInt(100)}";
            await controller.saveQrcodeImage(name, pngBytes);
            if (context.mounted) {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            }
          }
        },
        icon: const Icon(
          Icons.download,
          size: 26,
          color: Colors.white,
        ),
        label: const Text(
          "Baixar",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ));
  }
}
