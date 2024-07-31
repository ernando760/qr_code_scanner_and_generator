import 'package:flutter/material.dart';
import 'package:qr_code_scanner_and_generator/src/home/controllers/bottom_navigation_bar_controller.dart';
import 'package:qr_code_scanner_and_generator/src/historic/pages/historic_page.dart';
import 'package:qr_code_scanner_and_generator/src/bar_code_generator/pages/qr_code_generator_page.dart';
import 'package:qr_code_scanner_and_generator/src/bar_code_scanner/pages/qr_code_scanner_page.dart';
import 'package:qr_code_scanner_and_generator/src/home/widgets/custom_bottom_navigation_bar_widget.dart';
import 'package:qr_code_scanner_and_generator/src/injector/app_injector.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pageController = PageController(keepPage: false);
  final bottomNavigationBarController =
      appModule.get<BottomNavigationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: pages.length,
        onPageChanged: (index) {
          bottomNavigationBarController.change(index);
        },
        itemBuilder: (context, index) {
          return pages[index];
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBarWidget(
          controller: bottomNavigationBarController,
          onTap: (value) async {
            await pageController.animateToPage(value,
                duration: const Duration(milliseconds: 200),
                curve: Curves.linear);
            bottomNavigationBarController.change(value);
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.qr_code_scanner), label: "Ler"),
            BottomNavigationBarItem(icon: Icon(Icons.edit), label: "Criar"),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: "Historico"),
          ]),
    );
  }
}

final List<Widget> pages = [
  const QrCodeScannerPage(),
  const QrCodeGeneratePage(),
  const HistoricPage()
];
