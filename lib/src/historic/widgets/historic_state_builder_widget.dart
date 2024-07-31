import 'package:flutter/material.dart';
import 'package:qr_code_scanner_and_generator/src/historic/controllers/historic_controller.dart';
import 'package:qr_code_scanner_and_generator/src/shared/widgets/base_state_builder.dart';
import 'package:qr_code_scanner_and_generator/src/historic/states/historic_state.dart';

class HistoricStateBuilderWidget<T> extends BaseStateBuilder<HistoricState> {
  HistoricStateBuilderWidget(
      {super.key,
      required HistoricController controller,
      this.onInitial,
      this.onLoading,
      this.onSuccess,
      this.onFailure})
      : super(
            controller: controller,
            builder: (context, state, _) {
              return switch (state) {
                InitialHistoricState() => onInitial?.call() ?? Container(),
                LoadingHistoricState() => onLoading?.call() ?? Container(),
                SuccessHistoricState(:final data) =>
                  onSuccess?.call(data) ?? Container(),
                FailureHistoricState(:final messageError) =>
                  onFailure?.call(messageError) ?? Container(),
              };
            });

  final Widget Function()? onInitial;
  final Widget Function()? onLoading;
  final Widget Function(T data)? onSuccess;
  final Widget Function(String messageError)? onFailure;
}
