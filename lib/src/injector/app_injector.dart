import 'package:qr_code_scanner_and_generator/src/injector/barrel/app_injector_barrel.dart';

final appModule = AutoInjector(
  tag: "AppModule",
  on: (injector) {
    injector.addInjector(homeModule);
    injector.addInjector(barcodeScannerModule);
    injector.addInjector(barcodeGeneratorModule);
    injector.addInjector(historicModule);
    injector.commit();
  },
);

final homeModule = AutoInjector(
  tag: "HomeModule",
  on: (injector) {
    injector.addSingleton(BottomNavigationController.new);
  },
);

final barcodeScannerModule = AutoInjector(
  tag: "BarcodeScannerModule",
  on: (injector) {
    injector.addInjector(sharedModule);
    injector.addSingleton(CodeScannerController.new,
        config: BindConfig<CodeScannerController>(
            onDispose: (controller) => controller.dispose()));
  },
);

final barcodeGeneratorModule = AutoInjector(
  tag: "BarcodeGeneratorModule",
  on: (injector) {
    injector.addSingleton(BarCodeGeneratorBarController.new,
        config: BindConfig<BarCodeGeneratorBarController>(
            onDispose: (controller) => controller.dispose()));
  },
);

final historicModule = AutoInjector(
  tag: "HistoricModule",
  on: (injector) {
    injector.addInjector(sharedModule);
    injector.add<IHistoricRepository>(HistoricRepositoryImpl.new);
    injector.add<IHistoricService>(HistoricServiceImpl.new);
    injector.addSingleton(HistoricController.new,
        config: BindConfig<HistoricController>(
            onDispose: (controller) => controller.dispose()));
  },
);

final sharedModule = AutoInjector(
  tag: "SharedModule",
  on: (injector) {
    injector.add<IDatabase>(SqfliteDatabaseImpl.new);
    injector.add<IPermissionService>(PermissionServiceImpl.new);
    injector.add<IQrcodeImageService>(QrCodeImageServiceImpl.new);
    injector.addSingleton(QrCodeImageController.new,
        config: BindConfig<QrCodeImageController>(
            onDispose: (controller) => controller.dispose()));
  },
);
