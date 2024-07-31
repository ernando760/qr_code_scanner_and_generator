import 'package:flutter/material.dart';
import 'package:qr_code_scanner_and_generator/src/shared/utils/clip_board_util.dart';

class CopyButtonWidget extends StatelessWidget {
  const CopyButtonWidget({super.key, required this.data});
  final String data;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amberAccent,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)))),
        onPressed: () async {
          await clipBoardUtil(context, data);
        },
        icon: const Icon(
          Icons.copy,
          size: 26,
          color: Colors.white,
        ),
        label: const Text(
          "Copiar",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ));
  }
}
