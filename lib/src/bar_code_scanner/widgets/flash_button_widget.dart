import 'package:flutter/material.dart';

import 'package:qr_code_scanner_and_generator/src/bar_code_scanner/controllers/flash_controller.dart';
import 'package:qr_code_scanner_and_generator/src/shared/widgets/base_state_builder.dart';

class FlashButtonWidget extends StatelessWidget {
  const FlashButtonWidget({super.key, required this.controller});
  final FlashController controller;
  @override
  Widget build(BuildContext context) {
    return FlashStateBuilderWidget(
      controller: controller,
      builder: (context, state, child) {
        return IconButton(
            onPressed: controller.toggleFlash,
            icon: state
                ? const Icon(Icons.flash_on, color: Colors.yellow)
                : const Icon(Icons.flash_off, color: Colors.grey));
      },
    );
  }
}

class FlashStateBuilderWidget extends StateBuilder<bool> {
  const FlashStateBuilderWidget(
      {super.key, required FlashController controller, required super.builder})
      : super(
          controller: controller,
        );
}
