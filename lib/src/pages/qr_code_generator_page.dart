import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeGeneratePage extends StatefulWidget {
  const QrCodeGeneratePage({super.key});

  @override
  State<QrCodeGeneratePage> createState() => _QrCodeGeneratePageState();
}

class _QrCodeGeneratePageState extends State<QrCodeGeneratePage> {
  late final TextEditingController _controller;
  final ValueNotifier<String> _qrCodeValue = ValueNotifier("nada");
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Qr code Generator"),
        leading: IconButton(
            onPressed: () => Navigator.pushReplacementNamed(context, "/"),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SizedBox(
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ValueListenableBuilder(
                    valueListenable: _qrCodeValue,
                    builder: (context, value, _) {
                      return SizedBox(
                        child: QrImageView(
                          data: value,
                          size: 200,
                          embeddedImageStyle:
                              const QrEmbeddedImageStyle(size: Size(50, 50)),
                        ),
                      );
                    }),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "enter a data"),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        _qrCodeValue.value = _controller.text;
                      }
                    },
                    child: const Text("generate Qr code"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
