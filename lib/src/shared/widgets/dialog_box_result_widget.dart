import 'package:flutter/material.dart';

import 'package:qr_code_scanner_and_generator/src/shared/models/bar_code_model.dart';
import 'package:qr_code_scanner_and_generator/src/shared/utils/clip_board_util.dart';
import 'package:qr_code_scanner_and_generator/src/shared/widgets/custom_text_barcode_widget.dart';

class DialogBoxResultWidget extends StatelessWidget {
  const DialogBoxResultWidget({
    super.key,
    required this.barcode,
    this.onBack,
  });
  final BarcodeModel barcode;

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onBack,
      child: AlertDialog(
        title: const Text("Resultado"),
        actions: [
          ElevatedButton(onPressed: onBack, child: const Text("Voltar")),
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextBarcodeWidget(text: barcode.code ?? ""),
            IconButton(
                onPressed: () async {
                  await clipBoardUtil(context, barcode.code ?? "");
                },
                icon: const Icon(Icons.copy))
          ],
        ),
      ),
    );
  }
}
