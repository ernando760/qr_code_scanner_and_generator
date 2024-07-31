import 'package:qr_code_scanner_and_generator/src/shared/models/bar_code_model.dart';
import 'package:qr_code_scanner_and_generator/src/shared/states/base_state.dart';

class CodeScannerState extends BaseState {
  final BarcodeModel barcode;

  CodeScannerState({required this.barcode});
}

class EmptyBarcodeCodeScannerState extends CodeScannerState {
  EmptyBarcodeCodeScannerState() : super(barcode: BarcodeModel.empty());
}

class ScannedBarcodeCodeScannerState extends CodeScannerState {
  ScannedBarcodeCodeScannerState({required super.barcode});

  @override
  List<Object?> get props => [barcode];
}
