import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_code_scanner_and_generator/src/injector/app_injector.dart';
import 'package:qr_code_scanner_and_generator/src/shared/controllers/message_controller.dart';
import 'package:qr_code_scanner_and_generator/src/shared/controllers/qr_code_image_controller.dart';
import 'package:qr_code_scanner_and_generator/src/shared/models/bar_code_model.dart';
import 'package:qr_code_scanner_and_generator/src/shared/widgets/copy_button_widget.dart';
import 'package:qr_code_scanner_and_generator/src/shared/widgets/custom_text_barcode_widget.dart';
import 'package:qr_code_scanner_and_generator/src/shared/widgets/dowload_qr_code_image_button_widget.dart';
import 'package:qr_code_scanner_and_generator/src/shared/widgets/qr_code_image_view_widget.dart';

class BottomSheetBarcodeResultWidget extends StatefulWidget {
  const BottomSheetBarcodeResultWidget(
      {super.key, this.onClosing, required this.barcode});
  final VoidCallback? onClosing;
  final BarcodeModel barcode;

  @override
  State<BottomSheetBarcodeResultWidget> createState() =>
      _BottomSheetBarcodeResultWidgetState();
}

class _BottomSheetBarcodeResultWidgetState
    extends State<BottomSheetBarcodeResultWidget>
    with MessageStateNotificationMixin<BottomSheetBarcodeResultWidget> {
  final controller = appModule.get<QrCodeImageController>();
  final qrcodeImageKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    messageControllerListener(controller);
  }

  @override
  void dispose() {
    removeMessageControllerListener(controller);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: widget.onClosing ?? () {},
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header Bottom sheet
              Stack(
                alignment: Alignment.center,
                children: [
                  const Align(
                    child: Text(
                      "Resultado",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close)),
                  ),
                ],
              ),

              // Body Bottom sheet
              QrCodeImageViewWidget(
                  key: qrcodeImageKey, code: "${widget.barcode.code}"),

              CustomTextBarcodeWidget(text: widget.barcode.code ?? ""),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * .01,
              ),

              // Footer Bottom sheet
              Row(
                children: [
                  Expanded(
                    child: CopyButtonWidget(data: widget.barcode.code ?? ""),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).height * .01,
                  ),
                  Expanded(
                    child: DowloadQrCodeImageButtonWidget(
                      data: widget.barcode.code ?? "",
                      getBoundary: () {
                        final boundary = qrcodeImageKey.currentContext
                            ?.findRenderObject() as RenderRepaintBoundary?;
                        return boundary;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
