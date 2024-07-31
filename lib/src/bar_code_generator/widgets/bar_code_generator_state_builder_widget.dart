import 'package:flutter/cupertino.dart';
import 'package:qr_code_scanner_and_generator/src/bar_code_generator/controllers/qr_code_generator_bar_controller.dart';
import 'package:qr_code_scanner_and_generator/src/bar_code_generator/models/bar_code_generator_model.dart';
import 'package:qr_code_scanner_and_generator/src/bar_code_generator/states/bar_code_generator_state.dart';
import 'package:qr_code_scanner_and_generator/src/shared/widgets/base_state_builder.dart';

class BarCodeGeneratorStateBuilderWidget
    extends BaseStateBuilder<BarCodeGeneratorState> {
  BarCodeGeneratorStateBuilderWidget({
    super.key,
    required BarCodeGeneratorBarController controller,
    this.onChangeBarcode,
  }) : super(
            controller: controller,
            builder: (context, state, _) {
              return switch (state) {
                OnChangeBarCodeGeneratorState() =>
                  onChangeBarcode?.call(state.barCodeGeneratorModel) ??
                      Container(),
              };
            });

  final Widget Function(BarCodeGeneratorModel data)? onChangeBarcode;
}
