import 'package:qr_code_scanner_and_generator/src/shared/states/base_state.dart';

sealed class FlashState extends BaseState {
  final bool flash;

  FlashState({this.flash = false});
}

final class ToggleFlashState extends FlashState {
  ToggleFlashState({required super.flash});
}
