import 'package:flutter/material.dart';
import 'package:qr_code_scanner_and_generator/src/shared/controllers/base_state_controller.dart';
import 'package:qr_code_scanner_and_generator/src/shared/states/base_state.dart';

class BaseStateBuilder<S extends BaseState> extends StateBuilder<S> {
  const BaseStateBuilder(
      {super.key, required super.controller, required super.builder});
}

class StateBuilder<S> extends StatelessWidget {
  const StateBuilder(
      {super.key, required this.controller, required this.builder, this.child});
  final BaseController<S> controller;
  final Widget Function(BuildContext context, S state, Widget? child) builder;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => builder(context, controller.state, child),
      child: child,
    );
  }
}
