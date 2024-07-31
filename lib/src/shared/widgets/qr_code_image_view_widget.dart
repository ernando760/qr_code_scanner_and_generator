import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeImageViewWidget extends StatelessWidget {
  const QrCodeImageViewWidget(
      {super.key,
      required this.code,
      this.size,
      this.backgroundColor,
      this.qrcodeImageKey});
  final Key? qrcodeImageKey;
  final String code;
  final double? size;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: qrcodeImageKey,
      child: QrImageView(
        size: size ?? 150,
        data: code,
        backgroundColor: backgroundColor ?? Colors.white,
      ),
    );
  }
}
