import 'package:qr_code_scanner_and_generator/src/bar_code_generator/models/bar_code_generator_model.dart';
import 'package:qr_code_scanner_and_generator/src/shared/states/base_state.dart';

sealed class BarCodeGeneratorState extends BaseState {
  final BarCodeGeneratorModel barCodeGeneratorModel;

  BarCodeGeneratorState({required this.barCodeGeneratorModel});
}

final class OnChangeBarCodeGeneratorState extends BarCodeGeneratorState {
  OnChangeBarCodeGeneratorState({required super.barCodeGeneratorModel});

  @override
  List<Object?> get props => [barCodeGeneratorModel];
}
