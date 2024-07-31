import 'package:flutter/material.dart';
import 'package:qr_code_scanner_and_generator/src/historic/controllers/historic_controller.dart';
import 'package:qr_code_scanner_and_generator/src/injector/app_injector.dart';

import 'package:qr_code_scanner_and_generator/src/shared/utils/clip_board_util.dart';
import 'package:qr_code_scanner_and_generator/src/historic/widgets/card_barcode_widget.dart';

class ListBarcodeWidget extends StatelessWidget {
  const ListBarcodeWidget({super.key, required this.filterBarcodes});
  final List<FilterBarcodesByDate> filterBarcodes;
  @override
  Widget build(BuildContext context) {
    final controller = appModule.get<HistoricController>();
    return ListView.builder(
      itemCount: filterBarcodes.length,
      itemBuilder: (context, index) {
        final date = filterBarcodes[index].date;
        final barcodes = filterBarcodes[index].barcodes;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(date),
            ...barcodes.map((barcode) => CardBarcodeWidget(
                  barcode: barcode,
                  onCopy: () async =>
                      await clipBoardUtil(context, barcode.code ?? ""),
                  onDelete: () async =>
                      await controller.deleteItemInHistoric(barcode.id),
                ))
          ],
        );
      },
    );
  }
}
