import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QrCodeSccanerPage extends StatefulWidget {
  const QrCodeSccanerPage({super.key});

  @override
  State<QrCodeSccanerPage> createState() => _QrCodeSccanerPageState();
}

class _QrCodeSccanerPageState extends State<QrCodeSccanerPage> {
  final ValueNotifier<String> _scanQrCode = ValueNotifier("nada");

  scanQrCode() async {
    String qrCodeScan;
    try {
      qrCodeScan = await FlutterBarcodeScanner.scanBarcode(
          "#FF6666", "Cancelar", true, ScanMode.QR);
      log("qr code:$qrCodeScan", name: "qr code");
      _scanQrCode.value = qrCodeScan;
    } catch (_) {
      qrCodeScan = "Error";
      _scanQrCode.value = qrCodeScan;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Qr code scanner"),
        leading: IconButton(
            onPressed: () => Navigator.pushReplacementNamed(context, "/"),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder(
              valueListenable: _scanQrCode,
              builder: (context, value, child) {
                return Text(value);
              },
            ),
            ElevatedButton(
                onPressed: () => scanQrCode(),
                child: const Text("Qr code scanner"))
          ],
        ),
      ),
    );
  }
}
