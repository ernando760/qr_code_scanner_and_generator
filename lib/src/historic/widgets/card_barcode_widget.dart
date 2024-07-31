import 'package:flutter/material.dart';
import 'package:qr_code_scanner_and_generator/src/shared/models/bar_code_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CardBarcodeWidget extends StatelessWidget {
  const CardBarcodeWidget(
      {super.key, required this.barcode, this.onCopy, this.onDelete});
  final BarcodeModel barcode;

  final VoidCallback? onCopy;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key("${barcode.id}_key"),
      leading: barcode.bytes != null
          ? QrImageView.withQr(
              qr: QrCode.fromUint8List(
                  data: barcode.bytes!, errorCorrectLevel: 0))
          : const Icon(Icons.qr_code),
      title: Text(
        "Código: ${barcode.code}",
        style: const TextStyle(overflow: TextOverflow.ellipsis),
      ),
      subtitle: Text(
        "Formato: ${barcode.format.name}",
        style: const TextStyle(overflow: TextOverflow.ellipsis),
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox.fromSize(
            size: const Size.fromRadius(18),
            child: IconButton(
                key: const Key("copy_button_key"),
                onPressed: onCopy,
                icon: const Icon(
                  Icons.copy,
                  size: 20,
                )),
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * .01,
          ),
          SizedBox.fromSize(
            size: const Size.fromRadius(18),
            child: IconButton(
                key: const Key("delete_button_key"),
                padding: EdgeInsets.zero,
                onPressed: onDelete,
                icon: const Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                )),
          ),
        ],
      ),
    );
  }
}
