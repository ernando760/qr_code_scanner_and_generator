import 'package:auto_injector/auto_injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_code_scanner_and_generator/src/historic/controllers/historic_controller.dart';
import 'package:qr_code_scanner_and_generator/src/shared/data/db/i_database.dart';
import 'package:qr_code_scanner_and_generator/src/historic/repositories/historic_repository_impl.dart';
import 'package:qr_code_scanner_and_generator/src/historic/repositories/i_historic_repository.dart';
import 'package:qr_code_scanner_and_generator/src/historic/services/historic_service_impl.dart';
import 'package:qr_code_scanner_and_generator/src/historic/services/i_historic_service.dart';
import 'package:qr_code_scanner_and_generator/src/shared/models/bar_code_model.dart';
import 'package:qr_code_scanner_and_generator/src/historic/states/historic_state.dart';
import 'package:qr_code_scanner_and_generator/src/historic/widgets/historic_empty_widget.dart';
import 'package:qr_code_scanner_and_generator/src/historic/widgets/historic_state_builder_widget.dart';
import 'package:qr_code_scanner_and_generator/src/historic/widgets/list_barcode_widget.dart';

import '../../shared/data/db/sqflite/sqflite_database_impl_test.dart';

final historicModuleTest = AutoInjector(
  tag: "HistoricModule",
  on: (injector) {
    injector.add<IDatabase>(SqfliteDatabaseImplTest.new);
    injector.add<IHistoricRepository>(HistoricRepositoryImpl.new);
    injector.add<IHistoricService>(HistoricServiceImpl.new);
    injector.addSingleton(HistoricController.new);
    injector.commit();
  },
);

class HistoricPageTest extends StatefulWidget {
  const HistoricPageTest({super.key});

  @override
  State<HistoricPageTest> createState() => _HistoricPageTestState();
}

class _HistoricPageTestState extends State<HistoricPageTest> {
  final controller = historicModuleTest.get<HistoricController>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getAllHistoric();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: HistoricStateBuilderWidget<List<FilterBarcodesByDate>>(
        controller: controller,
        onLoading: () => const Center(child: CircularProgressIndicator()),
        onSuccess: (barcodes) => barcodes.isEmpty
            ? const HistoricEmptyWidget(
                key: Key("historic_empty_key"),
              )
            : ListBarcodeWidget(filterBarcodes: barcodes),
        onFailure: (messageError) => Center(child: Text(messageError)),
      ),
    );
  }
}

void main() {
  final dateNow = DateTime.now();
  late HistoricController controller;

  group("Success Test", () {
    setUp(() async {
      controller = historicModuleTest.get<HistoricController>();
      await controller.saveItemInHistoric(BarcodeModel(
          code: "Ernando", format: CodeFormat.qrcode, createdAt: dateNow));
      await controller.saveItemInHistoric(BarcodeModel(
          code: "Pedro", format: CodeFormat.qrcode, createdAt: dateNow));
    });
    tearDownAll(() => controller.updateState(InitialHistoricState()));

    testWidgets('Deve retornar um estado de sucesso quando construir o widget',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: HistoricPageTest()));

      final itemType = find.byType(ListTile);

      final itemOneKey = find.byKey(const Key("1_key"));
      final itemSecondKey = find.byKey(const Key("2_key"));

      expect(itemOneKey, findsOneWidget);
      expect(itemSecondKey, findsOneWidget);
      expect(itemType.first, findsWidgets);
    });

    testWidgets(
        "Deve retornar um estado de sucesso quando obter uma lista barcode vazia",
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: HistoricPageTest()));

      controller.updateState(
          SuccessHistoricState(data: const <FilterBarcodesByDate>[]));

      await tester.pump();

      final historicEmptyKey = find.byKey(const Key("historic_empty_key"));

      expect(historicEmptyKey, findsOneWidget);
    });

    testWidgets('Deve retornar um estado de sucesso quando deletar um barcode',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: HistoricPageTest()));

      final itemOneKey = find.byKey(const Key("1_key"));
      final itemSecondKey = find.byKey(const Key("2_key"));
      final deleteButtonKey = find.byKey(const Key("delete_button_key"));

      expect(itemOneKey, findsOneWidget);
      expect(itemSecondKey, findsOneWidget);

      await tester.tap(deleteButtonKey.first);

      await tester.runAsync(() async {
        await controller.deleteItemInHistoric(1);
      });
      await tester.pump();

      expect(itemOneKey, findsNothing);
      expect(itemSecondKey, findsOneWidget);
    });

    testWidgets('Deve copiar o código quando clicar no botão', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: HistoricPageTest()));

      final copyButtonKey = find.byKey(const Key("copy_button_key"));

      await tester.tap(copyButtonKey.first);

      await tester.runAsync(() async {
        await Clipboard.setData(const ClipboardData(text: "code"));
      });
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
    });
  });
}
