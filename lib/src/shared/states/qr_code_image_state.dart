import 'dart:io';

import 'package:qr_code_scanner_and_generator/src/shared/states/base_state.dart';

sealed class QrcodeImageState extends BaseState {}

final class InitialImageState extends QrcodeImageState {}

final class SuccessQrcodeImageState extends QrcodeImageState {
  final File qrcodeFile;

  SuccessQrcodeImageState({required this.qrcodeFile});
}

final class FailureImageState extends QrcodeImageState {
  final String messageError;

  FailureImageState({required this.messageError});

  @override
  List<Object?> get props => [messageError];
}
