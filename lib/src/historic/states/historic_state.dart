import 'package:qr_code_scanner_and_generator/src/shared/states/base_state.dart';

sealed class HistoricState extends BaseState {}

final class InitialHistoricState extends HistoricState {}

final class LoadingHistoricState extends HistoricState {}

final class SuccessHistoricState<T> extends HistoricState {
  final T data;

  SuccessHistoricState({required this.data});

  @override
  List<Object?> get props => [data];
}

final class FailureHistoricState extends HistoricState {
  final String messageError;

  FailureHistoricState({required this.messageError});

  @override
  List<Object?> get props => [messageError];
}
