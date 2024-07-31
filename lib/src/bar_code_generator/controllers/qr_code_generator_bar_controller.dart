import 'package:qr_code_scanner_and_generator/src/bar_code_generator/models/bar_code_generator_model.dart';
import 'package:qr_code_scanner_and_generator/src/bar_code_generator/states/bar_code_generator_state.dart';
import 'package:qr_code_scanner_and_generator/src/shared/controllers/base_state_controller.dart';
import 'package:qr_code_scanner_and_generator/src/shared/utils/debouncer_util.dart';

class BarCodeGeneratorBarController
    extends BaseStateController<BarCodeGeneratorState> {
  BarCodeGeneratorModel _barCodeGeneratorModel = BarCodeGeneratorModel.empty();
  final _debouncer = Debouncer(milliseconds: 500);

  BarCodeGeneratorBarController()
      : super(OnChangeBarCodeGeneratorState(
            barCodeGeneratorModel: BarCodeGeneratorModel.empty()));

  void onChangeTextData(String newTextData) {
    _barCodeGeneratorModel =
        _barCodeGeneratorModel.copyWith(textData: () => newTextData);

    updateState(OnChangeBarCodeGeneratorState(
        barCodeGeneratorModel: _barCodeGeneratorModel));
    _debouncer.run(() {
      updateState(OnChangeBarCodeGeneratorState(
          barCodeGeneratorModel: _barCodeGeneratorModel.copyWith(
              qrData: () => _barCodeGeneratorModel.textData)));
    });
  }
}
