import 'package:flutter/material.dart';
import 'package:qr_code_scanner_and_generator/src/historic/controllers/historic_controller.dart';
import 'package:qr_code_scanner_and_generator/src/injector/app_injector.dart';
import 'package:qr_code_scanner_and_generator/src/historic/widgets/historic_empty_widget.dart';
import 'package:qr_code_scanner_and_generator/src/historic/widgets/historic_state_builder_widget.dart';
import 'package:qr_code_scanner_and_generator/src/historic/widgets/list_barcode_widget.dart';
import 'package:qr_code_scanner_and_generator/src/shared/controllers/message_controller.dart';

class HistoricPage extends StatefulWidget {
  const HistoricPage({super.key});

  @override
  State<HistoricPage> createState() => _HistoricPageState();
}

class _HistoricPageState extends State<HistoricPage>
    with MessageStateNotificationMixin {
  final controller = appModule.get<HistoricController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      messageControllerListener(controller);
      await controller.getAllHistoric();
    });
  }

  @override
  void dispose() {
    removeMessageControllerListener(controller);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      backgroundColor: Colors.white60,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: HistoricStateBuilderWidget<List<FilterBarcodesByDate>>(
          controller: controller,
          onLoading: () => const Center(child: CircularProgressIndicator()),
          onSuccess: (barcodes) => barcodes.isEmpty
              ? const HistoricEmptyWidget()
              : ListBarcodeWidget(filterBarcodes: barcodes),
          onFailure: (messageError) => Center(child: Text(messageError)),
        ),
      ),
    );
  }
}
