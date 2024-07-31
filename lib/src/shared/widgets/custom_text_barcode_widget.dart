import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomTextBarcodeWidget extends StatelessWidget {
  const CustomTextBarcodeWidget({super.key, required this.text, this.style});
  final String text;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    final uri = Uri.tryParse(text);
    if (uri != null && uri.isAbsolute) {
      return TextButton(
        onPressed: () async => await launchUrl(uri),
        child: Text(text,
            style: style ??
                const TextStyle(
                    fontSize: 22,
                    decorationColor: Colors.blue,
                    decoration: TextDecoration.underline,
                    color: Colors.blue)),
      );
    }
    return Text(text,
        style: style ??
            const TextStyle(
              fontSize: 22,
            ));
  }
}
