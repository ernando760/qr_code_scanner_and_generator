import 'package:flutter/material.dart';
import 'package:qr_code_scanner_and_generator/src/bar_code_scanner/controllers/camera_controller.dart';

import 'package:qr_code_scanner_and_generator/src/bar_code_scanner/controllers/i_qr_code_controller.dart';
import 'package:qr_code_scanner_and_generator/src/bar_code_scanner/widgets/animated_flip_icon_button_widget.dart';
import 'package:qr_code_scanner_and_generator/src/shared/widgets/base_state_builder.dart';

class FlipCameraButtonWidget extends StatelessWidget {
  const FlipCameraButtonWidget({super.key, required this.controller});
  final CameraController controller;
  @override
  Widget build(BuildContext context) {
    return CameraStateBuilderWidget(
      controller: controller,
      builder: (context, state, _) {
        return AnimatedFlipIconButtonWidget(
            onPressed: () async => await controller.flipCamera(),
            child: const Icon(Icons.flip_camera_android, color: Colors.white));
      },
    );
  }
}

class CameraStateBuilderWidget extends StateBuilder<CameraFacingEnum> {
  const CameraStateBuilderWidget(
      {super.key, required CameraController controller, required super.builder})
      : super(
          controller: controller,
        );
}
