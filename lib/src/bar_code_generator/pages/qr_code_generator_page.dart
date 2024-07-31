import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_code_scanner_and_generator/src/bar_code_generator/controllers/qr_code_generator_bar_controller.dart';
import 'package:qr_code_scanner_and_generator/src/bar_code_generator/widgets/bar_code_generator_state_builder_widget.dart';
import 'package:qr_code_scanner_and_generator/src/injector/app_injector.dart';
import 'package:qr_code_scanner_and_generator/src/shared/widgets/copy_button_widget.dart';
import 'package:qr_code_scanner_and_generator/src/shared/widgets/dowload_qr_code_image_button_widget.dart';
import 'package:qr_code_scanner_and_generator/src/shared/widgets/qr_code_image_view_widget.dart';

class QrCodeGeneratePage extends StatefulWidget {
  const QrCodeGeneratePage({super.key});

  @override
  State<QrCodeGeneratePage> createState() => _QrCodeGeneratePageState();
}

class _QrCodeGeneratePageState extends State<QrCodeGeneratePage> {
  final controller = appModule.get<BarCodeGeneratorBarController>();

  final qrcodeImageKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Qr code Generator",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      backgroundColor: Colors.white60,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          height: size.height,
          child: Center(
            child: BarCodeGeneratorStateBuilderWidget(
                controller: controller,
                onChangeBarcode: (barcode) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: QrCodeImageViewWidget(
                          key: qrcodeImageKey,
                          code: barcode.qrData,
                          size: 200,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: CopyButtonWidget(data: barcode.qrData)),
                          SizedBox(
                            width: size.height * .01,
                          ),
                          Expanded(
                              child: DowloadQrCodeImageButtonWidget(
                            data: barcode.qrData,
                            getBoundary: () {
                              final boundary = qrcodeImageKey.currentContext
                                      ?.findRenderObject()
                                  as RenderRepaintBoundary?;
                              return boundary;
                            },
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        child: TextFormField(
                          initialValue: barcode.textData,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Digite algo",
                          ),
                          onChanged: controller.onChangeTextData,
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.color_lens_outlined),
      ),
    );
  }
}
