import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("home page"),
      ),
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, "/qrCodeScanner"),
                child: const Text("Qr code scanner")),
            ElevatedButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, "/qrCodeGenerator"),
                child: const Text("Qr code Generator"))
          ],
        ),
      ),
    );
  }
}
