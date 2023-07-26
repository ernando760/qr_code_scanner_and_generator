import 'package:flutter/material.dart';
import 'package:qr_code_scanner_and_generator/home_page.dart';
import 'package:qr_code_scanner_and_generator/src/pages/qr_code_generator_page.dart';
import 'package:qr_code_scanner_and_generator/src/pages/qr_code_scanner_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Qr code Scanner and Generator",
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        "/qrCodeScanner": (context) => const QrCodeSccanerPage(),
        "/qrCodeGenerator": (context) => const QrCodeGeneratePage(),
      },
    );
  }
}
