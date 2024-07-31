import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> clipBoardUtil(BuildContext context, String data,
    {bool showSnackBar = true}) async {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  await Clipboard.setData(ClipboardData(text: data));
  scaffoldMessenger
      .showSnackBar(SnackBar(content: Text("$data copiado com sucesso")));
}
